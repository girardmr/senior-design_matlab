%plot controls data -ERPs
% rlg 9 march 2011

clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014';  


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
cfg.interactive = 'yes';
%cfg.layout = EGI_layout129;
% cfg.baseline = [-0.250 -0.100];

cfg.zparam  = 'avg';
%cfg.xlim    = [-0.100 0800];%time in seconds
cfg.ylim    = [-14 6];
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
cfg.channel = 'all'


%%
for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_MAP_',bin{b},'_ERP_blc.mat') %load filtered baseline corr ERPs
        load(filename)
        subjectdata.(bin{b}) = data;
        clear data
        
    end
    
    %% first set - music
    figure
    cfg.xlim    = [-0.100 0.650];%time in seconds
    
    ft_multiplotER(cfg,subjectdata.(bin{1}),subjectdata.(bin{2}),subjectdata.(bin{3}));
    set(gca,'YDir','reverse'); % PLOT NEGATIVE UP (OPTIONAL)
    %     legend(condname{1},condname{2},condname{3},'Location','North');
    supertitle(cat(2,suj,' music ERP multi'));
    outfilename = cat(2,'MAP ctrl',suj,' music- ERP multi')
    saveas(gcf, outfilename, 'tif');
    saveas(gcf, outfilename, 'fig');
    
    clear outfilename
    
    %% second set -
    figure
    cfg.xlim    = [-0.100 1];%time in seconds
    
    ft_multiplotER(cfg,subjectdata.(bin{4}),subjectdata.(bin{5}),subjectdata.(bin{6}));
    set(gca,'YDir','reverse'); % PLOT NEGATIVE UP (OPTIONAL)
    %     legend(condname{4},condname{5},condname{6},'Location','North');
    
    supertitle(cat(2,suj,' faces ERP multi'));
    outfilename = cat(2,'MAP ctrl',suj,' faces- ERP multi')
    saveas(gcf, outfilename, 'tif');
    saveas(gcf, outfilename, 'fig');
    clear outfilename
    
    clear subjectdata
end




