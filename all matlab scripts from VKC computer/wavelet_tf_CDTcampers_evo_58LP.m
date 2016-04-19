%TUTORIAL SCRIPT
%calculate power with wavelets on trial data (induced)
%took about ? minutes to complete for all ? subjects
%rlg 13 dec 2011

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line


%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; S{17} = 'W725';
S{18}='W824'; S{19}='W825'; S{20}='W826'; S{21}='W827'; S{22}='W828'; 
S{23}='W829'; S{24}='W830';

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

