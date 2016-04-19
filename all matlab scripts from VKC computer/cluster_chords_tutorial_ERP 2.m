% cluster ERPs for tutorial data - chords
% modified by Reyna oct 15 2010

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';

% load files for all subjects and conditions into one structure
for b=1:length(bin)
    
    filename = cat(2,'chords_ERP_',bin{b}, '_allSubj.mat');
    load(filename);
    data{b} = ERPallSubj;
    clear ERPallSubj
    
end

% read in list of channels that we want to test (this file excludes eye channels)
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');

nsubj  = length(S);

%% perform the statistical test using randomization and a clustering approach
% ERP
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage
cfg.neighbourdist    = 15; %max distance for neighbor channels to be included in cluster
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 2; % minimum number of neighbor channels for a cluster
cfg.clusteralpha     = 0.05; 
cfg.alpha            = 0.025; % alpha for the dependent t-tests. Must be 0.025 if using 2-tailed test.
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 1000; % number of permutations

cfg.latency          = [0 0.600]; % time window in seconds
cfg.avgovertime      = 'no'; 
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

designsubj  = 1:1:nsubj;
designcond1 = repmat(1,1,nsubj);
designcond2 = repmat(2,1,nsubj);

design      = [designsubj designsubj; designcond1 designcond2];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % the row of the design matrix containing the ind.variable
% 
[stat]    = ft_timelockstatistics(cfg, data{1}, data{2}); 
stat.cond1 = bin{1}; stat.cond2 = bin{2};%
save Chords_1vs2_ERP_stat.mat stat
clear stat
%%
[stat]    = ft_timelockstatistics(cfg, data{2}, data{3}); %
stat.cond1 = bin{2}; stat.cond2 = bin{3};%
save Chords_2vs3_ERP_stat.mat stat
clear stat

%%
[stat]    = ft_timelockstatistics(cfg, data{1}, data{3});
stat.cond1 = bin{1}; stat.cond2 = bin{3};%
save Chords_1vs3_ERP_stat.mat stat
clear stat

