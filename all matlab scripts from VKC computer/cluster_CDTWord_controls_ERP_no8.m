%cluster ERP data on WS data
% mod. by Reyna 1 dec 2011
clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  S{5}='W7C006'; %S{6}='W7C008';
S{6}='W7C009';  S{7}='W7C010'; S{8}='W7C011'; S{9}='W7C012';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,'CDT_controlsno8_',bin{b},'_allSubj_ERP.mat');  
    load(filename);
    data{b}= ERPallSubj;
    clear ERPallSubj
    
end

%Read in the electrode locations for the my montage
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');

%neightbor selection
load tut_layout.mat
cfg = [];
cfg.neighbourdist    = 10;
cfg.layout           = EGI_layout129;
cfg.method        = 'distance';
neighbours = ft_prepare_neighbours(cfg,EGI_layout129);


%% perform the statistical test using randomization and a clustering approach
% ERP
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbours       = neighbours;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 3000; %should be 2500

cfg.latency          = [0.080 0.700]; % in seconds
cfg.avgovertime      = 'no'; 
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

designsubj  = 1:1:nsubj;
designcond1 = repmat(1,1,nsubj);
designcond2 = repmat(2,1,nsubj);


%design      = [designsubj designsubj designsubj designsubj; designcond1 designcond2 designcond3 designcond4; designcond5 designcond6 designcond7 designcond8];
design      = [designsubj designsubj; designcond1 designcond2];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % the independent variables
%% 

[stat]    = ft_timelockstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save CDTctrlno8_Words_ERP_stat.mat stat

clear stat


