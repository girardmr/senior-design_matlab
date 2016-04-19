clear all; clc
%load tut_layout.mat % this layout excludes EOG channels 

load chords_tut_subj08_stnd_tfr_evo.mat % load single subject, one condition

%cfg.layout = EGI_layout129; 
%cfg.xparam = 'time'; % plots time on the x-axis 
%cfg.yparam = 'freq'; % plots frequency on the y-axis 
cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [0 0.600]; % time 0 to 600ms 
cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [4 25]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
% figure 
% ft_multiplotTFR(cfg, TFRwave_evo) 
% title('standard - evoked - suj08 - RAW') 
% saveas(gcf, 'standardsuj08evoRAW', 'jpg'); % save as a jpg file

%% now just 10-20 positions
% use only this for new tutorial, but include plotting all channels as an
% option in practice

load chords_tut_subj08_stnd_tfr_evo.mat % load single subject, one condition


load EGI129_1020lay.mat % load layout file - contains only 10-20 equivalent channels
cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [0 0.600]; % time 0 to 600ms 
cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [4 25]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
cfg.zlim = [0 50];
cfg.showlabels = 'yes'
cfg.colorbar = 'yes';

figure 
ft_multiplotTFR(cfg, TFRwave_evo) 
title('standard - evoked - suj08 - RAW zlim050 - 1020') 
saveas(gcf, 'standardsuj08evoRAW1020', 'jpg');


%% add plotting with a baseline here:
cfg = [];
cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'; % plots the power spectrum on the colorscale 
cfg.xlim = [0 0.600]; % time 0 to 600ms 
cfg.zlim = 'maxmin'; % power scale - default 
cfg.ylim = [4 25]; % theta, alpha, and beta frequencies 
cfg.interactive = 'yes';
cfg.zlim = [-1 9]; % determine iteratively
cfg.showlabels = 'yes'
cfg.colorbar = 'yes';
cfg.baseline = 'yes'
cfg.baselinetype = 'relchange';

figure 
ft_multiplotTFR(cfg, TFRwave_evo) 
title('standard - evoked - suj08 - base - 1020') 
saveas(gcf, 'standardsuj08evoRAW1020', 'jpg');


