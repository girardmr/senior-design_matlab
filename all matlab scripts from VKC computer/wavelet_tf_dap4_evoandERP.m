%dynatt pilot
%calculate power with wavelets on dap data
%rlg 2 feb 2012 % took 1 min with 4 subjects

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
%S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';
S{1}='dap4_02'; % just CLM-G, dap4

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regular';
bin{2}='irregular';


%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_trials.mat')
        load(filename)
     
        SampRate = data.fsample %finds the sampling rate of this dataset and finds timestep for analysis

%         cfg = [];
%         %cfg.channel= ; %no need to specify chan, it takes all by default
%         cfg.lpfilter      = 'yes'; % lowpass filter
%         cfg.lpfreq        = 55;
%         data_lp = ft_preprocessing(cfg,data);
%         %data_lp = ft_preproc_lowpassfilter(data.trial, data.fsample, 55); % apply low-pass filter - 55Hz
%         SR = data.fsample;

        % calculate ERP
        cfg = [];
        cfg.removemean  = 'no';
        data_ERP = ft_timelockanalysis(cfg, data); % compute ERP to be saved, and used for evoked
        
        outfile_4evo = cat(2,suj,'_',bin{b},'_ERP.mat')
        save (outfile_4evo,'data_ERP');
        
        clear data data_lp
        %% then run wavelet on ERP data
        
        timestep = 1/SampRate        
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'wavelet';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:75; %frequencies of interest - try step of 2Hz here
        cfg.toi     = -0.150:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no') (default = 'no')

        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP  outfile TFRwave_evo
    end
    clear filename
end

toc

