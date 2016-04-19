%plot significant clusters in evoked data - targets
% still need to 
%plot significant clusters; careful here, this whole cell needs to be
%updated for each new pair of conditions; also change frequencies and time
%of plots
clear all; clc
clustercode = 'Targ7_4nlcposter';
cond1= 'WAmain';
cond2= 'MAmain';
band = 'indBeta';
% POS cluster, be careful
freqband= [13 29]; %beta
latsnaps = [100 250 400]; % want snapshots at these latencies for this cluster
zscale = [-0.30 0.30]; % %
%zscale = 'maxmin'; % %
timelim = [0 0.526]; % actual time limits of cluster for box
x1= timelim(1); x2=timelim(2);
 y1= freqband(1); y2=freqband(2);
 
A= 0:2:800; % for targets; must change times for other stim

j = latsnaps/1000;
load Targ_WAvsMA_main_avblc_ind_nbeta_stat.mat

load targ_WAmain_gravg_avblc_ind.mat
bin1 = TFgravg_ind;
clear TFgravg_ind

load targ_MAmain_gravg_avblc_ind.mat
bin2 = TFgravg_ind;
clear TFgravg_ind

%%
cfg = [];
elec=read_sens('sopro_new_montage_noCz.sfp');

for f=1:length(latsnaps)
   m(f) = find(A==latsnaps(f)); %time indexes of stat data
end

pos = stat.posclusterslabelmat  == 1;
%neg = (stat.negclusterslabelmat == 1)*-1; %find time,channel pairs where 
%electrode belongs to significant cluster (negative cluster#1)

[x,y]=find(pos==1); %find channel,time pairs of significant electrodes
%[x,y]=find(neg==-1); %find channel,time pairs of significant electrodes

%%
load soprolay_noCzwithnewmask.mat
load cmapRWB.mat


figure
for k = 1:3;  %length(j)-1 subplots
     subplot(2,3,k);
     
     cfg = [];

     cfg.layout  = soprolay_noCzwithnewmask; 
     cfg.elec = elec;
     cfg.yparam = 'freq';
     cfg.xlim= [j(k) j(k)];   
     cfg.ylim= freqband; 
     cfg.zlim = zscale;
     cfg.highlight = 'on';
     %cfg.highlight = find(neg(:,m(k))==-1);   % only elecs that are sig for this particular whole time window
     cfg.highlightchannel = find(pos(:,m(k))==1);   % only elecs that are sig for this particular whole time window
     cfg.baseline = 'no';
     cfg.comment = cat(2,num2str(latsnaps(k)),' ms');   
     cfg.commentpos = 'title';
     cfg.shading    = 'interp';
     cfg.style = 'straight';
     cfg.zparam   = 'powspctrm';
     cfg.interactive = 'yes';
     %cfg.colorbar = 'EastOutside';
     cfg.fontsize = 12;
     cfg.colormap = cmap;
     cfg.gridscale = 200;
     ft_topoplotTFR(cfg, bin1); 
     
end

gcf
for k = 1:3;  %3 subplots
     subplot(2,3,(k+3));
     
     cfg = [];

     cfg.layout  = soprolay_noCzwithnewmask; 
     cfg.elec = elec;
     cfg.yparam = 'freq';
     cfg.xlim= [j(k) j(k)];   
     cfg.ylim= freqband; 
     cfg.zlim = zscale;
     cfg.highlight = 'on';
     %cfg.highlight = find(neg(:,m(k))==-1);   % only elecs that are sig for this particular whole time window
     cfg.highlightchannel = find(pos(:,m(k))==1);   % only elecs that are sig for this particular whole time window
     cfg.baseline = 'no';
     cfg.comment = cat(2,num2str(latsnaps(k)),' ms');   
     cfg.commentpos = 'title';
     cfg.shading    = 'interp';
     cfg.style = 'straight';
     cfg.zparam   = 'powspctrm';
     cfg.interactive = 'yes';
     %cfg.colorbar = 'EastOutside';
     cfg.fontsize = 12;
     cfg.colormap = cmap;
     cfg.gridscale = 200;
     ft_topoplotTFR(cfg, bin2); 
     
     
end
% text(0.04,0.65,cond1)
% text(0.04,0.22,cond2)
% text(0.10,0.40,'Difspectra (Pseudo - Word)')

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

% save SigChan_Targ7n.mat SigChan

cfg = [];
cfg.channel= SigChan; %just the significant ones in the cluster!

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zlim         = zscale;
cfg.ylim         = [8 30]; %frequency to plot
cfg.xlim         = [0 0.800];%time I CAN'T SEE THE COLORBAR!??
cfg.colorbar = 'EastOutside';
cfg.showlabels   = 'no';
cfg.colormap = cmap;
cfg.layout  = soprolay_noCzwithnewmask;

% plot first condition
% plot first condition
figure
subplot(2,2,1);
singleplotTFR(cfg,bin1); hold on
plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
time4ticks = [-0.200:0.200:0.800]; 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
title(' ')

subplot(2,2,3);
singleplotTFR(cfg,bin2); hold on
plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
title(' ')

%these are just to get a color bar, but nice b/c shows average
subplot(2,2,2)
cfg.xlim = timelim;%time of sig cluster
cfg.ylim = freqband; %
cfg.comment = 'no';
cfg.colorbar = 'WestOutside';

topoplotTFR(cfg,bin1);

subplot(2,2,4)
topoplotTFR(cfg,bin2);
TFtitle = cat(2,clustercode,'clusterTFR');
%TFtitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clusterTFR ',band));
supertitle(TFtitle);
saveas(gcf, TFtitle, 'fig');
saveas(gcf, TFtitle, 'tif');


