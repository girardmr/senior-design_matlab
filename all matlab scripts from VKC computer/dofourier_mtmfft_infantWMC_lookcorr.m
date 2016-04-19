% trying out fourier analysis
% took about 2 min.
% changed some parameters

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects - CP1 pre and post
S{1}='HM19'; S{2}='HM32'; S{3}='HM42'; S{4}='HM43'; S{5}='HM47'; S{6}='HM48';
S{7}='HM66'; S{8}='HM90'; % don't use HM62 because too few trials

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='task_lookandcorr'; % all 3 bins together
bin{2}='base';


%% calculate fft

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_trials.mat')
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
        
                % FILTER
        
        cfg = [];
        %cfg.channel= ; %no need to specify chan, it takes all by default
        cfg.bpfilter      = 'yes'; % bandpass filter
        cfg.bpfreq        = [3 30];
        data_fil = ft_preprocessing(cfg,data);
        
        % FFT
        cfg = [];
        cfg.pad    = 'maxperlen';
        cfg.method  = 'mtmfft';
        cfg.output  = 'fourier';
        cfg.taper   = 'hanning';
        cfg.tapsmofrq  = 2;
        cfg.foilim     = [6 12]; %frequencies of interest -
        %cfg.toilim     = [0 1] % just first 1000ms, but I'm not sure if it does this.
        %if not... try ft_selectdata(data,'toilim',[0 1])
        %         cfg.foi     = 8:1:35; %frequencies of interest -
        %cfg.toi     = 0:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        %cfg.keeptrials = 'yes'; %return individual trials or average (default = 'no')
        % IT'S REALLY FFT NOT CSD
        %CSDdata = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        FFTdata = ft_freqanalysis(cfg, data_fil); % use data_lp if we did low-pass fileter
        
        outfile= cat(2,suj,'_',bin{b},'_fft.mat')
        
        save(outfile,'FFTdata');
        clear data outfile FFTdata data_fil
    end
    clear filename
end

toc

