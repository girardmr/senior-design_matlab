%plot DYNATT PILOT data
% rlg 28 feb 2011

clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
%bin{1}='loud_tone';
bin{1}='regular';
bin{2}='irregular';

zscale = [0 3]

%% set up configuration
% plot avg chan TFRs

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

cfg.layout = layout
cfg.parameter = 'powspctrm'
cfg.xlim = [-0.200 0.400] % time
cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [7 50] %
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale %

%cfg.baseline = 'yes' %
cfg.baseline = [-0.200 0.400];
cfg.baselinetype = 'relative';
time4ticks = [-0.200:0.100:0.400]; %% %% times on axis where you want ticks



for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_tfr_evo.mat') %    BASELINE CORRECTED
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
    
    outfilename = cat(2,suj,' evoked avg chan')
    
    saveas(gcf, outfilename, 'fig')
    clear subjectdata
end


%% run separately
cfg = [];
cfg.layout = layout
cfg.parameter = 'powspctrm'
cfg.xlim = [-0.200 0.400] % time
cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [7 50] %
%cfg.zlim = 'maxmin' %
cfg.zlim = zscale %

%cfg.baseline = 'yes' %
cfg.baseline = [-0.200 0.400];
cfg.baselinetype = 'relative';
%time4ticks = [-0.200:0.100:0.400]; %% %% times on axis where you want ticks



figure(m)


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_tfr_evo.mat') %    BASELINE CORRECTED
        load(filename)
        subjectdata.(bin{b}) = TFRwave_evo;
        clear TFRwave_evo
        
        figure
        
        %subplot(2,1,b)
        ft_multiplotTFR(cfg,subjectdata.(bin{b}))
        title(cat(2,bin{b},suj),'fontsize',10)
        %title(bin{b},'fontsize',10)
        
        outfilename = cat(2,suj,bin{b},' evoked multichan')
        
        saveas(gcf, outfilename, 'fig')
        clear subjectdata outfilename
        
    end
end



