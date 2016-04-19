load hydro65.lay.mat


cfg.layout = hydro65lay; 
cfg.xparam = 'time'; % plots time on the x-axis 
cfg.yparam = 'freq'; % plots frequency on the y-axis 
cfg.zparam = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [-0.100 0.500]; % time 0 to 600ms 
%cfg.zlim = 'maxmin'; % power scale - default 
cfg.zlim = [0 10]; % power scale - default 
cfg.baseline = [-0.250 -0.100];
cfg.baselinetype     =  'relative';
cfg.ylim = [13 50]; % 
cfg.interactive = 'yes';
figure 
ft_multiplotTFR(cfg, TFRwave_evo)