%plot DYNATT PILOT data
% rlg 10 april 2012

clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101'; S{2} = 'SLIR_102'; S{3}='SLIR_103'; S{4} = 'SLIR_104';% 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='PhyAcc1';
bin{2}='PhyAcc2';
zscale = [0.75 1.25];
%zscale = 'maxmin'

%load all data here
for m=1:length(S) %for each subject
    suj=S{m};
    
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_tfr_ind.mat') %    BASELINE CORRECTED
        load(filename)
        data.(suj).(bin{b}) = TFRwave_ind;
        clear TFRwave_ind
        
    end
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
cfg.baseline = 'yes' %
cfg.baseline = [-0.150 0.850]; %% WHOLE EPOCH
cfg.baselinetype = 'relative';
time4ticks = [0:0.200:0.800]; %% %% times on axis where you want ticks
cfg.channel = 'Cz'



for m=1:length(S) %for each subject
    suj=S{m};
    
     for b=1:length(bin) %for each condition specified above
%                 
        figure(m)
        
        subplot(2,1,b)
        ft_singleplotTFR(cfg,data.(suj).(bin{b}))
        %title(cat(2,bin{b},suj),'fontsize',10)
        set(gca,'XTick',time4ticks);
        set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
        
        
    end
    
    gcf
    %figure(m)
    %title((cat(2,suj,'indked - Avg Chan')),'t')
    
    outfilename = cat(2,suj,' induced Cz')
    
    saveas(gcf, outfilename, 'jpg')
    
    %clear subjectdata
end


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

cfg.baseline = 'yes' %
cfg.baseline = [-0.150 0.800]; %% WHOLE EPOCH
cfg.baselinetype = 'relative';
time4ticks = [0:0.200:0.800]; %% %% times on axis where you want ticks



figure(m)


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
%         filename = cat(2,suj,'_',bin{b},'_tfr_ind.mat') %    BASELINE CORRECTED
%         load(filename)
%         subjectdata.(bin{b}) = TFRwave_ind;
%         clear TFRwave_ind
%         
        figure
        
        %subplot(2,1,b)
        ft_multiplotTFR(cfg,data.(suj).(bin{b}))
        title(cat(2,bin{b},suj),'fontsize',10)
        %title(bin{b},'fontsize',10)
        
        outfilename = cat(2,suj,bin{b},' induced multichan')
        
        saveas(gcf, outfilename, 'jpg')
        clear outfilename %subjectdata 
        
    end
end


%% headplots
%close all
figure


load tut_layout.mat
%latsnaps = [-0.050 0 0.075 0.200 0.535 0.585 0.660]
latsnaps = [0 0.050 0.200 0.250 0.650]

cfg = [];

cfg.parameter = 'powspctrm'
%cfg.xlim = [-0.150 0.350] % time

cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [20 30] % JUST high beta
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale % same as above %
%cfg.showlines = 'no'
cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.fontsize = 10;
cfg.gridscale = 200;

cfg.baseline = 'yes' %
cfg.baseline = [-0.150 0.800]; %% WHOLE EPOCH
cfg.baselinetype = 'relative';
%time4ticks = [-0.200:0.100:0.400]; %% %% times on axis where you want ticks

L = length(latsnaps);
L_ms  = latsnaps*1000;


for m=1:length(S) %for each subject
    suj=S{m};
    
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
        
        cfg.xlim = [latsnaps(k) latsnaps(k)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),' ms')
        ft_topoplotTFR(cfg,data.(suj).(bin{1}))
      
    end
    
    
    for k = 1:L;
        subplot(2,L,(k+L));
        
        cfg.xlim = [latsnaps(k) latsnaps(k)]
        cfg.comment = cat(2,num2str(L_ms(k)),' ms')
        
        ft_topoplotTFR(cfg,data.(suj).(bin{2}))
    end
    
    %title(cat(2,bin{b},suj),'fontsize',10)
    %title(bin{b},'fontsize',10)
    
    outfilename = cat(2,suj,' induced beta topo ')
    
    saveas(gcf, outfilename, 'jpg')
    clear outfilename %subjectdata 
    
    
end

%just gamma
cfg.ylim = [30 50] % JUST gamma



for m=1:length(S) %for each subject
    suj=S{m};
    
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
        
        cfg.xlim = [latsnaps(k) latsnaps(k)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),' ms')
        ft_topoplotTFR(cfg,data.(suj).(bin{1}))
      
    end
    
    
    for k = 1:L;
        subplot(2,L,(k+L));
        
        cfg.xlim = [latsnaps(k) latsnaps(k)]
        cfg.comment = cat(2,num2str(L_ms(k)),' ms')
        
        ft_topoplotTFR(cfg,data.(suj).(bin{2}))
    end
    
    %title(cat(2,bin{b},suj),'fontsize',10)
    %title(bin{b},'fontsize',10)
    
    outfilename = cat(2,suj,' induced gamma topo ')
    
    saveas(gcf, outfilename, 'jpg')
    clear outfilename %subjectdata 
    
    
end

