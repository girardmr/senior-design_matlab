%cluster induced data on chords
% mod. by Reyna jan 17, 2010
% to do: use new input and output file functions
% save condition names into stat files too
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';


% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,bin{b}, '_chords_allSubj_avblc_ind.mat');
    load(filename);
    data{b}=TFallSubj_ind;
    clear TFallSubj_ind
    
end

%Read in the electrode locations for the my montage
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');


%% perform the statistical test using randomization and a clustering approach
% THETA
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbourdist    = 15;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 1;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 1000; %should be 2500

cfg.latency          = [0 0.600]; % in seconds
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
% 
[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
save Chords_1vs2_avblc_ind_the_stat.mat stat
clear stat
%%
[stat]    = ft_freqstatistics(cfg, data{2}, data{3}); %
save Chords_2vs3_avblc_ind_the_stat.mat stat
clear stat

%%
[stat]    = ft_freqstatistics(cfg, data{1}, data{3}); %
save Chords_1vs3_avblc_ind_the_stat.mat stat
clear stat

%% perform the statistical test using randomization and a clustering approach
% ALPHA
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbourdist    = 15;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 1;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 1000; %should be 2500

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

%design      = [designsubj designsubj designsubj designsubj; designcond1 designcond2 designcond3 designcond4; designcond5 designcond6 designcond7 designcond8];
design      = [designsubj designsubj; designcond1 designcond2];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   %2:3;   % "syllables and regularity are " the independent variables

[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); %
save Chords_1vs2_avblc_ind_alf_stat.mat stat
clear stat
%%
[stat]    = ft_freqstatistics(cfg, data{2}, data{3}); %
save Chords_2vs3_avblc_ind_alf_stat.mat stat
clear stat

%%
[stat]    = ft_freqstatistics(cfg, data{1}, data{3}); %
save Chords_1vs3_avblc_ind_alf_stat.mat stat
clear stat

%% perform the statistical test using randomization and a clustering approach
% BETA
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbourdist    = 15;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 1;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 1000; %should be 2500

cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [13 25];%BETA 
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
%     cfg.inputfile  = one can specifiy preanalysed saved data as input
%                       The data should be provided in a cell array
%     cfg.outputfile = one can specify output as file to save to disk

[stat]    = freqstatistics(cfg, data{1}, data{2}); %
save Chords_1vs2_avblc_ind_beta_stat.mat stat
clear stat
%
[stat]    = freqstatistics(cfg, data{2}, data{3}); %
save Chords_2vs3_avblc_ind_beta_stat.mat stat
clear stat

%
[stat]    = ft_freqstatistics(cfg, data{1}, data{3}); %
save Chords_1vs3_avblc_ind_beta_stat.mat stat
clear stat

