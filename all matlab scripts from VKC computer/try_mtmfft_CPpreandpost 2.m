% trying out fourier analysis
% took about 2 min.
% changed some parameters

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects - CP1 pre and post
S{1}='01_pre'; S{2}='02_pre'; S{3}='03_pre'; S{4}='04_pre'; S{5}='05_pre';
S{6}='06_pre'; S{7}='07_pre'; S{8}='08_pre'; S{9}='09_pre'; S{10}='10_pre';

S{11}='01_post'; S{12}='02_post'; S{13}='03_post';  S{14}='04_post'; S{15}='05_post';
S{16}='06_post'; S{17}='07_post'; S{18}='08_post';  S{19}='09_post';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='snd'; % all 3 bins together
% bin{2}='UnfamVoiceParent';
% bin{3}='UnfamVoiceConstant';

%% calculate fft

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'CP',suj,'_',bin{b},'_trials.mat')
        load(filename)
        
        %timestep = 1/data.fsample; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        %low-pass filter here
        %data_lp = ft_preproc_lowpassfilter(data, data.fsample, 55); % apply low-pass filter - 55Hz
        %          cfg = [];
        %         cfg.lpfilter      = 'yes'; % lowpass filter
        %         cfg.lpfreq        = 55;
        %         data_lp = ft_preprocessing(cfg,data);
        %datashort = ft_selectdata(data,'toilim',[0 1]) %no because using whole epoch in this data
        %clear data
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'mtmfft';
        %cfg.width   =  5; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'fourier';
        cfg.taper   = 'hanning';
        cfg.tapsmofrq  = 4;
        cfg.foi     = 4:1:54; %frequencies of interest -
        %cfg.toilim     = [0 1] % just first 1000ms, but I'm not sure if it does this.
        %if not... try ft_selectdata(data,'toilim',[0 1])
        %         cfg.foi     = 8:1:35; %frequencies of interest -
        %cfg.toi     = 0:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'yes'; %return individual trials or average (default = 'no')
        % IT'S REALLY FFT NOT CSD
        %CSDdata = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        FFTdata = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        
        outfile= cat(2,'CP',suj,'_',bin{b},'_fft.mat')
        
        save(outfile,'FFTdata');
        clear dat  outfile FFTdata
    end
    clear filename
end

toc

