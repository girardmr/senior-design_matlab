%plot significant clusters; careful here, this whole cell needs to be
%updated for each new pair of conditions; also change frequencies and time
%of plots
clear all; clc
%this one goes from 
band = 'Alpha';
clustercode = cat(2,'tut_Chords2vs3_ind_',band);

load Chords_2vs3_avblc_ind_alf_Fr_stat.mat %make sure this is new stat file
cond1= stat.cond1;
cond2= stat.cond2;

load(cat(2,cond1, '_chords_gravg_avblc_ind.mat'));
bin1 = TFgravg_ind;
clear TFgravg_ind

load(cat(2,cond2, '_chords_gravg_avblc_ind.mat'));
bin2 = TFgravg_ind;
clear TFgravg_ind

%%
% Specify here if positive or negative cluster
Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (negative cluster#1)
%Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand this cluster goes from 16 to 380ms
latsnaps = [100 200 300]; % want snapshots at these latencies for this cluster in ms
zscale = [-0.5 0.5]; % determine iteratively


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

A= 0:4:600; % must change times for other categories % time in Ms

j = latsnaps/1000;
for f=1:length(latsnaps)
    m(f) = find(A==latsnaps(f)); %time indexes of stat data
end
% 
% % now define time limits straight from the stats
% %
% x1= timelim(1); x2=timelim(2);
% y1= freqband(1); y2=freqband(2);

%zscale = 'maxmin'; % %
%% CHANGE TIME indices
A= 0:4:600; % must change times for other categories % time in Ms

L= length(latsnaps);% snapshots at these latencies

for f=1:length(latsnaps)
    m(f) = find(A==latsnaps(f)); %time indexes of stat data
end
%

% now define time limits straight from the stats
%
x1= timelim(1); x2=timelim(2);
y1= freqband(1); y2=freqband(2);

cfg = [];
elec=read_sens('GSN128_positions_4clustering.sfp');

%%
%load EGI_129_newmask.lay.mat
load EGI_layout129.lay.mat %old mask, better?
load cmapRWB.mat
layout = EGI_layout129;

%% topoplot, highlights clusters
figure
cfg = [];

cfg.layout = layout;
cfg.elec = elec;  % EXPLAIN THIS
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
    

%plot condition#1
for k = 1:L %# of subplots
    
    subplot(2,L,k);
    cfg.xlim= [j(k) j(k)]; % goes to the time point you define above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp);
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms');

    ft_topoplotTFR(cfg, bin1);
    clear chan_temp
end

gcf
% don't need to repeat the cfg here; it will use the same as above
%plot condition#2
for k = 1:L;  % subplots
    
    subplot(2,3,(k+3));
    cfg.xlim= [j(k) j(k)]; % goes to the time point you define above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp);    
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms');
    ft_topoplotTFR(cfg, bin2);
    clear chan_temp
    
end

%maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
maptitle = cat(2,clustercode,'clustermap');
% supertitle(maptitle);
saveas(gcf, maptitle, 'fig');
saveas(gcf, maptitle, 'tif');
clear maptitle


SigChanInd=unique(x);
for e=1:length(SigChanInd);
    
    SigChan{e} = stat.label{SigChanInd(e)};

end
sigchanfilename = cat(2,'SigChan_',clustercode,'.mat')
save (sigchanfilename, 'SigChan');


cfg = [];
cfg.channel= SigChan; %just the significant ones in the cluster!

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zlim         = zscale;
cfg.ylim         = freqband; %alpha
cfg.xlim         = [0 0.600];%time I CAN'T SEE THE COLORBAR!??
cfg.colorbar = 'EastOutside';
cfg.layout       =  layout;  %'GSN-HydroCel-65 1.0.sfp';
cfg.colormap     = cmap


% plot first condition
figure
subplot(2,2,1);
ft_singleplotTFR(cfg,bin1); hold on
plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
time4ticks = [0:0.200:0.600]; %% CHANGE SOMETHING HERE?!
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
time4ticks = [0:0.200:0.600]; %% CHANGE SOMETHING HERE?!
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Frequency (Hz)')
title(' ')

%these are just to get a color bar, but nice b/c shows average
subplot(2,2,2)
cfg.xlim = timelim;%time of sig cluster
cfg.ylim = freqband; %
cfg.gridscale = 100;
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

