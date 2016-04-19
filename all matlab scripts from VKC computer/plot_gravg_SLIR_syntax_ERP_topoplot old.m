% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';

load(cat(2,bin{1}, '_lpf_gravg.mat'));
bin1 = ERPgravg;
clear ERPgravg

load(cat(2,bin{2}, '_lpf_gravg.mat'));
bin2 = ERPgravg;
clear ERPgravg

load(cat(2,bin{3}, '_lpf_gravg.mat'));
bin3 = ERPgravg;
clear ERPgravg

load(cat(2,bin{4}, '_lpf_gravg.mat'));
bin4 = ERPgravg;
clear ERPgravg

%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [0.400 0.600];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';



% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
%cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
%cfg.projection = 'polar'; % comment out if plotting positive up
%cfg.rotate = 180; % comment out if plotting positive up
%upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
%cfg.layout = upsidedown; % comment out if plotting positive up
cfg.layout = layout; %use this if plotting positive up
ft_topoplotER(cfg,bin1)
%set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

cfg = [];
load tut_layout.mat % this layout excludes EOG channels
load cmapRWB.mat
cfg.layout = EGI_layout129;
cfg.interactive = 'no';
cfg.channel = 'all'
cfg.parameter  = 'avg';
%cfg.zlim    = zscale;
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';

title=('Topo plot for Subject-Verb Agreement Correct- Subject 101');

cfg.colorbar = 'EastOutside';
cfg.colormap = cmap; %use default one for now
cfg.fontsize = 16;
cfg.gridscale = 200;

ft_topoplotER(cfg,bin1)

saveas(gcf, 'ERP grand average multichan, SLIR_syntax_SVA-corr_topoplot', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file


%% bin 2
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [0.400 0.600];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';



% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
%cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
%cfg.projection = 'polar'; % comment out if plotting positive up
%cfg.rotate = 180; % comment out if plotting positive up
%upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
%cfg.layout = upsidedown; % comment out if plotting positive up
cfg.layout = layout; %use this if plotting positive up
ft_topoplotER(cfg,bin2)
%set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

cfg = [];
load tut_layout.mat % this layout excludes EOG channels
load cmapRWB.mat
cfg.layout = EGI_layout129;
cfg.interactive = 'no';
cfg.channel = 'all'
cfg.parameter  = 'avg';
%cfg.zlim    = zscale;
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';

title=('Topo plot for Subject-Verb Agreement Violation- Subject 102');

cfg.colorbar = 'EastOutside';
cfg.colormap = cmap; %use default one for now
cfg.fontsize = 16;
cfg.gridscale = 200;

ft_topoplotER(cfg,bin2)

saveas(gcf, 'ERP grand average multichan, SLIR_syntax_SVA-viol_topoplot', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file


%% bin 3
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [0.400 0.600];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';



% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
%cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
%cfg.projection = 'polar'; % comment out if plotting positive up
%cfg.rotate = 180; % comment out if plotting positive up
%upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
%cfg.layout = upsidedown; % comment out if plotting positive up
cfg.layout = layout; %use this if plotting positive up
ft_topoplotER(cfg,bin3)
%set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

cfg = [];
load tut_layout.mat % this layout excludes EOG channels
load cmapRWB.mat
cfg.layout = EGI_layout129;
cfg.interactive = 'no';
cfg.channel = 'all'
cfg.parameter  = 'avg';
%cfg.zlim    = zscale;
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';

title=('Topo plot for Tense Agreement Correct- Subject 103');

cfg.colorbar = 'EastOutside';
cfg.colormap = cmap; %use default one for now
cfg.fontsize = 16;
cfg.gridscale = 200;

ft_topoplotER(cfg,bin3)

saveas(gcf, 'ERP grand average multichan, SLIR_syntax_TEN-corr_topoplot', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file


%% bin 4
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [0.400 0.600];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';



% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
%cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
%cfg.projection = 'polar'; % comment out if plotting positive up
%cfg.rotate = 180; % comment out if plotting positive up
%upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
%cfg.layout = upsidedown; % comment out if plotting positive up
cfg.layout = layout; %use this if plotting positive up
ft_topoplotER(cfg,bin4)
%set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

cfg = [];
load tut_layout.mat % this layout excludes EOG channels
load cmapRWB.mat
cfg.layout = EGI_layout129;
cfg.interactive = 'no';
cfg.channel = 'all'
cfg.parameter  = 'avg';
%cfg.zlim    = zscale;
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';

title=('Topo plot for Tense Agreement Violation- Subject 104');

cfg.colorbar = 'EastOutside';
cfg.colormap = cmap; %use default one for now
cfg.fontsize = 16;
cfg.gridscale = 200;

ft_topoplotER(cfg,bin4)

saveas(gcf, 'ERP grand average multichan, SLIR_syntax_TEN-viol_topoplot', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file
