%TUTORIAL - WAVELETS
%calculate power with wavelets on dap data
%rlg 1 feb 2012 
% took 7 min
clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03'; %S{4} = 'dap_05';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='loud_tone';
bin{2}='omit_tone';


%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_trials.mat')
        load(filename)
        SampRate = data.fsample %finds the sampling rate of this dataset and finds timestep for analysis

        cfg = [];
        %cfg.channel= ; %no need to specify chan, it takes all by default
        cfg.lpfilter      = 'yes'; % lowpass filter
        cfg.lpfreq        = 58;
        data_lp = ft_preprocessing(cfg,data);
        %data_lp = ft_preproc_lowpassfilter(data.trial, data.fsample, 55); % apply low-pass filter - 55Hz
        
        cfg = [];
        cfg.removemean  = 'no';
        data_ERP = ft_timelockanalysis(cfg, data_lp); % compute ERP to be saved, and used for evoked
        
        outfile_4evo = cat(2,suj,'_',bin{b},'_ERP.mat')
        save (outfile_4evo,'data_ERP');
        
        clear data data_lp
        %% then run wavelet on ERP data
        
                
         timestep = 1/SampRate; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        cfg = [];
        cfg.method  = 'wavelet';
        cfg.width   =  6; %this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 8:1:58; %frequencies of interest - 
        cfg.toi     = -0.899:timestep:0.901;    %time of interest CAREFUL - time in seconds, 4ms   %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')

        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP  outfile TFRwave_evo
    end
    clear filename
end

toc

