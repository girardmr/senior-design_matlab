%TUTORIAL - WAVELETS
%calculate power with wavelets on MAP data
%rlg 11 Feb 2011 
% took 7 min
clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %

SampRate = 250;
%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'MAP_',suj,'_',bin{b},'_trials.mat')
        load(filename)
     
        cfg = [];
        %cfg.channel= ; %no need to specify chan, it takes all by default
        cfg.lpfilter      = 'yes'; % lowpass filter
        cfg.lpfreq        = 55;
        data_lp = ft_preprocessing(cfg,data);
        %data_lp = ft_preproc_lowpassfilter(data.trial, data.fsample, 55); % apply low-pass filter - 55Hz
        SampRate = data.fsample; % get sampling rate

        cfg = [];
        cfg.removemean  = 'no';
        data_ERP = ft_timelockanalysis(cfg, data_lp); % compute ERP to be saved, and used for evoked
        
        outfile_4evo = cat(2,suj,'_MAP_',bin{b},'_ERP.mat')
        save (outfile_4evo,'data_ERP');
        
        clear data data_lp
        %% then run wavelet on ERP data
        
                
        timestep = 1/SampRate; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        cfg = [];
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:50; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.400:timestep:0.800;    %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')

        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_MAP_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP  outfile TFRwave_evo
    end
    clear filename
end

toc

