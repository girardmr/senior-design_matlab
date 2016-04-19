%cluster ERP data on WS data
% mod. by Reyna 16 march 2012
clear all; clc

%% ONLY TEMPORAL LISTENER SUBGROUP SUBJECTS FOR THIS ONE
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701'; S{2}='W702'; S{3}='W708'; S{4}='W709';  S{5}='W711'; S{6}='W712'; 
S{7}='W714'; S{8}='W715'; S{9}='W717'; S{10}='W722'; S{11}='W723';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,'CDT_campers_',bin{b},'_allSubj_temporalgroup_ERP.mat'); 
    load(filename);
    data{b}= ERPallSubj;
    clear ERPallSubj
    
end

% read in list of channels that we want to test (this file excludes eye channels)
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');

%neighbour selection - find neighboring channels USE THIS NEW FUNCTION
%w/more conservative clustering.
%load tut_layout.mat
cfg = [];
cfg.neighbourdist    = 14; %%max distance for neighbor channels to be included in cluster
cfg.elec = elec;
cfg.method        = 'distance';
neighbours = ft_prepare_neighbours(cfg,elec); % note the British spelling


%% perform the statistical test using randomization and a clustering approach
% ERP
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage...
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

cfg.latency          = [0 0.900]; % in seconds
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables
%% MUSIC

[stat]    = ft_timelockstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save CDTcamp_temporalgroup_Words_ERP_stat.mat stat

clear stat


