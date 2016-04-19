% trying out fourier analysis
% took about 2 min.

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='07'; S{2}='08'; S{3}='09'; S{4}='10'; S{5}='11'; S{6}='14'; S{7}='16';
S{8}='17'; S{9}='18'; S{10}='19'; S{11}='20'; S{12}='21'; S{13}='22'; S{14}='23';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='FamVoice';
bin{2}='UnfamVoiceParent';
bin{3}='UnfamVoiceConstant';

%% calculate crossspectral density

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'voices',suj,'_',bin{b},'_trials.mat')
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
        datashort = ft_selectdata(data,'toilim',[0 1]) %just first 1000ms,
        clear data
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'mtmfft';
        %cfg.width   =  5; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'fourier';
        cfg.tapsmofrq  = 4;
        cfg.foilim     = [4 54]; %frequencies of interest -
        %cfg.toilim     = [0 1] % just first 1000ms, but I'm not sure if it does this. 
        %if not... try ft_selectdata(data,'toilim',[0 1])
        %         cfg.foi     = 8:1:35; %frequencies of interest -
        %cfg.toi     = 0:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'yes'; %return individual trials or average (default = 'no')
        % IT'S REALLY FFT NOT CSD
        %CSDdata = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        FFTdata = ft_freqanalysis(cfg, datashort); % use data_lp if we did low-pass fileter

        outfile= cat(2,'voices',suj,'_',bin{b},'_fft.mat')
        
        save(outfile,'FFTdata');
        clear datashort  outfile FFTdata
    end
    clear filename
end

toc

