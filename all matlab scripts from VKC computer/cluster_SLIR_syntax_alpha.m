% cluster induced data on chords - tutorial
% mod. by Reyna oct 22, 2010

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';

nsubj=length(S);

% load files for all subjects and conditions into one structure
for b=1:length(bin)
    
    filename = cat(2,bin{b}, '_syntax_allSubj_avblc_ind.mat');
    load(filename);
    data{b} = TFallSubj_ind;
    clear TFallSubj_ind
    
end

% read in list of channels that we want to test (this file excludes eye channels)
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');

%neighbour selection - find neighboring channels
%load tut_layout.mat
cfg = [];
cfg.neighbourdist    = 12; %%max distance for neighbor channels to be included in cluster
cfg.elec = elec;
cfg.method        = 'distance';
neighbours = ft_prepare_neighbours(cfg,elec); % note the British spelling

%% perform the statistical test using randomization and a clustering approach
% ALPHA
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage
cfg.neighbours       = neighbours;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 1;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 1000; %

cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [8 12];%alpha 
cfg.avgovertime      = 'no'; 
cfg.avgoverfreq      = 'yes';
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

%%
[stat]    = ft_freqstatistics(cfg, data{2}, data{3}); %
stat.cond1 = bin{2};
stat.cond2 = bin{3};
save SLIR_syntax_2vs3_avblc_ind_alf_stat.mat stat
clear stat

% %%
% [stat]    = ft_freqstatistics(cfg, data{1}, data{3}); %
% save Chords_1vs3_avblc_ind_alf_stat.mat stat
% clear stat

