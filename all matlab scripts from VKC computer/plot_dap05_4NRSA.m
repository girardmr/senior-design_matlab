clear all

load dap_05_omit_tone_tfr_ind.mat

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;
cfg.layout = layout
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [-0.300 0.300] % time 0 to 600ms
cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [15 50] %
%cfg.zlim = 'maxmin' %
cfg.zlim = [0.80 1.2] %
cfg.baseline = [-0.900 0.900];
cfg.baselinetype = 'relative';
cfg.comment = 'no';
% figure
% ft_multiplotTFR(cfg,TFRwave_ind)
time4ticks = [-0.300:0.150:0.300]; 

figure
subplot(2,2,1)
ft_singleplotTFR(cfg,TFRwave_ind)
%saveas(gcf, 'dap05omittedtoneTFR', 'tif');


set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
title('Time Frequency representation')


cfg.xlim = [0 0.050]
subplot(2,2,2)
ft_topoplotTFR(cfg,TFRwave_ind)
title('Scalp topography of Beta/Gamma, 0-50ms')
saveas(gcf, 'dap05omittedtoneBOTH', 'tif');