%topoplots of all data -ERPs
% rlg 17 feb 2011
clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
% group #1: campers
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';

% group # 2: controls
S{14}='w6c002';  S{15}='w6c003'; S{16}='w6c004'; S{17}='w6c007';  S{18}='w6c009'; S{19}='w6c010';
S{20}='w6c011';  S{21}='w6c012'; S{22}='w6c013'; S{23}='w6c014'; S{24} = 'w6c015';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='dif1v3';
bin{2}='dif1v2';

condname{1}='Happy Music - Neutral Sound';
condname{2}='Happy Music - Sad Music';

%% load files
subjectdata = {};
for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_MAP_',bin{b},'_ERP_blc.mat') %load filtered baseline corr ERPs
        load(filename)
        subjectdata.(suj).(bin{b}) = data;
        clear data
        
    end
end

%% set up configuration
cfg = [];
load tut_layout.mat % this layout excludes EOG channels
cfg.layout = EGI_layout129;
load cmapRWB.mat

%cfg.layout = layout
cfg.interactive = 'no';
%cfg.layout = EGI_layout129;
% cfg.baseline = [-0.250 -0.100];
cfg.channel = 'E4';%only FCz%

cfg.zparam  = 'avg';
cfg.xlim    = [0.095 0.105];%near 100ms - N1
cfg.zlim    = [-3 3];
%cfg.showlabels  = 'yes'; %show channel labels

cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.interactive = 'yes';
%cfg.colorbar = 'EastOutside';
cfg.colormap = cmap;
cfg.fontsize = 12;
cfg.gridscale = 200;

%% plot dif1vs3 N1
for m=1:8 %for each subject
    suj=S{m};
    subplot(2,4,m)
    cfg.comment = suj;
    ft_topoplotER(cfg,subjectdata.(suj).(bin{1}))
    outfilename = 'dif1v3 ERP topo N1 page1';
    
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')
end

figure
for m=9:16 %for each subject
    suj=S{m};
    subplot(2,4,m-8)
    cfg.comment = suj;
    ft_topoplotER(cfg,subjectdata.(suj).(bin{1}))
    outfilename = 'dif1v3 ERP topo N1 page2';
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')
    
end

figure
for m=17:24 %for each subject
    suj=S{m};
    subplot(2,4,m-16)
    
    cfg.comment = suj;
    ft_topoplotER(cfg,subjectdata.(suj).(bin{1}))
    outfilename = 'dif1v3 ERP topo N1 page3';
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')
end


%% plot dif1vs3 P2
cfg.xlim    = [0.175 0.200];%near 200ms - N1

for m=1:8 %for each subject
    suj=S{m};
    subplot(2,4,m)
    cfg.comment = suj;
    ft_topoplotER(cfg,subjectdata.(suj).(bin{2}))
    outfilename = 'dif1v2 ERP topo P2 page1';
    
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')
end

figure
for m=9:16 %for each subject
    suj=S{m};
    subplot(2,4,m-8)
    cfg.comment = suj;
    ft_topoplotER(cfg,subjectdata.(suj).(bin{2}))
    outfilename = 'dif1v2 ERP topo P2 page2';
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')
    
end

figure
for m=17:24 %for each subject
    suj=S{m};
    subplot(2,4,m-16)
    
    cfg.comment = suj;
    ft_topoplotER(cfg,subjectdata.(suj).(bin{2}))
    outfilename = 'dif1v2 ERP topo P2 page3';
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')
end


