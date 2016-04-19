%TUTORIAL - WAVELETS
%calculate power with wavelets on CDT data
%rlg 13 dec 2011 
% took 1 min
clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

%SampRate = 250;
%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'CDTword_',suj,'_',bin{b},'_trials.mat')
        load(filename)
        
             %first downsample to 250
        cfg = [];
        cfg.resamplefs = 250;
        cfg.detrend    = 'no';
        data_rs = ft_resampledata(cfg, data)
         
        cfg = [];
        %cfg.channel= ; %no need to specify chan, it takes all by default
        cfg.lpfilter      = 'yes'; % lowpass filter
        cfg.lpfreq        = 20;
        data_lp = ft_preprocessing(cfg,data_rs);
        %data_lp = ft_preproc_lowpassfilter(data.trial, data.fsample, 55); % apply low-pass filter - 55Hz
       

        SampRate = data_lp.fsample % get sampling rate
        
        cfg = [];
        cfg.removemean  = 'no';
        data_ERP = ft_timelockanalysis(cfg, data_lp); % compute ERP to be saved, and used for evoked
        
        outfile_4evo = cat(2,suj,'_CDT_',bin{b},'_ERP.mat')
        save (outfile_4evo,'data_ERP');
        
        clear data data_lp
        %% then run wavelet on ERP data
                        
        timestep = 1/SampRate; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        cfg = [];
        cfg.method  = 'wltconvol';
        cfg.width   =  4; %this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:20; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.100:timestep:0.800;    %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')

        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_CDT_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP  outfile TFRwave_evo
    end
    clear filename
end

toc

