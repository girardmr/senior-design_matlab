% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010
% NEEDS WORK

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;
load cmapRWB.mat
zscale = [-3 3]
latwindow = [0.500 0.700]

bin{1}='PhyAcc1';
bin{2}='PhyAcc2';

load(cat(2,bin{1}, '_lpf_gravg_12SsTLD.mat'));
bin1 = ERPgravg;
clear ERPgravg

load(cat(2,bin{2}, '_lpf_gravg_12SsTLD.mat'));
bin2 = ERPgravg;
clear ERPgravg




%% ERP grand average topoplot bin 1
figure
cfg = [];
cfg.xlim    = latwindow ;%time in seconds
cfg.layout = layout;
cfg.interactive = 'no';
cfg.channel = 'all'
cfg.parameter  = 'avg';
cfg.zlim    = zscale;
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.colorbar = 'EastOutside';
cfg.colormap = cmap; %use default one for now
cfg.fontsize = 16;
cfg.gridscale = 200;

ft_topoplotER(cfg,bin1)

title=('Topo plot for Subject-Verb Agreement Correct');

saveas(gcf, 'ERP grand average, SLIR_syntax_SVA-corr_topoplot', 'jpg'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'fig'); % save as a tiff file


%% bin 2
%% ERP grand average topoplot
figure
cfg = [];
cfg.xlim    = latwindow;%time in seconds
cfg.layout = layout;
cfg.interactive = 'no';
cfg.channel = 'all'
cfg.parameter  = 'avg';
cfg.zlim    = zscale;
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.colorbar = 'EastOutside';
cfg.colormap = cmap; %use default one for now
cfg.fontsize = 16;
cfg.gridscale = 200;

ft_topoplotER(cfg,bin2)

%title=('Topo plot for Subject-Verb Agreement Violation');

saveas(gcf, 'ERP grand average, SLIR_dynatt_topoplot', 'jpg'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'fig'); % save as a tiff file

