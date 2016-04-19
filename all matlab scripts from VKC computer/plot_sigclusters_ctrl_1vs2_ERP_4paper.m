% Custom script to plot a significant cluster on grand-average tutorial ERP data
% mod. by RLG 12 jan 2011

%% step 1: load files and name cluster
clear all; clc

band = 'ERP'; % for naming purposes, say ERP here or the name of your frequency band of interest
clustercode = cat(2,'MAPctrl1vs2',band,'4paper'); % give some abbreviation for your cluster, which will be used to name the graphics files

load MAPctrl_1vs2_ERP_stat.mat % make sure you load the right stat file
cond1= stat.cond1; % we added the two condition names to the stat structure during clustering
cond2= stat.cond2;

load(cat(2,'MAP_controls_',cond1,'_gravg_ERP')); % use grand average files
bin1 = ERPgravg;
clear ERPgravg

load(cat(2,'MAP_controls_',cond2,'_gravg_ERP'));;
bin2 = ERPgravg;
clear ERPgravg

%% step 2: find data at right times to plot
% Specify here if it's positive or negative cluster (this one is a negative
% one); change value to a different number to plot a cluster rather than
% the first one.
%Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (neg cluster#1)
Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand. This cluster's latency is: 236 to 348ms
latsnaps = [164 192 212]; % want "snapshots" at these latencies for this cluster - in ms
zscale = [-4 4]; % determine iteratively

[x,y]=find(Big_mat==1); % find channel,time indices of significant electrodes

C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0)); % index of min time of the cluster
timeind_max = max(find(C_onlytime~=0)); % indexmax time of the cluster
timelim = [stat.time(timeind_min) stat.time(timeind_max)];

%should correspond to stat.time*1000:
A= 0:4:600; % careful here: specify timepoints in ms that were used in clustering analysis. 

j = latsnaps/1000;
L = length(latsnaps);% how many subplots per condition

for f=1:length(latsnaps)
    m(f) = find(A==latsnaps(f)); %time indexes of stat data
end

% now define time limits straight from the stats
x1= timelim(1); x2=timelim(2);

%% load layout files and colormap file
%cfg = [];
%elec= ft_read_sens('GSN128_positions_4clustering.sfp'); % electrodes to plot; excludes eye channels

load tut_layout.mat 
load cmapRWB.mat
layout = EGI_layout129;

%% topoplot, highlights clusters

figure
cfg = [];

cfg.layout = layout;
%cfg.elec = elec;
cfg.zparam = 'avg';
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
cfg.interactive = 'yes';
%cfg.colorbar = 'EastOutside';
cfg.colormap = cmap;
cfg.fontsize = 12;
cfg.gridscale = 200;
    

%plot condition#1 in top row
for k = 1:L %cycles through subplots
    
    subplot(2,L,k);
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp); %highlights those channels
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
    
    ft_topoplotER(cfg, bin1);
    clear chan_temp
end

gcf % get current figure
% don't need to repeat the cfg here; it will use the same cfg as above.

%plot condition#2 in second row
for k = 1:L;  %cycles through subplots
    
    subplot(2,L,(k+L));
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp); % highlights those channels    
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms');  % writes the latency in ms above each subplot
  
    ft_topoplotER(cfg, bin2);
    clear chan_temp
end

%maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
maptitle = cat(2,clustercode,'clustermap');
% supertitle(maptitle); %% need the Matlab function supertitle to use that,
% but careful, it can cause some subplots to line up in a weird way
saveas(gcf, maptitle, 'fig'); % saves two versions - Matlab fig file and jpgf
saveas(gcf, maptitle, 'jpg');
clear maptitle

%% find all significant channels, to be used after to make ERP plot
SigChanInd=unique(x); %see line 33 where we defined x

for e=1:length(SigChanInd);
    
    SigChan{e} = stat.label{SigChanInd(e)};

end
sigchanfilename = cat(2,'SigChan_',clustercode,'.mat')
save (sigchanfilename, 'SigChan'); % save significant channels in own .mat file

%% now plot ERPs in both conditions; use ft_singleplotER to take mean across significant channels

figure % new figure

cfg = [];
cfg.channel= SigChan; %just the significant ones in the cluster, defined above

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zparam        = 'avg';
cfg.xlim         = [-0.100 0.600];%time in sec for the ERP plot
cfg.colorbar = 'EastOutside';
cfg.layout       =  layout;  %
cfg.colormap     = cmap;
cfg.ylim = [-4 4]; % not necessary to use same scale from topoplot in ERPs

ft_singleplotER(cfg, bin1, bin2); hold on
plot([x1 x1],zscale,':k','LineWidth',1); hold on % delineate cluster on ERP plot 
plot([x2 x2],zscale,':k','LineWidth',1); hold off

time4ticks = 0:0.200:0.600; %% put ticks at these points in seconds
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % changes axes tick labels to time in ms

set(gca,'YDir','reverse') % plot negative up
legend(cond1,cond2);

title(clustercode)
ERPtitle = cat(2,clustercode,'clusterERP');

saveas(gcf, ERPtitle, 'fig'); % saves two versions - Matlab fig file and jpgf
saveas(gcf, ERPtitle, 'jpg');

%plot another version: 
% interactive plot, multiple channels, plot positive up
figure
cfg.interactive = 'yes';
cfg.ylim = [-5 5]; % not necessary to use same maxmin from topoplot in ERPs

ft_multiplotER(cfg,bin1, bin2)

