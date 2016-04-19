%plot significant clusters; careful here, this whole cell needs to be
%updated for each new pair of conditions; also change frequencies and time
%of plots
clear all; clc
band = 'Beta';
clustercode = cat(2,'Metronew_ind_4frontiersRev',band);
%this one goes frrom
% POS cluster, be careful
load Metronew_beatvsoff_beta_ind_stat.mat %make sure this is new stat file
cond1= stat.cond1;
cond2= stat.cond2;

load(cat(2,cond1, '_gravg_avblc_ind.mat'));
bin1 = TFgravg_ind;
clear TFgravg_ind

load(cat(2,cond2, '_gravg_avblc_ind.mat'));
bin2 = TFgravg_ind;
clear TFgravg_ind

%%
% POS cluster, be careful
%Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (negative cluster#1)
Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand this cluster goes from -50 to 266ms
%latsnaps = [0 50 100]; % want snapshots at these latencies for this cluster in ms
latsnaps = [50];
zscale = [-0.05 0.05]; % %
%this one goes from
for ff= 1:length(stat.freq) %for each frequency band...
    B{ff} = squeeze(Big_mat(:,ff,:));
    B_sigf(ff) = max(B{ff}(:));
end

C=squeeze(sum(Big_mat,2));
C_mask= (C~=0); %now this contains only chan and time values collapsed across frequencies.
[x,y]=find(C_mask==1); %find channel,time pairs of significant electrodes

freqind_min = min(find(B_sigf~=0));
freqind_max = max(find(B_sigf~=0));

C_onlytime = squeeze(sum(C_mask,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0));
timeind_max = max(find(C_onlytime~=0));
timelim = [stat.time(timeind_min) stat.time(timeind_max)];

freqband(1) = stat.freq(freqind_min);
freqband(2) = stat.freq(freqind_max);


%zscale = 'maxmin'; % %
%% CHANGE TIME indices
A= -100:2:300; % must change times for other categories

j = latsnaps/1000;
L = length(latsnaps);% how many subplots per condition

for f=1:length(latsnaps)
    m(f) = find(A==latsnaps(f)); %time indexes of stat data
end

% now define time limits straight from the stats
%
x1= timelim(1); x2=timelim(2);
y1= freqband(1); y2=freqband(2);

cfg = [];
elec= ft_read_sens('sopro_new_montage_noCz.sfp');

%%
load soprolay_noCzwithnewmask.mat
load cmapRWB.mat
layout = soprolay_noCzwithnewmask;


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
for k = 1:L %# of subplots
    
    %subplot(2,L,k);
    subplot(2,2,2);
    
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    %chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    %cfg.highlightchannel = stat.label(chan_temp); %highlights those channels
    %cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
        cfg.highlightchannel = find(C_mask(:,m(k))==1); % only elecs that are sig for this particular whole time window

    cfg.comment = ' ';
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
    %chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    %cfg.highlightchannel = stat.label(chan_temp);    % highlights those channels
        cfg.highlightchannel = find(C_mask(:,m(k))==1); % only elecs that are sig for this particular whole time window

    %cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
    cfg.comment = ' ';
    ft_topoplotTFR(cfg, bin2);
    
    clear chan_temp
end

% %maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
% maptitle = cat(2,clustercode,'clustermap');
% supertitle(maptitle);
% saveas(gcf, maptitle, 'fig');
% saveas(gcf, scaletitle, 'epsc');
% clear maptitle


SigChanInd=unique(x);
for e=1:length(SigChanInd);
    
    SigChan{e} = stat.label{SigChanInd(e)};
    
end

%change name here
% save SigChan_MetronewBeta_ind.mat SigChan


cfg = [];
cfg.channel= SigChan; %just the significant ones in the cluster!

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zlim         = zscale;
cfg.ylim         = [13 50]; %alpha
cfg.xlim         = [-0.100 0.300];%time I CAN'T SEE THE COLORBAR!??
cfg.colorbar = 'EastOutside';
cfg.showlabels   = 'no';
cfg.layout       =  soprolay_noCzwithnewmask;  %'GSN-HydroCel-65 1.0.sfp';
cfg.colormap     = cmap


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

%title(cond1)

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
cfg.zlim         = zscale*100; % so scale prints in percents
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