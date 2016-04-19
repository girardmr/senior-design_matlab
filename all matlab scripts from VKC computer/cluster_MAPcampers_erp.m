%cluster ERP data on WS data
% mod. by Reyna 22 feb 2011
clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}= 'HapMus';
bin{2}= 'SadMus';
bin{3}= 'NeutSon';
bin{4}= 'mus_Match_face'; %
bin{5}= 'mus_Mismatch_face'; %
bin{6}= 'neutson_bothface'; %

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,'MAP_campers_',bin{b},'_allSubj_ERP.mat'); 
    load(filename);
    data{b}= ERPallSubj;
    clear ERPallSubj
    
end

%Read in the electrode locations for the my montage
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');


%% perform the statistical test using randomization and a clustering approach
% ERP
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
save MAPcamp_1vs2_ERP_stat.mat stat
stat.cond1 = bin{1};
stat.cond2 = bin{2};
clear stat
%%
[stat]    = ft_timelockstatistics(cfg, data{2}, data{3}); 
stat.cond1 = bin{2};
stat.cond2 = bin{3};%
save MAPcamp_2vs3_ERP_stat.mat stat
clear stat

%%
[stat]    = ft_timelockstatistics(cfg, data{1}, data{3});
stat.cond1 = bin{1};
stat.cond2 = bin{3};%
save MAPcamp_1vs3_ERP_stat.mat stat
clear stat

%% FACES
[stat]    = ft_timelockstatistics(cfg, data{4}, data{5}); %
save MAPcamp_4vs5_ERP_stat.mat stat
stat.cond1 = bin{4};
stat.cond2 = bin{5};
clear stat
%%
[stat]    = ft_timelockstatistics(cfg, data{5}, data{6}); 
stat.cond1 = bin{5};
stat.cond2 = bin{6};%
save MAPcamp_5vs6_ERP_stat.mat stat
clear stat

%%
[stat]    = ft_timelockstatistics(cfg, data{4}, data{6});
stat.cond1 = bin{4};
stat.cond2 = bin{6};%
save MAPcamp_4vs6_ERP_stat.mat stat
clear stat

