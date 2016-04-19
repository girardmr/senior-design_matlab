%TUTORIAL SCRIPT
%calculate power with wavelets on trial data (induced)
%took about ? minutes to complete for all ? subjects
%rlg 13 dec 2011

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line


%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'CDTword_',suj,'_',bin{b},'_trials.mat')
        load(filename)
        
        
        % no need to downsample, as we now upsampled that one participant.
%         %first downsample to 250
%         cfg = [];
%         cfg.resamplefs = 250;
%         cfg.detrend    = 'no';
%         data_rs = ft_resampledata(cfg, data)
%         
        cfg = [];
        %cfg.channel= ; %no need to specify chan, it takes all by default
        cfg.lpfilter      = 'yes'; % lowpass filter
        cfg.lpfreq        = 58;
        data_lp = ft_preprocessing(cfg,data);
        %data_lp = ft_preproc_lowpassfilter(data.trial, data.fsample, 55); % apply low-pass filter - 55Hz
        clear data
        
        SampRate = data_lp.fsample % get sampling rate
        
        timestep = 1/SampRate; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        cfg = [];
        cfg.removemean  = 'no';
        data_ERP = ft_timelockanalysis(cfg, data_lp); % compute ERP to be saved, and used for evoked
        
        clear data_lp data_rs
        cfg = [];
        
        cfg.method  = 'wavelet';
        cfg.width   =  5; %this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:55; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.100:timestep:0.800;    %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        
        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_CDT_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP outfile TFRwave_evo
    end
    clear filename
end

toc

