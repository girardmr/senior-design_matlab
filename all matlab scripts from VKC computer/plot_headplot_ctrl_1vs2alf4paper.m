% Custom script to plot a significant cluster on grand-average
% mod. by RLG 27 may 2011

clear all; clc
%this one goes from 
band = 'EvoAlf';  %for naming purposes, say ERP here or the name of your frequency band of interest
clustercode = cat(2,'MAPctrl1vs2_ns_',band,'4paper'); % give some abbreviation for your cluster, which will be used to name the graphics files

%load MAPcamp_4vs5_evo_gam_stat.mat
 % make sure you load the right stat file
% cond1= stat.cond1; % we added the two condition names to the stat structure during clustering
% cond2= stat.cond2;
cond1 = 'HapMus'; %
cond2 = 'SadMus'; %

load(cat(2,'MAP_controls_',cond1, '_gravg_avblc_evo.mat'));
% use grand average files
bin1 = TFgravg_evo;
clear TFgravg_evo

load(cat(2,'MAP_controls_',cond2, '_gravg_avblc_evo.mat'));
bin2 = TFgravg_evo;
clear TFgravg_evo

%% step 2: find data at right times and frequencies to plot
% Specify here if it's positive or negative cluster (this one is a negative
% one); change value to a different number to plot a cluster rather than
% the first one.
% Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (negative cluster#1)Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand. This cluster's latency is: 144 to 516
latsnaps = [100 160 200]; % want "snapshots" at these latencies for this cluster - in ms
zscale = [-2 2]; % determine iteratively
freqband = [8 13]; % frequency band

%[x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes

% C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
% timeind_min = min(find(C_onlytime~=0));
% timeind_max = max(find(C_onlytime~=0));
% timelim = [stat.time(timeind_min) stat.time(timeind_max)];


%should correspond to stat.time*1000:
A= 0:4:600; % careful here: specify timepoints in ms that were used in clustering analysis. 

j = latsnaps/1000;
L = length(latsnaps);% how many subplots per condition

% for f=1:length(latsnaps)
%     m(f) = find(A==latsnaps(f)); %time indexes of stat data
% end
% 
% % now define time limits straight from the stats
% x1= timelim(1); x2=timelim(2);
% y1= freqband(1); y2=freqband(2);

%% load layout files and colormap file
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp'); % electrodes to plot; excludes eye channels

load tut_layout.mat 
load cmapRWB.mat
layout = EGI_layout129;


%% topoplot, highlights clusters
figure
cfg = [];

cfg.layout = layout;
cfg.elec = elec;
cfg.ylim= freqband;
cfg.zlim = zscale;
cfg.baseline = 'no';
% cfg.highlight = 'on';
% cfg.highlightsymbol    = '*'; %turns on the option to highlight certain channels
% %   cfg.highlightcolor     = highlight marker color (default = [0 0 0] (black))
% cfg.highlightsize      = 10;
% %   cfg.highlightfontsize  = highlight marker size (default = 8)
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.parameter   = 'powspctrm';
cfg.interactive = 'yes';
%cfg.colorbar = 'EastOutside';
cfg.colormap = cmap;
cfg.fontsize = 12;
cfg.gridscale = 200;
    

%plot condition#1 in top row

for k = 1:L %# of subplots
    
    subplot(2,L,k);
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    %chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    %cfg.highlightchannel = stat.label(chan_temp); %highlights those channels   
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot

    ft_topoplotTFR(cfg, bin1);
    clear chan_temp
end

gcf % get current figure
% don't need to repeat the cfg here; it will use the same cfg as above.

%plot condition#2 in second row
for k = 1:L;  % subplots
    
    subplot(2,L,(k+L));
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    %chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    %cfg.highlightchannel = stat.label(chan_temp);    % highlights those channels
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
    
    ft_topoplotTFR(cfg, bin2);
    
    clear chan_temp
end

%maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
maptitle = cat(2,clustercode,'clustermap');
% supertitle(maptitle); %% need the Matlab function supertitle to use that,
% but careful, it can cause some subplots to line up in a weird way
saveas(gcf, maptitle, 'fig'); % saves two versions - Matlab fig file and tiff
saveas(gcf, maptitle, 'epsc');
clear maptitle

% %% find all significant channels, to be used after to make TFR plot
% SigChanInd=unique(x);%see line 32 where we defined x
% 
% for e=1:length(SigChanInd);
%     
%     SigChan{e} = stat.label{SigChanInd(e)};
% 
% end
% sigchanfilename = cat(2,'SigChan_',clustercode,'.mat')
% save (sigchanfilename, 'SigChan'); % save significant channels in own .mat file
% 
% %% now plot TFRs in each conditions; use ft_singleplotTFR to take mean across significant channels
% 
% figure % new figure
% cfg = [];
% cfg.channel = SigChan; %just the significant ones in the cluster, defined above
% 
% cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
% cfg.zlim         = zscale; % here we are using same scale as in topoplots
% cfg.ylim         = [24 48]; % could also use instead cfg.ylim = freqband 
% cfg.xlim         = [0 0.600]; %time in seconds for TFR plot
% cfg.colorbar = 'EastOutside';
% cfg.layout       =  layout; 
% cfg.colormap     = cmap;
% 
% % plot first condition
% subplot(2,2,1);
% ft_singleplotTFR(cfg,bin1); hold on
% 
% %draw black box around time and frequency boundaries based on significant cluster
% plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on 
% plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
% plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
% plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
% 
% time4ticks = 0:0.200:0.600; % put ticks at these points in seconds
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % changes axes tick labels to time in ms
% 
% % title(' ')
% 
% title('Face Matches Music')
% 
% %plot second condition, with same parameters
% subplot(2,2,3);
% ft_singleplotTFR(cfg,bin2); hold on
% 
% %draw black box around time and frequency boundaries based on significant cluster
% plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on 
% plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
% plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
% plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
% time4ticks = 0:0.200:0.600; 
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% xlabel('Time (ms)')
% ylabel('Frequency (Hz)')
% title('Face Mismatches Music')
% 
% TFtitle = cat(2,clustercode,'clusterTFR');
% saveas(gcf, TFtitle, 'fig');
% saveas(gcf, TFtitle, 'epsc');
% 
% %% these are just to get a color bar
% % MAKE COLORBAR APPEAR IN %, SO ZSCALE X 100 
% cfg.xlim = timelim; %time of cluster
% cfg.ylim = freqband; %only frequency band of cluster
% cfg.gridscale = 200;
% cfg.zlim         = zscale*100
% cfg.comment = 'no';
% cfg.colorbar = 'WestOutside';
% 
% figure
% ft_topoplotTFR(cfg,bin1);
% scaletitle = cat(2,clustercode,'Scale');
% saveas(gcf, scaletitle, 'fig');
% saveas(gcf, scaletitle, 'epsc');