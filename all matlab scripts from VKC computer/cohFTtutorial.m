

%% FFT
cfg            = [];
cfg.output     = 'fourier';
cfg.method     = 'mtmfft';
cfg.foilim     = [5 100];
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
cfg.channel    = {'MEG' 'EMGlft' 'EMGrgt'};
freqfourier    = ft_freqanalysis(cfg, data);


%% connectivity - coherence between MEG channels and each EMG
cfg            = [];
cfg.method     = 'coh';
cfg.channelcmb = {'MEG' 'EMG'};
fdfourier      = ft_connectivityanalysis(cfg, freqfourier);


%% plotting
cfg                  = [];
cfg.xparam           = 'freq';
cfg.zparam           = 'cohspctrm';
cfg.xlim             = [5 80];
cfg.cohrefchannel    = 'EMGlft';
cfg.layout           = 'CTF151.lay';
cfg.showlabels       = 'yes';
figure; ft_multiplotER(cfg, fdfourier)