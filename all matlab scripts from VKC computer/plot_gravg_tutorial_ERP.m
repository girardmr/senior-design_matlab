% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';

load(cat(2,'chords_ERP_',bin{1}, '_gravg.mat'));
bin1 = ERPgravg;
clear ERPgravg

load(cat(2,'chords_ERP_',bin{2}, '_gravg.mat'));
bin2 = ERPgravg;
clear ERPgravg

load(cat(2,'chords_ERP_',bin{3}, '_gravg.mat'));
bin3 = ERPgravg;
clear ERPgravg


%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 0.700];%time in seconds
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
ft_multiplotER(cfg,bin1, bin2, bin3)
set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

saveas(gcf, 'ERP grand average multichan, tutorial', 'fig'); % save as a Matlab Figure file
saveas(gcf, 'ERP grand average multichan, tutorial', 'tif'); % save as a tiff file

%% Single channel plot - Cz

figure
cfg = [];
cfg.channel = 'Cz';
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 0.700];%time 

ft_singleplotER(cfg,bin1, bin2, bin3)
set(gca,'YDir','reverse') % plot negative up

legend(bin{1},bin{2},bin{3});

time4ticks = [0:0.200:0.600]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')

saveas(gcf, 'ERP grand average Cz, tutorial', 'fig'); % save as a Matlab Figure file
saveas(gcf, 'ERP grand average Cz, tutorial', 'tif'); % save as a tiff file


