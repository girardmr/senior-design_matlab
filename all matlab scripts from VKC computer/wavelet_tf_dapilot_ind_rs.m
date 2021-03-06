% dynatt pilot data
%calculate power with wavelets on trial data (induced)  data
%took about 38 min.
%rlg 28 feb 2011

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='loud_tone';
bin{2}='omit_tone';


%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_trials.mat')
        load(filename)
        
        timestep = 1/data.fsample; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        %low-pass filter here
        %data_lp = ft_preproc_lowpassfilter(data, data.fsample, 55); % apply low-pass filter - 55Hz
        %          cfg = [];
        %         cfg.lpfilter      = 'yes'; % lowpass filter
        %         cfg.lpfreq        = 55;
        %         data_lp = ft_preprocessing(cfg,data);
        
        cfg = [];
        %        cfg.channel= ;
        
        if b == 1; % bin 1
            load(cat(2,suj,'_trialindices_rs_loud_tone.mat'));

            cfg.trials = resamp_tri
            clear resamp_tri
            
        elseif b == 2
            cfg.trials = 'all';
        end
        
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 8:1:75; %frequencies of interest -
        cfg.toi     = -0.899:timestep:0.901;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_ind.mat')
        save(outfile,'TFRwave_ind');
        clear data data_lp outfile TFRwave_ind
    end
    clear filename
end

toc

