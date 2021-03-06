% NOT FINISHED!!!!!
%plot camper data -ERPs
% rlg 17 feb 2011
% it looks like the baseline correction didn't work!
% and not sure about lowpass. Need to follow up
clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';

bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %

condname{1}='Happy Music';
condname{2}='Sad Music ';
condname{3}='Neutral Sound';
condname{4}='Face Match';
condname{5}='Face Mismatch';
condname{6}='Face Neutral';

%% set up configuration

%load tut_layout.mat % this layout excludes EOG channels
%layout = EGI_layout129;

%cfg.layout = layout
cfg.interactive = 'no';
%cfg.layout = EGI_layout129;
% cfg.baseline = [-0.250 -0.100];
cfg.channel = 'E4';%only FCz%

cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 0.800];%time in seconds
cfg.ylim    = [-12 12];
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
cfg.projection = 'polar'; % comment out if plotting positive up
cfg.rotate = 180; % comment out if plotting positive up
upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
cfg.layout = upsidedown; % comment out if plotting positive up
%cfg.layout = layout; use this if plotting positive up


%%
for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_MAP_',bin{b},'_ERP_blc.mat') %load filtered baseline corr ERPs
        load(filename)
        subjectdata.(bin{b}) = data;
        clear data
        
    end
    figure(m)
    
    %% first set
    subplot(2,2,1)
    ft_singleplotER(cfg,subjectdata.(bin{1}),subjectdata.(bin{2}),subjectdata.(bin{3}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    
    %just for legend
    subplot(2,2,3)
    ft_singleplotER(cfg,subjectdata.(bin{1}),subjectdata.(bin{2}),subjectdata.(bin{3}))
    legend(condname{1},condname{2},condname{3},'Location','North')
    
    %% second set
    subplot(2,2,2)
    ft_singleplotER(cfg,subjectdata.(bin{4}),subjectdata.(bin{5}),subjectdata.(bin{6}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    
    %just for legend
    subplot(2,2,4)
    ft_singleplotER(cfg,subjectdata.(bin{4}),subjectdata.(bin{5}),subjectdata.(bin{6}))
    legend(condname{4},condname{5},condname{6},'Location','North')
    
%     %% third set
%     
%     subplot(2,3,3)
%     ft_singleplotER(cfg,subjectdata.(bin{7}),subjectdata.(bin{8}),subjectdata.(bin{9}))
%     set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%     %just for legend
%     subplot(2,3,6)
%     ft_singleplotER(cfg,subjectdata.(bin{7}),subjectdata.(bin{8}),subjectdata.(bin{9}))
%     
%     legend(condname{7},condname{8},condname{9},'Location','North')
%     
%     
%     
    
    suplabel((cat(2,suj,' ERP - E4')),'t')
    
    outfilename = cat(2,suj,' bigbins ERP - E4')
    
    saveas(gcf, outfilename, 'tif')
    saveas(gcf, outfilename, 'fig')

    clear subjectdata
end




