% load ERP difference scores all subj file
%% NOT RIGHT FILE, just trying procedure
load MAP_campers_HapMus_allSubj_ERP.mat

S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';

cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');
%% perform the statistical test using randomization and a clustering approach
% ERP
cfg = [];
cfg.channel          = elec.label; %take all electrodes in new montage except Cz!
nsubj=length(S);
cfg.neighbourdist    = 10;
cfg.elec             = elec;
cfg.statistic = 'behcorr'; %% need to figure out statfun file...
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.05;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 3000; %should be 2500
cfg.latency          = [0.050 0.250];
cfg.avgovertime      = 'no';
cfg.avgoverchan      = 'no';
cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';
cfg.design = beh_aud_sensitivity(1:13)';

cfg.ivar = 1;



[stat]    = ft_timelockstatistics(cfg, ERPallSubj);

% ??? Error using ==> statistics_montecarlo at 218
% could not determine the parametric critical value for clustering
