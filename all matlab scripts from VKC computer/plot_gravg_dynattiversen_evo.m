clear all; clc

load EGI129_1020lay.mat % load layout file - contains only 10-20 equivalent channels
%cat(2,'dynattiversen_',bin{b}, '_gravg_4sTLD_avblc_evo.mat');
Phy1 = load('dynattiversen_PhyAcc1_gravg_4sTLD_avblc_evo.mat');

cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [-0.150 0.750]; % time  
%cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [13 55]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
cfg.zlim = [-2 2];
cfg.showlabels = 'yes';
cfg.colorbar = 'yes';

figure 
ft_multiplotTFR(cfg, Phy1.TFgravg_evo) 
title('gravg 4s PhyAcc1 evo') 
saveas(gcf, 'gravg4sPhyAcc1_evo', 'jpg');


%%

Phy2 = load('dynattiversen_PhyAcc2_gravg_4sTLD_avblc_evo.mat');


cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [-0.150 0.350]; % time 0 to 600ms 
%cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [13 55]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
cfg.zlim = [-2 2];

cfg.showlabels = 'yes'
cfg.colorbar = 'yes';

figure 
ft_multiplotTFR(cfg, Phy2.TFgravg_evo) 
title('gravg 4s PhyAcc2 evo') 
saveas(gcf, 'gravg4s Phyacc2_evo', 'jpg');


