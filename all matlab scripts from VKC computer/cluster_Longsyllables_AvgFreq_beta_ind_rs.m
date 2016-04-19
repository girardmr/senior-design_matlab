%cluster analysis for syllables - INDUCED - batch for beta and logamma,
% I also changed the latency band (now -100 to +300)
% this version DOES average over freq band!!
%   took ? minutes to complete
%modified by rlg feb 10 2011

clear all; clc

%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20'; 

bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';
bin{4}='Weak_Weak';

% these files contain all subjects in one structure
for b=1:length(bin)
    
    filename = cat(2,bin{b}, '_L_allSubj_mblc_ind_rs.mat'); % new analyses with longer syll epochs
    load(filename);
    data{b}=TFallSubj_ind;
    clear TFallSubj_ind
    
end

%Read in the electrode locations for the my montage
cfg = [];
elec=read_sens('sopro_new_montage.sfp');

%% BETA BAND

cfg = [];
cfg.channel          = elec.label(1:52); %take all electrodes in new montage except Cz!
nsubj                = length(S);
cfg.neighbourdist    = 25;
cfg.elec             = elec;
cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
cfg.minnbchan        = 1;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0;
cfg.tail             = 0;
cfg.numrandomization = 2500; 
cfg.latency          = [-0.100 0.300]; % in seconds?? try small band first...
cfg.frequency        = [13 29];
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
cfg.ivar = 2;   %
% 
%% SS reg vs. WS reg (to show effect of alignment?/attending to strong syllables with the help of beats)
[stat]    = ft_freqstatistics(cfg, data{1}, data{2}); 
stat.cond1 = bin{1}
stat.cond2 = bin{2}

save SSregvsWSreg_L_stat_beta_ind_rs.mat stat
clear stat
% %% SS reg vs. SW reg 
% [stat]    = ft_freqstatistics(cfg, data{1}, data{3}); 
% 
% save SSregvsSWreg_L_stat_beta_ind_rs.mat stat
% clear stat
% 
% %% SW reg vs. WW reg
% [stat]    = ft_freqstatistics(cfg, data{3}, data{4}); 
% 
% save SWregvsWWreg_L_stat_beta_ind_rs.mat stat
% clear stat
% 
% %% SW reg vs. WS reg
% [stat]    = ft_freqstatistics(cfg, data{3}, data{2}); 
% 
% save SWregvsWSreg_L_stat_beta_ind_rs.mat stat
% clear stat
% 
% 
% %% LOW GAMMA BAND
% 
% cfg = [];
% cfg.channel          = elec.label(1:52); %take all electrodes in new montage except Cz!
% nsubj                = length(S);
% cfg.neighbourdist    = 25;
% cfg.elec             = elec;
% cfg.statistic        = 'depsamplesT'; %because within-subject design, but if using more than two conditions, must use F-statistic
% cfg.minnbchan        = 1;
% cfg.clusteralpha     = 0.05;
% cfg.alpha            = 0.025;
% cfg.clustertail      = 0;
% cfg.tail             = 0;
% cfg.numrandomization = 2500; 
% cfg.latency          = [-0.100 0.300]; % in seconds?? try small band first...
% cfg.frequency        = [30 50];
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
% design      = [designsubj designsubj; designcond1 designcond2];
% cfg.design  = design;
% cfg.uvar = 1;   % "subject" is unit of observation
% cfg.ivar = 2;   %
% 
% %% SS reg vs. WS reg (to show effect of alignment?/attending to strong syllables with the help of beats)
% [stat]    = ft_freqstatistics(cfg, data{1}, data{2}); 
% 
% save SSregvsWSreg_L_stat_logam_ind_rs.mat stat
% clear stat
% %% SS reg vs. SW reg 
% [stat]    = ft_freqstatistics(cfg, data{1}, data{3}); 
% 
% save SSregvsSWreg_L_stat_logam_ind_rs.mat stat
% clear stat
% 
% %% SW reg vs. WW reg
% [stat]    = ft_freqstatistics(cfg, data{3}, data{4}); 
% 
% save SWregvsWWreg_L_stat_logam_ind_rs.mat stat
% clear stat
% 
% %% SW reg vs. WS reg
% [stat]    = ft_freqstatistics(cfg, data{3}, data{2}); 
% 
% save SWregvsWSreg_L_stat_logam_ind_rs.mat stat
% clear stat
% 
% 
% 
% 
% 
% 
% 
