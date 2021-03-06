%plot significant clusters in evoked data - syll
%plot significant clusters; careful here, this whole cell needs to be
%updated for each new pair of conditions; also change frequencies and time
%of plots

clear all; clc
clustercode = 'Syll1Sf_4frontiers';
cond1= 'SSreg';
cond2= 'WSreg';
band = 'indBeta';
% POS cluster, be careful

load SSregvsWSreg_S_stat_beta_ind_rs_f.mat

load Strong_Strong_S_gravg_mblc_ind_rs.mat
bin1 = TFgravg_ind;
clear TFgravg_ind

load Weak_Strong_S_gravg_mblc_ind_rs.mat
bin2 = TFgravg_ind;
clear TFgravg_ind

%%
% NEG cluster, be careful
%Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (negative cluster#1)
Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand
latsnaps = [0 150 250]; % want snapshots at these latencies for this cluster
zscale = [-0.10 0.10]; % %

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

A= -100:2:450; % for targets; must change times for other stim

j = latsnaps/1000;
for f=1:length(latsnaps)
    m(f) = find(A==latsnaps(f)); %time indexes of stat data
end

% now define time limits straight from the stats
%
x1= timelim(1); x2=timelim(2);
y1= freqband(1); y2=freqband(2);

cfg = [];
elec=read_sens('sopro_new_montage_noCz.sfp');

%%
load soprolay_noCzwithnewmask.mat
load cmapRWB.mat


figure
for k = 1:3;  %length(j)-1 subplots
    subplot(2,3,k);
    
    cfg = [];
    
    cfg.layout       =  soprolay_noCzwithnewmask;  %'GSN-HydroCel-65 1.0.sfp';
    cfg.elec = elec;
    cfg.yparam = 'freq';
    cfg.xlim= [j(k) j(k)];
    cfg.ylim= freqband;
    cfg.zlim = zscale;
    cfg.highlight = find(C_mask(:,m(k))==1);   % only elecs that are sig for this particular whole time window
    cfg.baseline = 'no';
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms');
    cfg.commentpos = 'title';
    cfg.shading    = 'interp';
    cfg.style = 'straight';
    cfg.zparam   = 'powspctrm';
    %cfg.interactive = 'yes';
    %cfg.colorbar = 'EastOutside';
    cfg.colormap = cmap;
    cfg.fontsize = 12;
    cfg.gridscale = 200;
    topoplotTFR(cfg, bin1);
    
end

gcf
for k = 1:3;  % subplots
    subplot(2,3,(k+3));
    
    cfg = [];
    cfg.layout       =  soprolay_noCzwithnewmask;  %'GSN-HydroCel-65 1.0.sfp';
    cfg.elec = elec;
    cfg.yparam = 'freq';
    cfg.xlim= [j(k) j(k)];
    cfg.ylim= freqband; %frequency band here?
    cfg.zlim = zscale; %[-0.10 0.10];
    cfg.highlight = find(C_mask(:,m(k))==1);   % only elecs that are sig for this particular whole time window
    cfg.baseline = 'no';
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms');
    cfg.commentpos = 'title';
    cfg.zparam   = 'powspctrm';
    cfg.shading  = 'interp';
    cfg.style = 'straight';
    %cfg.interactive = 'yes';
    %cfg.colorbar = 'EastOutside';
    cfg.fontsize = 12;
    cfg.gridscale = 200;
    cfg.colormap = cmap;
    topoplotTFR(cfg, bin2);
    
end

%maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
maptitle = cat(2,clustercode,'clustermap');
supertitle(maptitle);
saveas(gcf, maptitle, 'fig');
saveas(gcf, maptitle, 'tif');
clear maptitle

SigChanInd=unique(x);
for e=1:length(SigChanInd);
    
    SigChan{e} = stat.label{SigChanInd(e)};
    
end
save SigChan_Syll1Sf.mat SigChan

cfg = [];
cfg.channel= SigChan; %just the significant ones in the cluster!

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zlim         = zscale;
cfg.ylim         = [13 30]; %beta and gamma
cfg.xlim         = [-0.100 0.300];%time I CAN'T SEE THE COLORBAR!??
cfg.colorbar = 'EastOutside';
cfg.showlabels   = 'no';
cfg.layout       =  soprolay_noCzwithnewmask;  %'GSN-HydroCel-65 1.0.sfp';
cfg.colormap = cmap;

% plot first condition
figure
subplot(2,2,1);
singleplotTFR(cfg,bin1); hold on
plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
time4ticks = [-0.100:0.100:0.300];
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms

title(' ')

subplot(2,2,3);
singleplotTFR(cfg,bin2); hold on
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

%these are just to get a color bar, but nice b/c shows average
subplot(2,2,2)
cfg.xlim = timelim;%time of sig cluster
cfg.ylim = freqband; %
cfg.comment = 'no';
cfg.colorbar = 'WestOutside';
cfg.colormap = cmap;

topoplotTFR(cfg,bin1);

subplot(2,2,4)
topoplotTFR(cfg,bin2);

TFtitle = cat(2,clustercode,'clusterTFR');
%TFtitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clusterTFR ',band));
%supertitle(TFtitle);
saveas(gcf, TFtitle, 'fig');
saveas(gcf, TFtitle, 'tif');

