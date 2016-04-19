%plot DYNATT PILOT data
% rlg 10 april 2012

clear all; clc; close all


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='PhyAcc1';
bin{2}='PhyAcc2';
zscale = [-0.08 0.08];

%load all data here


for b=1:length(bin) %for each condition specified above
    
    filename = cat(2,'dynattiversen_',bin{b}, '_gravg_12sTLD_avblc_ind.mat'); %    BASELINE CORRECTED
    load(filename)
    data.(bin{b}) = TFgravg_ind;
    clear TFgravg_ind
    
end


%% set up configuration
% plot avg chan TFRs
load EGI129_1020lay.mat % load layout file - contains only 10-20 equivalent channels
%load cmapRWB.mat
%load tut_layout.mat % this layout excludes EOG channels
cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'
cfg.xlim = [-0.150 0.800] % time
cfg.interactive = 'no';
cfg.ylim = [12 55] %
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale %
cfg.colorbar = 'yes'
%cfg.colormap = cmap;
% cfg.baseline = 'yes' %
% cfg.baseline = [-0.150 0.550]; %% WHOLE EPOCH
% cfg.baselinetype = 'relative';
time4ticks = [0:0.200:0.800]; %% %% times on axis where you want ticks
cfg.channel = 'E11'


    figure

for b=1:length(bin) %for each condition specified above
    %

    
    subplot(2,1,b)
    ft_singleplotTFR(cfg,data.(bin{b}))
    %title(cat(2,bin{b},suj),'fontsize',10)
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    
    
end

gcf
%figure(m)
%title((cat(2,suj,'indked - Avg Chan')),'t')

outfilename = ('gravg induced Fz')

saveas(gcf, outfilename, 'jpg')

%clear subjectdata



%% run separately
cfg = [];
cfg.layout = EGI_lay1020;
cfg.parameter = 'powspctrm'
cfg.xlim = [-0.150 0.800] % time
cfg.interactive = 'no';
cfg.layout = EGI_lay1020;
cfg.ylim = [12 55] %
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale %

% cfg.baseline = 'yes' %
% cfg.baseline = [-0.150 0.550]; %% WHOLE EPOCH
% cfg.baselinetype = 'relative';
time4ticks = [0:0.200:0.800]; %% %% times on axis where you want ticks



figure




for b=1:length(bin) %for each condition specified above
    
    %         filename = cat(2,suj,'_',bin{b},'_tfr_ind.mat') %    BASELINE CORRECTED
    %         load(filename)
    %         subjectdata.(bin{b}) = TFRwave_ind;
    %         clear TFRwave_ind
    %
    figure
    
    %subplot(2,1,b)
    ft_multiplotTFR(cfg,data.(bin{b}))
    title(bin{b},'fontsize',10)
    %title(bin{b},'fontsize',10)
    
    outfilename = cat(2,'gravg',bin{b},' induced multichan avblc')
    
    saveas(gcf, outfilename, 'jpg')
    clear outfilename %subjectdata
    
end


%% headplots
%close all
figure


load tut_layout.mat
%latsnaps = [-0.050 0 0.075 0.200 0.535 0.585 0.660]
latsnaps = [0.100 0.300 0.700]

cfg = [];

cfg.parameter = 'powspctrm'
%cfg.xlim = [-0.150 0.350] % time

cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [15 29] %  beta
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale % same as above %
%cfg.showlines = 'no'
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.fontsize = 10;
cfg.gridscale = 200;

% cfg.baseline = 'yes' %
% cfg.baseline = [-0.150 0.550]; %% WHOLE EPOCH
% cfg.baselinetype = 'relative';
%time4ticks = [-0.200:0.100:0.400]; %% %% times on axis where you want ticks

L = length(latsnaps);
L_ms  = latsnaps*1000;



%     for b=1:length(bin) %for each condition specified above
%
%         filename = cat(2,suj,'_',bin{b},'_tfr_ind.mat') %    BASELINE CORRECTED
%         load(filename)
%         subjectdata.(bin{b}) = TFRwave_ind;
%         clear TFRwave_ind
%     end


figure
for k = 1:L
    subplot(2,L,k)
    
    cfg.xlim = [(latsnaps(k)-0.100) latsnaps(k)]
    
    cfg.comment = cat(2,num2str(L_ms(k)-100),'-',num2str(L_ms(k)),' ms')
    ft_topoplotTFR(cfg,data.(bin{1}))
    
end


for k = 1:L;
    subplot(2,L,(k+L));
    
    cfg.xlim = [(latsnaps(k)-0.100) latsnaps(k)]
    cfg.comment = cat(2,num2str(L_ms(k)-100),'-',num2str(L_ms(k)),' ms')
    
    ft_topoplotTFR(cfg,data.(bin{2}))
end

%title(cat(2,bin{b},suj),'fontsize',10)
%title(bin{b},'fontsize',10)

outfilename = cat(2,'gravg',' induced beta topo avblc')

saveas(gcf, outfilename, 'jpg')
clear outfilename %subjectdata


%just gamma
cfg.ylim = [30 50] % JUST gamma





%     for b=1:length(bin) %for each condition specified above
%
%         filename = cat(2,suj,'_',bin{b},'_tfr_ind.mat') %    BASELINE CORRECTED
%         load(filename)
%         subjectdata.(bin{b}) = TFRwave_ind;
%         clear TFRwave_ind
%     end


figure
for k = 1:L
    subplot(2,L,k)
    
    cfg.xlim = [(latsnaps(k)-0.100) latsnaps(k)]
    
    cfg.comment = cat(2,num2str(L_ms(k)-100),'-',num2str(L_ms(k)),' ms')
    ft_topoplotTFR(cfg,data.(bin{1}))
    
end


for k = 1:L;
    subplot(2,L,(k+L));
    
    cfg.xlim = [(latsnaps(k)-0.100) latsnaps(k)]
    cfg.comment = cat(2,num2str(L_ms(k)-100),'-',num2str(L_ms(k)),' ms')
    
    ft_topoplotTFR(cfg,data.(bin{2}))
end

%title(cat(2,bin{b},suj),'fontsize',10)
%title(bin{b},'fontsize',10)

outfilename = cat(2,'gravg',' induced gamma topo avblc')

saveas(gcf, outfilename, 'jpg')
clear outfilename %subjectdata

