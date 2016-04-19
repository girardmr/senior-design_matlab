%plot DYNATT PILOT data
% rlg 28 feb 2011

clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='loud_tone';
bin{2}='omit_tone';

condname{1} = 'binary'
condname{2} = 'omit loud tone'

%% set up configuration

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

cfg.layout = layout
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [-0.900 0.900] % time 0 to 600ms
cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [8 50] % 
% cfg.zlim = 'maxmin' % 
cfg.zlim = [-1 1] % 

cfg.baseline = 'no' % already baseline corrected
% % cfg.baseline = [-0.250 -0.100];
% cfg.baselinetype = 'relative';
time4ticks = [-0.780:0.390:0.780]; %% %% times on axis where you want ticks


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
        title(condname{b},'fontsize',10)
        set(gca,'XTick',time4ticks);
        set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
        
        figure(m+3)
        ft_multiplotTFR(cfg,subjectdata.(bin{b}))
        title(condname{b},'fontsize',10)
                      
    end
    

    figure(m)
    suplabel((cat(2,suj,'evoked - Avg Chan')),'t')

    outfilename = cat(2,suj,' evoked avg chan')

    saveas(gcf, outfilename, 'tif')
    clear subjectdata
end





