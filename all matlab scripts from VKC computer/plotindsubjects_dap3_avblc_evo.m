%plot DYNATT PILOT data
% rlg 28 feb 2011

clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
%bin{1}='loud_tone';
bin{1}='regular';
bin{2}='irregular';

zscale = [-2 2]
% condname{1} = 'binary'
%condname{1} = 'regular'

%% set up configuration
% plot avg chan TFRs
load EGI129_1020lay.mat % load layout file - contains only 10-20 equivalent channels
%load cmapRWB.mat
%load tut_layout.mat % this layout excludes EOG channels
cfg.layout = EGI_lay1020;

cfg.parameter = 'powspctrm'
cfg.xlim = [-0.150 0.350] % time
cfg.interactive = 'no';
cfg.ylim = [7 50] %
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale %
cfg.colorbar = 'yes'
%cfg.colormap = cmap;


%cfg.baseline = 'yes' %
% cfg.baseline = [-0.200 0.400];
% cfg.baselinetype = 'relative';
time4ticks = [-0.100:0.100:0.300]; %% %% times on axis where you want ticks



for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_tfr_avblc_evo.mat') %    BASELINE CORRECTED
        load(filename)
        subjectdata.(bin{b}) = TFRwave_evo;
        clear TFRwave_evo
        
        figure(m)
        
        subplot(2,1,b)
        ft_singleplotTFR(cfg,subjectdata.(bin{b}))
        title(cat(2,bin{b},suj),'fontsize',10)
        set(gca,'XTick',time4ticks);
        set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
        
        
    end
    
    gcf
    %figure(m)
    %title((cat(2,suj,'evoked - Avg Chan')),'t')
    
    outfilename = cat(2,suj,' evoked avblc avg')
    
    saveas(gcf, outfilename, 'jpg')
    clear subjectdata
end


%% run separately
cfg = [];
cfg.layout = EGI_lay1020;
cfg.parameter = 'powspctrm'
cfg.xlim = [-0.150 0.350] % time
cfg.interactive = 'no';
cfg.layout = EGI_lay1020;
cfg.ylim = [7 50] %
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale %

%cfg.baseline = 'yes' %
% cfg.baseline = [-0.200 0.400];
% cfg.baselinetype = 'relative';
%time4ticks = [-0.200:0.100:0.400]; %% %% times on axis where you want ticks



figure(m)


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_tfr_avblc_evo.mat') %    BASELINE CORRECTED
        load(filename)
        subjectdata.(bin{b}) = TFRwave_evo;
        clear TFRwave_evo
        
        figure
        
        %subplot(2,1,b)
        ft_multiplotTFR(cfg,subjectdata.(bin{b}))
        title(cat(2,bin{b},suj),'fontsize',10)
        %title(bin{b},'fontsize',10)
        
        outfilename = cat(2,suj,bin{b},' evoked avblc multichan')
        
        saveas(gcf, outfilename, 'jpg')
        clear subjectdata outfilename
        
    end
end


%% headplots
close all

load tut_layout.mat
latsnaps = [-0.050 0 0.075 0.200]

cfg = [];

cfg.parameter = 'powspctrm'
%cfg.xlim = [-0.150 0.350] % time

cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [13 25] % JUST BETA??
%cfg.zlim = 'maxmin' %
cfg.zlim = [-1 2] % different than above %
%cfg.showlines = 'no'
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.fontsize = 10;
cfg.gridscale = 200;

%cfg.baseline = 'yes' %
% cfg.baseline = [-0.200 0.400];
% cfg.baselinetype = 'relative';
%time4ticks = [-0.200:0.100:0.400]; %% %% times on axis where you want ticks

L = length(latsnaps);
L_ms  = latsnaps*1000;


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_tfr_avblc_evo.mat') %    BASELINE CORRECTED
        load(filename)
        subjectdata.(bin{b}) = TFRwave_evo;
        clear TFRwave_evo
    end
    
    
    figure
    for k = 1:L
        subplot(2,L,k)
        
        cfg.xlim = [latsnaps(k) latsnaps(k)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),' ms')
        ft_topoplotTFR(cfg,subjectdata.(bin{1}))
      
    end
    
    
    for k = 1:L;
        subplot(2,L,(k+L));
        
        cfg.xlim = [latsnaps(k) latsnaps(k)]
        cfg.comment = cat(2,num2str(L_ms(k)),' ms')
        
        ft_topoplotTFR(cfg,subjectdata.(bin{2}))
    end
    
    %title(cat(2,bin{b},suj),'fontsize',10)
    %title(bin{b},'fontsize',10)
    
    outfilename = cat(2,suj,' evoked beta topo ')
    
    saveas(gcf, outfilename, 'jpg')
    clear subjectdata outfilename
    
    
end

