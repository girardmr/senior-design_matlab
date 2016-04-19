%cluster indked data on WS data
% mod. by Reyna 13 dec 2011

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; S{17} = 'W725';
S{18}='W824'; S{19}='W825'; S{20}='W826'; S{21}='W827'; S{22}='W828'; 
S{23}='W829'; S{24}='W830';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,'CDT_campers_',bin{b}, '_allSubj_avblc_ind.mat');
    load(filename);
    data{b}=TFallSubj_ind;
    clear TFallSubj_ind
    
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
neighbours = ft_neighbourselection(cfg,EGI_layout129);

%% perform the statistical test using randomization and a clustering approach
% THETA
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

cfg.latency          = [0 0.800]; % in seconds
cfg.frequency        = [4 7]; %theta
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables
%% WORDS

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save CDT_camp_Words_ind_theta_stat.mat stat
clear stat

%% perform the statistical test using randomization and a clustering approach
% ALPHA
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

cfg.latency          = [0 0.800]; % in seconds
cfg.frequency        = [8 12]; %alpha
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables
%% WORDS

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save CDT_camp_Words_ind_alf_stat.mat stat
clear stat

%% perform the statistical test using randomization and a clustering approach
% BETA
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

cfg.latency          = [0 0.800]; % in seconds
cfg.frequency        = [13 20]; %beta
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables
%% WORDS

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save CDT_camp_Words_ind_beta_stat.mat stat
clear stat

%% perform the statistical test using randomization and a clustering approach
% gamma
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

cfg.latency          = [0 0.800]; % in seconds
cfg.frequency        = [21 55]; %gamma
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
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables
%% WORDS

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save CDT_camp_Words_ind_gam_stat.mat stat
clear stat
