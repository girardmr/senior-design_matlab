% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg modified 12 dec 2011

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

condname{1}='Word Rhythm Congruous';
condname{2}='Word Rhythm Incongruous';


%% set up configuration

%load tut_layout.mat % this layout excludes EOG channels
%layout = EGI_layout129;

%cfg.layout = layout
cfg.interactive = 'no';
%cfg.layout = EGI_layout129;
% cfg.baseline = [-0.250 -0.100];
cfg.channel = 'E62'; %Pz

cfg.parameter  = 'avg';
cfg.xlim    = [-0.100 1.000];%time in seconds
cfg.ylim    = [-2 2];
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
cfg.projection = 'polar'; % comment out if plotting positive up
cfg.rotate = 180; % comment out if plotting positive up
upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
cfg.layout = upsidedown; % comment out if plotting positive up
%cfg.layout = layout; use this if plotting positive up


%%

for b=1:length(bin) %for each condition specified above
    
    filename = cat(2,'CDTword_campers_',bin{b}, '_gravg_ERP.mat'); %load filtered baseline corr ERPs
    load(filename)
    gravgdata.(bin{b}) = ERPgravg;
    clear data
    
end

figure

%% first set
%subplot(2,2,1)

ft_singleplotER(cfg,gravgdata.(bin{1}),gravgdata.(bin{2}))
set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
time4ticks = [0:0.200:1.000]; %% %% times on axis where you want ticks
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')
title('Electrode Pz')
legend(condname{1},condname{2},'Location','NorthEast')
legend(gca,'boxoff')


%just for legend
% subplot(2,2,3)
% ft_singleplotER(cfg,gravgdata.(bin{1}),gravgdata.(bin{2}))
% legend(condname{1},condname{2},'Location','NorthEast')
% 
% %     subplot(2,3,3)
%     ft_singleplotER(cfg,gravgdata.(bin{7}),gravgdata.(bin{8}),gravgdata.(bin{9}))
%     set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%     %just for legend
%     subplot(2,3,6)
%     ft_singleplotER(cfg,gravgdata.(bin{7}),gravgdata.(bin{8}),gravgdata.(bin{9}))
%
%     legend(condname{7},condname{8},condname{9},'Location','North')
%
%
%

%suplabel('CDT gravg campers','t')

outfilename = 'CDT gravg campers ERP - Pz'

saveas(gcf, outfilename, 'jpg')
saveas(gcf, outfilename, 'fig')

% %% multiplot
% cfg.channel = 'all'
% cfg.parameter  = 'avg';
% cfg.showlabels  = 'yes'; %show channel labels
% cfg.interactive = 'yes';

% %% multiplot
% figure
% load EGI129_1020lay.mat % load layout file - contains only 10-20 equivalent channels
% cfg.layout = EGI_lay1020;
% 
% ft_multiplotER(cfg,gravgdata.(bin{1}),gravgdata.(bin{2}))
% set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
% 
% 
% saveas(gcf, 'ERP gravg music, CDT campers', 'fig'); % save as a Matlab Figure file
% saveas(gcf, 'ERP gravg music, CDT campers', 'jpg'); % save as a jpgf file
% 
% 
% %% OLD SCRIPT from tutorial
% 
% %% INTERACTIVE PLOT - ALL CHANNELS
% % cfg = [];
% % 
% % %cfg.layout = ft_prepare_layout(elec);
% % cfg.zparam  = 'avg';
% % cfg.xlim    = [-0.100 0.700];%time in seconds
% % cfg.showlabels  = 'yes'; %show channel labels
% % cfg.interactive = 'yes';
% % 
% % % if we are plotting negative up, for some reason it
% % % it turns the layout file upside, too, so that is why I had to
% % % create another layout with 180 degree rotation
% % cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
% % cfg.projection = 'polar'; % comment out if plotting positive up
% % cfg.rotate = 180; % comment out if plotting positive up
% % upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
% % cfg.layout = upsidedown; % comment out if plotting positive up
% % %cfg.layout = layout; use this if plotting positive up
% % ft_multiplotER(cfg,bin1, bin2, bin3)
% % set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
% % 
% % saveas(gcf, 'ERP grand average multichan, tutorial', 'fig'); % save as a Matlab Figure file
% % saveas(gcf, 'ERP grand average multichan, tutorial', 'jpg'); % save as a tiff file
% % 
% % %% Single channel plot - Cz
% % 
% % figure
% % cfg = [];
% % cfg.channel = 'Cz';
% % cfg.zparam  = 'avg';
% % cfg.xlim    = [-0.100 0.700];%time
% % 
% % ft_singleplotER(cfg,bin1, bin2, bin3)
% % set(gca,'YDir','reverse') % plot negative up
% % 
% % legend(bin{1},bin{2},bin{3});
% % 
% % time4ticks = [0:0.200:0.600]; %% %% times on axis where you want ticks
% % set(gca,'XTick',time4ticks);
% % set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% % xlabel('Time (ms)')
% % ylabel('Amplitude')
% % 
% % saveas(gcf, 'ERP grand average Cz, tutorial', 'fig'); % save as a Matlab Figure file
% % saveas(gcf, 'ERP grand average Cz, tutorial', 'tif'); % save as a tiff file
% 
% 
