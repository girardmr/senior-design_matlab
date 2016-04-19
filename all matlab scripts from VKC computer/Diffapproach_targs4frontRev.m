%load Targ_WAvsMA_main_avblc_ind_alf_stat.mat
clear all; close all; clc

clustercode = 'Targ3bins4frontRev';

load targ_WAmain_gravg_avblc_ind.mat
WA = TFgravg_ind;
clear TFgravg_ind

load targ_MAmain_gravg_avblc_ind.mat
MA = TFgravg_ind;
clear TFgravg_ind

load targ_IRmain_gravg_avblc_ind.mat
IR = TFgravg_ind;
clear TFgravg_ind
cfg = [];

load soprolay_noCzwithnewmask.mat
load cmapRWB.mat
layout = soprolay_noCzwithnewmask;

zscale = [-0.25 0.25]; % %NOW MATCHES SCALE OF topoplots
%%
cfg.layout = layout;
%cfg.elec = elec;
cfg.yparam = 'freq';
cfg.zlim = zscale;
cfg.xlim = [0 0.800]
cfg.baseline = 'no';
%cfg.highlight = 'on';
%cfg.highlightsymbol    = '*'; %turns on the option to highlight certain channels
%   cfg.highlightcolor     = highlight marker color (default = [0 0 0] (black))
%cfg.highlightsize      = 10;
%   cfg.highlightfontsize  = highlight marker size (default = 8)
%cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.zparam   = 'powspctrm';
cfg.interactive = 'no';
cfg.colorbar = 'no';
cfg.colormap = cmap;
cfg.fontsize = 18;
cfg.gridscale = 200;
    
cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.ylim         = [8 30]; %frequency to plot
% cfg.xlim         = [0 0.800];%time I CAN'T SEE THE COLORBAR!??
% cfg.colorbar = 'EastOutside';
% cfg.showlabels   = 'no';
% cfg.colormap = cmap;
% cfg.layout  = soprolay_noCzwithnewmask;

subplot(3,2,1); ft_singleplotTFR(cfg,WA);
time4ticks = [0:0.200:0.800]; 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
%title(' ')
xlabel('Time (ms)')
ylabel('Frequency (Hz)')


subplot(3,2,3); ft_singleplotTFR(cfg,MA);
time4ticks = [0:0.200:0.800]; 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
%title(' ')
xlabel('Time (ms)')
ylabel('Frequency (Hz)')

subplot(3,2,5); ft_singleplotTFR(cfg,IR);
time4ticks = [0:0.200:0.800]; 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
%title(' ')
xlabel('Time (ms)')
ylabel('Frequency (Hz)')

TFtitle = cat(2,clustercode,'TFR');
%supertitle(maptitle);
saveas(gcf, TFtitle, 'fig');
saveas(gcf, TFtitle, 'epsc');
    clear TFtitle
    
%% these are just to get a color bar
% MAKE COLORBAR APPEAR IN %, SO ZSCALE X 100 

figure
subplot(2,1,1)
cfg.xlim = [0.400 0.400];%time of sig cluster
cfg.ylim = [8 30]; %
cfg.zlim         = zscale*100;
cfg.comment = 'no';
cfg.colorbar = 'WestOutside';
cfg.colormap = cmap;

ft_topoplotTFR(cfg,WA);
scaletitle = cat(2,clustercode,'Scale');
%TFtitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clusterTFR ',band));
%supertitle(TFtitle);
saveas(gcf, scaletitle, 'fig');
saveas(gcf, scaletitle, 'epsc');

% subplot(2,2,4)
% ft_topoplotTFR(cfg,bin2);

    