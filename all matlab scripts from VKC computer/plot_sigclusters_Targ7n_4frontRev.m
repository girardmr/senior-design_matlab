%plot significant clusters in evoked data - targets
% still need to 
%plot significant clusters; careful here, this whole cell needs to be
%updated for each new pair of conditions; also change frequencies and time
%of plots
clear all; clc
clustercode = 'Targ7_4frontRev';
cond1= 'WAmain';
cond2= 'MAmain';
band = 'indBeta';
% POS cluster, be careful
%freqband= [13 29]; %beta

A= 0:2:800; % for targets; must change times for other stim

zscale = [-0.25 0.25]; %
%zscale = 'maxmin'; % %


load Targ_WAvsMA_main_avblc_ind_nbeta_stat.mat

load targ_WAmain_gravg_avblc_ind.mat
bin1 = TFgravg_ind;
clear TFgravg_ind

load targ_MAmain_gravg_avblc_ind.mat
bin2 = TFgravg_ind;
clear TFgravg_ind

difwave = bin1;
difwave.powspctrm = bin1.powspctrm  - bin2.powspctrm;


%%
% POS cluster, be careful
%Big_mat = (stat.negclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (negative cluster#1)
Big_mat = (stat.posclusterslabelmat == 1); %find time,channel pairs where%electrode belongs to significant cluster (pos cluster#1)

%define latsnaps and zscale by hand
latsnaps = [400]; % want snapshots at these latencies for this cluster
zscale = [-0.30 0.30]; % %

[x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes

C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0));
timeind_max = max(find(C_onlytime~=0));
timelim = [stat.time(timeind_min) stat.time(timeind_max)];

freqband = stat.cfg.frequency; % frequency band

%should correspond to stat.time*1000:
A= 0:2:800; % for targets; must change times for other stim

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

figure(3) %use figure 3 from targ5n
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
    
    subplot(2,2,3); %
    cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
    chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
    cfg.highlightchannel = stat.label(chan_temp); %highlights those channels   
    cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
    %cfg.comment = '  '
    ft_topoplotTFR(cfg, difwave);
    clear chan_temp
end

gcf % get current figure
% don't need to repeat the cfg here; it will use the same cfg as above.

%plot condition#2 in second row
% for k = 1:L;  % subplots
%     
%     subplot(2,L,(k+L));
%     cfg.xlim= [j(k) j(k)]; % goes to the time point defined above
%     chan_temp = find(Big_mat(:,m(k))==1); %find indices of stat matrix corresponding to the channels
%     cfg.highlightchannel = stat.label(chan_temp);    % highlights those channels
%     cfg.comment = cat(2,num2str(latsnaps(k)),' ms'); % writes the latency in ms above each subplot
%     
%     ft_topoplotTFR(cfg, bin2);
%     
%     clear chan_temp
% end

% text(0.04,0.65,cond1)
% text(0.04,0.22,cond2)
% text(0.10,0.40,'Difspectra (Pseudo - Word)')

%maptitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clustermap ',band));
%maptitle = cat(2,clustercode,'clustermap');
maptitle = 'targAlldifftopo4frontRev';
%supertitle(maptitle);
saveas(gcf, maptitle, 'fig');
%saveas(gcf, maptitle, 'epsc');
    clear maptitle
    
        
SigChanInd=unique(x);
for e=1:length(SigChanInd);
    
    SigChan{e} = stat.label{SigChanInd(e)};

end

% save SigChan_Targ5n.mat SigChan

% cfg = [];
% cfg.channel= SigChan; %just the significant ones in the cluster!
% 
% cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
% cfg.zlim         = zscale;
% cfg.ylim         = [8 30]; %frequency to plot
% cfg.xlim         = [0 0.800];%time I CAN'T SEE THE COLORBAR!??
% cfg.colorbar = 'EastOutside';
% cfg.showlabels   = 'no';
% cfg.colormap = cmap;
% cfg.layout  = soprolay_noCzwithnewmask;
% 
% % plot first condition
% % plot first condition
% figure
% subplot(2,2,1);
% singleplotTFR(cfg,bin1); hold on
% plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
% plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
% plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
% plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
% time4ticks = [-0.200:0.200:0.800]; 
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% title(' ')
% 
% subplot(2,2,3);
% singleplotTFR(cfg,bin2); hold on
% plot([x1 x2],[y1 y1],'-k','LineWidth',2); hold on
% plot([x2 x2],[y1 y2],'-k','LineWidth',2); hold on
% plot([x2 x1],[y2 y2],'-k','LineWidth',2); hold on
% plot([x1 x1],[y2 y1],'-k','LineWidth',2); hold off
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% xlabel('Time (ms)')
% ylabel('Frequency (Hz)')
% title(' ')
% 
% %these are just to get a color bar, but nice b/c shows average
% subplot(2,2,2)
% cfg.xlim = timelim;%time of sig cluster
% cfg.ylim = freqband; %
% cfg.comment = 'no';
% cfg.colorbar = 'WestOutside';
% 
% topoplotTFR(cfg,bin1);
% 
% subplot(2,2,4)
% topoplotTFR(cfg,bin2);
% TFtitle = cat(2,clustercode,'clusterTFR');
% %TFtitle = (cat(2,clustercode,' ',cond1,'vs', cond2,' clusterTFR ',band));
% supertitle(TFtitle);
% saveas(gcf, TFtitle, 'fig');
% saveas(gcf, TFtitle, 'tif');
% 
% 

%these are just to get a color bar
% MAKE COLORBAR APPEAR IN %, SO ZSCALE X 100 
figure(6)
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


