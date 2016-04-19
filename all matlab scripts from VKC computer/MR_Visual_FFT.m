% trying out fourier analysis
% took about 2 min.
% changed some parameters

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects
S{1}='01';  S{2}='04'; S{3}='05'; S{4}='06';  S{5}='07'; S{6}='08'; S{7}='09'; S{8}='10'; S{9}='12'; S{10}='14'; S{11}='17'; S{12}='18'; S{13}='19'; S{14}='20';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='SameNear';
bin{2}='SameFar';
bin{3}='DifferentNear';
bin{4}='DifferentFar';

%% calculate fft

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'MR_Visual',suj,'_',bin{b},'_trials.mat')
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
        cfg.output  = 'pow';
        cfg.taper   = 'hanning';
        cfg.tapsmofrq  = 4;
        cfg.foi     = 4:1:54; %frequencies of interest -
        %cfg.toilim     = [0 1] % just first 1000ms, but I'm not sure if it does this.
        %if not... try ft_selectdata(data,'toilim',[0 1])
        %         cfg.foi     = 8:1:35; %frequencies of interest -
        %cfg.toi     = 0:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        % IT'S REALLY FFT NOT CSD
        %CSDdata = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        FFTdata = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        
        outfile= cat(2,'MR_Visual',suj,'_',bin{b},'_fft.mat')
        
        save(outfile,'FFTdata');
        clear dat  outfile FFTdata
    end
    clear filename
end

toc

