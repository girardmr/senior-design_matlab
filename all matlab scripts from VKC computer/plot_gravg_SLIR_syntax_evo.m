% plot grandaverage TFRs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';

load(cat(2,bin{1},'_syntax_gravg_avblc_evo.mat'));
bin1 = TFgravg_evo;
clear TFgravg_evo

load(cat(2,bin{2},'_syntax_gravg_avblc_evo.mat'));
bin2 = TFgravg_evo;
clear TFgravg_evo

load(cat(2,bin{3},'_syntax_gravg_avblc_evo.mat'));
bin3 = TFgravg_evo;
clear TFgravg_evo

load(cat(2,bin{4},'_syntax_gravg_avblc_evo.mat'));
bin4 = TFgravg_evo;
clear TFgravg_evo


%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

cfg.xparam = 'time';
cfg.yparam = 'freq';
cfg.zparam = 'powspctrm';
cfg.xlim = [0 0.600]; % time
cfg.zlim = [-3 3] % power scale
cfg.ylim = [4 25]; % 
cfg.interactive  = 'yes';
cfg.showlabels   = 'yes';
cfg.colorbar = 'yes';
cfg.layout = layout; %use this if plotting positive up

figure
ft_multiplotTFR(cfg, bin1)
title('Sentence-Verb-Correct - evoked')
saveas(gcf,'SVA_corr_grandaverageevoked','fig')

figure
ft_multiplotTFR(cfg, bin2)
title('Sentence-Verb-violation - evoked')
saveas(gcf,'SVA_viol_grandaverageevoked','fig')

figure
ft_multiplotTFR(cfg, bin3)
title('Tense-Correct - evoked')
saveas(gcf,'TEN_corr_grandaverageevoked','fig')

figure
ft_multiplotTFR(cfg, bin4)
title('Tense-violation - evoked')
saveas(gcf,'TEN_viol_grandaverageevoked','fig')



%% Single channel plot - Cz

figure

cfg.channel = 'Cz';
cfg.colorbar = 'no'; % same scale is used in multichannel plots

subplot(2,3,1)
ft_singleplotTFR(cfg,bin1)

time4ticks = [0:0.200:0.600]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')
title(bin{1})


subplot(2,3,2)
ft_singleplotTFR(cfg,bin2)
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% xlabel('Time (ms)')
% ylabel('Amplitude')
title(bin{2})

subplot(2,3,3)
ft_singleplotTFR(cfg,bin3)
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% xlabel('Time (ms)')
% ylabel('Amplitude')
title(bin{3})

subplot(2,3,3)
ft_singleplotTFR(cfg,bin4)
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% xlabel('Time (ms)')
% ylabel('Amplitude')
title(bin{4})

saveas(gcf, 'Evoked grand average Cz, SLIR_syntax', 'fig'); % save as a Matlab Figure file
saveas(gcf, 'Evoked grand average Cz, SLIR_syntax', 'jpg'); % save as a tiff file



