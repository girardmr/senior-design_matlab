clear all; clc

load EGI129_1020lay.mat % load layout file - contains only 10-20 equivalent channels

Reg = load('dap3_regular_gravg_4s_spblc_evo.mat');

cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [-0.150 0.350]; % time  
%cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [13 55]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
cfg.zlim = [-2 2];
cfg.showlabels = 'yes';
cfg.colorbar = 'yes';

figure 
ft_multiplotTFR(cfg, Reg.TFgravg_evo) 
title('gravg 4s regular evo') 
saveas(gcf, 'gravg4sregularevospblc', 'jpg');


%%

Irr = load('dap3_irregular_gravg_4s_spblc_evo.mat');


cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [-0.150 0.350]; % time 0 to 600ms 
cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [13 55]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
cfg.zlim = [-2 2];

cfg.showlabels = 'yes'
cfg.colorbar = 'yes';

figure 
ft_multiplotTFR(cfg, Irr.TFgravg_evo) 
title('gravg 4s irregular evo') 
saveas(gcf, 'gravg4sirregularevospblc', 'jpg');


