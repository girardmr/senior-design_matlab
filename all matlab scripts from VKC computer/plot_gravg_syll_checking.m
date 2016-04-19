 % plot grandaverage TFRs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010

clear all; clc

load hydro65.lay.mat

bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';

ext = '_L_gravg_mblc_ind_rs.mat';

load(cat(2,bin{1},ext));
bin1 = TFgravg_ind;
clear TFgravg_ind

load(cat(2,bin{2},ext));
bin2 = TFgravg_ind;
clear TFgravg_ind

load(cat(2,bin{3},ext));
bin3 = TFgravg_ind;
clear TFgravg_ind


%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];
cfg.layout = hydro65lay; 

cfg.xparam = 'time';
cfg.yparam = 'freq';
cfg.zparam = 'powspctrm';
cfg.xlim = [-0.100 0.300]; % time
%cfg.zlim = [-3 3] % power scale
cfg.ylim = [13 50]; % 
cfg.interactive  = 'yes';
cfg.showlabels   = 'yes';
cfg.colorbar = 'yes';

figure
ft_multiplotTFR(cfg, bin1)
title('SS - induced')
%saveas(gcf,'Standardgrandaverageinduced','fig')

figure
ft_multiplotTFR(cfg, bin2)
title('WS - induced')
%saveas(gcf,'Targetgrandaverageinduced','fig')

figure
ft_multiplotTFR(cfg, bin3)
title('SW - induced')
%saveas(gcf,'Novelgrandaverageinduced','fig')



%% Single channel plot - Cz

figure

%cfg.channel = 'Cz';
cfg.colorbar = 'no'; % same scale is used in multichannel plots

subplot(2,3,1)
ft_singleplotTFR(cfg,bin1)

time4ticks = [-0.100:0.100:0.300]; %% %% times on axis where you want ticks 
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

saveas(gcf, 'induced grand average Cz', 'fig'); % save as a Matlab Figure file
saveas(gcf, 'induced grand average Cz', 'tif'); % save as a tiff file



