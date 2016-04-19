%plot camper data
clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; S{17} = 'W725';
S{18}='W824'; S{19}='W825'; S{20}='W826'; S{21}='W827'; S{22}='W828'; 
S{23}='W829'; S{24}='W830';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';
% 
% condname{1}='Happy Music';
% condname{2}='Sad Music ';

% 

%% set up configuration

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

% cfg.layout = layout
% % cfg.xparam = 'time'
% % cfg.yparam = 'freq'
% cfg.parameter = 'powspctrm'
% cfg.xlim = [0 0.800] % time 0 to 600ms
% cfg.interactive = 'no';
% cfg.layout = EGI_layout129;
% cfg.ylim = [8 55] % theta, alpha, and beta frequencies
% cfg.zlim = 'maxmin' % theta, alpha, and beta frequencies
% %cfg.baseline = [-0.400 0.800] % whole epoch
% % cfg.baseline = [-0.250 -0.100];
% %cfg.baselinetype = 'relative';
% %cfg.zlim = 'maxmin' % theta, alpha, and beta frequencies

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above

        filename = cat(2,suj,'_CDT_',bin{b},'_tfr_avblc_ind.mat');
        load(filename)
        subjectdata.(bin{b}) = TFRwave_ind;
        clear TFRwave_ind
        
        figure(m)
        
        %% TFR
        cfg.layout = layout
        cfg.parameter = 'powspctrm'
        cfg.xlim = [0 0.800] % time 0 to 600ms
        cfg.interactive = 'no';
        cfg.layout = EGI_layout129;
        cfg.ylim = [8 55] % theta, alpha, and beta frequencies
        cfg.zlim = [-0.3 0.3] % theta, alpha, and beta frequencies        
        cfg.colorbar = 'EastOutside';

        subplot(2,2,b)
        ft_singleplotTFR(cfg,subjectdata.(bin{b}))
        title(bin{b},'fontsize',10)
        
        
        %% topoplot
        cfg.xlim = [0.100 0.150]
        cfg.colorbar = 'no'
                
        subplot(2,2,(b+2))
        ft_topoplotTFR(cfg,subjectdata.(bin{b}))
        %title(bin{b},'fontsize',10)
        title(cat(2,suj,' 100-150ms'))
        
                      
    end
    
    %title(cat(2,suj,'Induced - Avg Chan'),'t')

    outfilename = cat(2,suj,' induced avg chan')

    saveas(gcf, outfilename, 'jpg')
    clear subjectdata
end





