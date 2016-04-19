%plot significant clusters for frontiers
%plot significant clusters; careful here, this whole cell needs to be
%updated for each new pair of conditions; also change frequencies and time
%of plots

clear all; clc
clustercode = 'Syll4_frontiersRev';
cond1= 'SSreg';
cond2= 'SWreg';
band = 'evoGam';
% POS cluster, be careful

load SSregvsSWreg_L_stat_logam_evo_rs.mat

load Strong_Strong_L_gravg_mblc_evo_rs.mat
bin1 = TFgravg_evo;
clear TFgravg_evo

load Strong_Weak_L_gravg_mblc_evo_rs.mat
bin2 = TFgravg_evo;
clear TFgravg_evo

%%
% NEG cluster, be careful
Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (negative cluster#1)
%Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand
latsnaps = [150 ]; % want snapshots at these latencies for this cluster
zscale = [-0.75 0.75]; % %

[x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes

C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0));
timeind_max = max(find(C_onlytime~=0));
timelim = [stat.time(timeind_min) stat.time(timeind_max)];

freqband = stat.cfg.frequency; % frequency band

%should correspond to stat.time*1000:
A= -100:2:300; % careful here: specify timepoints in ms that were used in clustering analysis. 

j = latsnaps/1000;
L = length(latsnaps);% how many subplots per condition

for f=1:length(latsnaps)
    m(f) = find(A==latsnaps(f)); %time indexes of stat data
end

% now define time limits straight from the stats
x1= timelim(1); x2=timelim(2);
y1= freqband(1); y2=freqband(2);

cfg = [];
elec= ft_read_sens('sopro_new_montage_noCz.sfp');

%%
load soprolay_noCzwithnewmask.mat
load cmapRWB.mat
layout = soprolay_noCzwithnewmask;

%% topoplot, highlights clusters
figure
cfg = [];

cfg.layout = layout;
cfg.elec = elec;
cfg.yparam = 'freq';
cfg.ylim= freqband;
cfg.zlim = zscale;
cfg.baseline = 'no';
cfg.highlight = 'on';
cfg.highlightsymbol    = '*'; %turns on the option to highlight certain channels
%   cfg.highlightcolor     = highlight marker color (default = [0 0 0] (black))
cfg.highlightsize      = 10;
%   cfg.highlightfontsize  = highlight marker size (default = 8)
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.zparam   = 'powspctrm';
cfg.interactive = 'yes';
%cfg.colorbar = 'EastOutside';
cfg.colormap = cmap;
cfg.fontsize = 12;
cfg.gridscale = 200;
    

%plot condition#1 in top row

for k = 1:L %# of subplots
    
    subplot(2,2,2);
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp); %highlights those channels   
    %cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
    cfg.comment = ' ';
    %cfg.commentpos = 'rightbottom'
    ft_topoplotTFR(cfg, bin1);
    clear chan_temp
end

gcf % get current figure
% don't need to repeat the cfg here; it will use the same cfg as above.

%plot condition#2 in second row
for k = 1:L;  % subplots
    subplot(2,2,4)
    %subplot(2,L,(k+L));
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp);    % highlights those channels
    %cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
    cfg.comment = ' ';
    %cfg.commentpos = 'middlebottom'
    ft_topoplotTFR(cfg, bin2);
    
    clear chan_temp
end

% %maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
% maptitle = cat(2,clustercode,'clustermap');
% supertitle(maptitle);
% %set('FontName','Arial')
% saveas(gcf, maptitle, 'fig');
% saveas(gcf, maptitle, 'epsc'); % save as eps color
% clear maptitle

SigChanInd=unique(x);
for e=1:length(SigChanInd);
    
    SigChan{e} = stat.label{SigChanInd(e)};
    
end
save SigChan_Syll4_LAf.mat SigChan

cfg = [];
cfg.channel= SigChan; %just the significant ones in the cluster!

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zlim         = zscale;
cfg.ylim         = [13 50]; %
cfg.xlim         = [-0.100 0.300];%time I CAN'T SEE THE COLORBAR!??
cfg.colorbar = 'EastOutside';
%cfg.showlabels   = 'no';
cfg.layout       =  soprolay_noCzwithnewmask;  %'GSN-HydroCel-65 1.0.sfp';
cfg.colormap = cmap;

% plot first condition
gcf
subplot(2,2,1);
ft_singleplotTFR(cfg,bin1); hold on
plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
time4ticks = [-0.100:0.100:0.300];
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms

title(' ')

subplot(2,2,3);
ft_singleplotTFR(cfg,bin2); hold on
plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
time4ticks = [-0.100:0.100:0.300];
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
title(' ')
%title(cond2)
%title(cond2)
TFtitle = cat(2,clustercode,'TFRmap');
%TFtitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clusterTFR ',band));
%supertitle(TFtitle);
saveas(gcf, TFtitle, 'fig');
saveas(gcf, TFtitle, 'epsc');

%these are just to get a color bar
% MAKE COLORBAR APPEAR IN %, SO ZSCALE X 100 
figure
subplot(2,1,1)
cfg.xlim = timelim;%time of sig cluster
cfg.ylim = freqband; %
cfg.zlim         = zscale*100;
cfg.comment = 'no';
cfg.colorbar = 'WestOutside';
cfg.colormap = cmap;

ft_topoplotTFR(cfg,bin1);

% subplot(2,2,4)
% ft_topoplotTFR(cfg,bin2);

scaletitle = cat(2,clustercode,'Scale');
%TFtitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clusterTFR ',band));
%supertitle(TFtitle);
saveas(gcf, scaletitle, 'fig');
saveas(gcf, scaletitle, 'epsc');

