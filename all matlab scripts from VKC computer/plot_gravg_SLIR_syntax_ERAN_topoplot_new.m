% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;
load cmapRWB.mat
zscale = [-3 3]

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

%% ERP grand average topoplot bin 1
figure
cfg = [];
cfg.xlim    = [0.100 0.300];%time in seconds
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

saveas(gcf, 'ERP ERAN average, SLIR_syntax_SVA-corr_topoplot', 'jpg'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file


%% bin 2
%% ERP grand average topoplot
figure
cfg = [];
cfg.xlim    = [0.100 0.300];%time in seconds
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

saveas(gcf, 'ERP ERAN, SLIR_syntax_SVA-viol_topoplot', 'jpg'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file

%% bin 3
% ERP grand average topoplot
figure
cfg = [];
cfg.xlim    = [0.100 0.300];%time in seconds
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

ft_topoplotER(cfg,bin3)

%title=('Topo plot for Tense Correct');

saveas(gcf, 'ERP ERAN, SLIR_syntax_TEN-corr_topoplot', 'jpg'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file


%% bin 4
% ERP grand average topoplot
figure
cfg = [];
cfg.xlim    = [0.100 0.300];%time in seconds
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

ft_topoplotER(cfg,bin4)

%title=('Topo plot for Tense Correct');

saveas(gcf, 'ERP ERAN average, SLIR_syntax_TEN-viol_topoplot', 'jpg'); % save as a Matlab Figure file
%saveas(gcf, 'ERP grand average multichan, SLIR_syntax_topoplot', 'jpg'); % save as a tiff file
