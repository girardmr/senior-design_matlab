clear all; clc

load tut_layout.mat % this layout excludes EOG channels
load chords_tut_subj08_stnd_tfr_evo.mat % load single subject, one condition

cfg.layout = EGI_layout129;
cfg.xparam = 'time';
cfg.yparam = 'freq';
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600]; % time 0 to 600ms
cfg.zlim = [0 50]; % power scale - default
cfg.ylim = [4 25]; % theta, alpha, and beta frequencies
cfg.interactive = 'yes';

figure
ft_multiplotTFR(cfg, TFRwave_evo)
title('standard - evoked - suj08 - RAW')
saveas(gcf, 'standardsuj08evoRAW', 'tif'); % save as a tiff file
