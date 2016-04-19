%cluster induced data on WS data
% mod. by Reyna 22 feb 2011


clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE
S{1}='01';  S{2}='04'; S{3}='05'; S{4}='06';  S{5}='07'; S{6}='08'; S{7}='09'; S{8}='10'; S{9}='12'; S{10}='14'; S{11}='17'; S{12}='18'; S{13}='19'; S{14}='20';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='SameNear';
bin{2}='SameFar';

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,'MR_Visual_',bin{b},'_allSubj_fft.mat'); 
    load(filename);
    data{b}= FFTallSubj;
    clear FFTallSubj
    
end

%Read in the electrode locations for the my montage
cfg = [];
elec= ft_read_sens('GSNH65.sfp');

%neightbor selection
load hydro65.lay.mat
cfg = [];
cfg.neighbourdist    = 5; % was 10, try using fewer to eliminate those far channels 
cfg.layout           = hydro65lay;
cfg.method        = 'distance';
neighbours = ft_prepare_neighbours(cfg,hydro65lay); %I changed this to the newer function

elec2analyz=[elec.label(4:64,1);elec.label(67:68,1)]; %channel to perform cluster analysis on

% %% perform the statistical test using randomization and a clustering approach
% % ALPHA
% cfg = [];
% cfg.channel          = elec2analyz;
% nsubj=length(S);
% cfg.neighbours       = neighbours;
% %cfg.elec             = elec; I don't think you need this
% cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
% cfg.minnbchan        = 2;
% cfg.clusteralpha     = 0.05;
% cfg.alpha            = 0.025;
% cfg.clustertail      = 0; %has to be 1 if Ftest
% cfg.tail             = 0; %has to be 1 if Ftest
% cfg.numrandomization = 3000; %should be 2500
% 
% %cfg.latency          = [0 0.600]; % in seconds
% cfg.frequency        = [8 12]; %alpha
% cfg.avgovertime      = 'no'; 
% cfg.avgoverfreq      = 'no';
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
% save MR_Visual_FFT_NearvsFar_Alpha_Stat.mat stat
% clear stat
% 
% %% perform the statistical test using randomization and a clustering approach
% % BETA
% cfg = [];
% cfg.channel          = elec2analyz;
% nsubj=length(S);
% cfg.neighbours       = neighbours;
% %cfg.elec             = elec; I don't think you need this
% cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
% cfg.minnbchan        = 2;
% cfg.clusteralpha     = 0.05;
% cfg.alpha            = 0.025;
% cfg.clustertail      = 0; %has to be 1 if Ftest
% cfg.tail             = 0; %has to be 1 if Ftest
% cfg.numrandomization = 3000; %should be 2500
% 
% %cfg.latency          = [0 0.600]; % in seconds
% cfg.frequency        = [13 25]; %beta
% cfg.avgovertime      = 'no'; 
% cfg.avgoverfreq      = 'no';
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
% save MR_Visual_FFT_NearvsFar_Beta_Stat.mat stat
% clear stat

%% perform the statistical test using randomization and a clustering approach
% GAMMA
cfg = [];
cfg.channel          = elec2analyz;
nsubj=length(S);
cfg.neighbours       = neighbours;
%cfg.elec             = elec; I don't think you need this
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 3000; %should be 2500

%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [30 54]; %beta
cfg.avgovertime      = 'no'; 
cfg.avgoverfreq      = 'no';
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

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
stat.cond1 = bin{1};
stat.cond2 = bin{2};
save MR_Visual_FFT_NearvsFar_Gamma_Stat.mat stat
clear stat
