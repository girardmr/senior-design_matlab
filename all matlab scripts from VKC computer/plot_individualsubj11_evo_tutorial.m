% plot individual TFR's for 3 conditions in the tutorial
% rlg november 2010 EVOKED

%% 
clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

standard = load('chords_tut_subj18_stnd_tfr_avblc_evo.mat'); 
target = load('chords_tut_subj18_trgt_tfr_avblc_evo.mat');
novel = load('chords_tut_subj18_novl_tfr_avblc_evo.mat');

%% multichannel
cfg.layout = layout
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600] % time 0 to 600ms
cfg.zlim = [-5 5] % power scale
cfg.ylim = [4 25] % theta, alpha, and beta frequencies
cfg.interactive = 'yes';

figure
ft_multiplotTFR(cfg,standard.TFRwave_evo)
title('standard - evoked - suj18')
saveas(gcf, 'standardsuj18evo', 'tif'); % save as a tiff file

figure
ft_multiplotTFR(cfg,target.TFRwave_evo)
title('target - evoked - suj18')
saveas(gcf, 'targetsuj18evo', 'tif'); % save as a tiff file

figure
ft_multiplotTFR(cfg,novel.TFRwave_evo)
title('novel - evoked - suj18')
saveas(gcf, 'novelsuj18evo', 'tif'); % save as a tiff file


% one channel
cfg.channel = 'Cz';

figure
ft_singleplotTFR(cfg, standard.TFRwave_evo)
title('standard - evoked - suj18 - Cz')

time4ticks = [0:0.200:0.600]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
saveas(gcf, 'standardsuj18evoCz', 'tif'); % save as a tiff file

figure
ft_singleplotTFR(cfg, target.TFRwave_evo)
title('target - evoked - suj18 - Cz')
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
saveas(gcf, 'targetsuj18evoCz', 'tif'); % save as a tiff file


figure
ft_singleplotTFR(cfg, novel.TFRwave_evo)
title('novel - evoked - suj18 - Cz')
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
saveas(gcf, 'novelsuj18evoCz', 'tif'); % save as a tiff file




%%

