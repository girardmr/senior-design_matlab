%cluster evoked data on WS data
% mod. by Reyna 22 feb 2011


clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}= 'HapMus';
bin{2}= 'SadMus';
bin{3}= 'NeutSon';
bin{4}= 'mus_Match_face'; %
bin{5}= 'mus_Mismatch_face'; %
bin{6}= 'neutson_bothface'; %

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,'MAP_controls_',bin{b}, '_allSubj_avblc_evo.mat');
    load(filename);
    data{b}=TFallSubj_evo;
    clear TFallSubj_evo
    
end

%Read in the electrode locations for the my montage
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');


% %% perform the statistical test using randomization and a clustering approach
% % ALPHA
% cfg = [];
% cfg.channel          = elec.label; %
% nsubj=length(S);
% cfg.neighbourdist    = 10;
% cfg.elec             = elec;
% cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
% cfg.minnbchan        = 2;
% cfg.clusteralpha     = 0.05;
% cfg.alpha            = 0.025;
% cfg.clustertail      = 0; %has to be 1 if Ftest
% cfg.tail             = 0; %has to be 1 if Ftest
% cfg.numrandomization = 3000; %should be 2500
% 
% cfg.latency          = [0 0.600]; % in seconds
% cfg.frequency        = [8 12]; %alpha
% cfg.avgovertime      = 'no'; 
% cfg.avgoverfreq      = 'yes';
% cfg.avgoverchan      = 'no';
% 
% cfg.correctm         = 'cluster';
% cfg.method           = 'montecarlo';
% cfg.feedback         = 'gui';
% 
% designsubj  = 1:1:nsubj;
% designcond1 = repmat(1,1,nsubj);
% designcond2 = repmat(2,1,nsubj);
% 
% 
% %design      = [designsubj designsubj designsubj designsubj; designcond1 designcond2 designcond3 designcond4; designcond5 designcond6 designcond7 designcond8];
% design      = [designsubj designsubj; designcond1 designcond2];
% cfg.design  = design;
% cfg.uvar = 1;   % "subject" is unit of observation
% cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables
% %% MUSIC
% 
% [stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
% stat.cond1 = bin{1};
% stat.cond2 = bin{2};
% save MAPctrl_1vs2_evo_alf_stat.mat stat
% clear stat
% %%
% [stat]    = ft_freqstatistics(cfg, data{2}, data{3}); 
% stat.cond1 = bin{2};
% stat.cond2 = bin{3};%
% save MAPctrl_2vs3_evo_alf_stat.mat stat
% clear stat
% 
% %%
% [stat]    = ft_freqstatistics(cfg, data{1}, data{3});
% stat.cond1 = bin{1};
% stat.cond2 = bin{3};%
% save MAPctrl_1vs3_evo_alf_stat.mat stat
% clear stat
% 
% %% FACES
% cfg.latency          = [0 0.8]; % in seconds
% 
% [stat]    = ft_freqstatistics(cfg, data{4}, data{5}); %
% stat.cond1 = bin{4};
% stat.cond2 = bin{5};
% save MAPctrl_4vs5_evo_alf_stat.mat stat
% 
% clear stat
% %%
% [stat]    = ft_freqstatistics(cfg, data{5}, data{6}); 
% stat.cond1 = bin{5};
% stat.cond2 = bin{6};%
% save MAPctrl_5vs6_evo_alf_stat.mat stat
% clear stat
% 
% %%
% [stat]    = ft_freqstatistics(cfg, data{4}, data{6});
% stat.cond1 = bin{4};
% stat.cond2 = bin{6};%
% save MAPctrl_4vs6_evo_alf_stat.mat stat
% clear stat

%% perform the statistical test using randomization and a clustering approach
% BETA
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbourdist    = 10;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 3000; %should be 2500

cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [13 25]; %beta
cfg.avgovertime      = 'no'; 
cfg.avgoverfreq      = 'yes';
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the evoependent variables
%% MUSIC

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save MAPctrl_1vs2_evo_beta_stat.mat stat
clear stat
%%
[stat]    = ft_freqstatistics(cfg, data{2}, data{3}); 
stat.cond1 = bin{2};
stat.cond2 = bin{3};%
save MAPctrl_2vs3_evo_beta_stat.mat stat
clear stat

%%
[stat]    = ft_freqstatistics(cfg, data{1}, data{3});
stat.cond1 = bin{1};
stat.cond2 = bin{3};%
save MAPctrl_1vs3_evo_beta_stat.mat stat
clear stat

%% FACES
cfg.latency          = [0 0.8]; % in seconds

[stat]    = ft_freqstatistics(cfg, data{4}, data{5}); %
stat.cond1 = bin{4};
stat.cond2 = bin{5};
save MAPctrl_4vs5_evo_beta_stat.mat stat
clear stat
%%
[stat]    = ft_freqstatistics(cfg, data{5}, data{6}); 
stat.cond1 = bin{5};
stat.cond2 = bin{6};%
save MAPctrl_5vs6_evo_beta_stat.mat stat
clear stat

%%
[stat]    = ft_freqstatistics(cfg, data{4}, data{6});
stat.cond1 = bin{4};
stat.cond2 = bin{6};%
save MAPctrl_4vs6_evo_beta_stat.mat stat
clear stat


%% perform the statistical test using randomization and a clustering approach
% GAMMA
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbourdist    = 10;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 3000; %should be 2500

cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [26 45]; %gamma
cfg.avgovertime      = 'no'; 
cfg.avgoverfreq      = 'yes';
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the evoependent variables
%% MUSIC

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save MAPctrl_1vs2_evo_gam_stat.mat stat
clear stat
%%
[stat]    = ft_freqstatistics(cfg, data{2}, data{3}); 
stat.cond1 = bin{2};
stat.cond2 = bin{3};%
save MAPctrl_2vs3_evo_gam_stat.mat stat
clear stat

%%
[stat]    = ft_freqstatistics(cfg, data{1}, data{3});
stat.cond1 = bin{1};
stat.cond2 = bin{3};%
save MAPctrl_1vs3_evo_gam_stat.mat stat
clear stat

%% FACES
cfg.latency          = [0 0.8]; % in seconds
[stat]    = ft_freqstatistics(cfg, data{4}, data{5}); %
stat.cond1 = bin{4};
stat.cond2 = bin{5};
save MAPctrl_4vs5_evo_gam_stat.mat stat
clear stat
%%
[stat]    = ft_freqstatistics(cfg, data{5}, data{6}); 
stat.cond1 = bin{5};
stat.cond2 = bin{6};%
save MAPctrl_5vs6_evo_gam_stat.mat stat
clear stat

%%
[stat]    = ft_freqstatistics(cfg, data{4}, data{6});
stat.cond1 = bin{4};
stat.cond2 = bin{6};%
save MAPctrl_4vs6_evo_gam_stat.mat stat
clear stat






