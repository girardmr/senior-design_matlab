%cluster evoked data on WS data
% mod. by Reyna 22 feb 2011


clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE

% group #1: campers
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';

% group # 2: controls
Sc{1}='w6c002';  Sc{2}='w6c003'; Sc{3}='w6c004'; Sc{4}='w6c007';  Sc{5}='w6c009'; Sc{6}='w6c010';
Sc{7}='w6c011';  Sc{8}='w6c012'; Sc{9}='w6c013'; Sc{10}='w6c014'; Sc{11} = 'w6c015';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='Matchdifwave';

for b=1:length(bin)
    %
    load(cat(2,'MAP_campers_',bin{b}, '_allSubj_avblc_evo.mat'));
    campers = TFallSubj_evo; 
    clear TFallSubj_evo
    load(cat(2,'MAP_controls_',bin{b}, '_allSubj_avblc_evo.mat'));
    controls = TFallSubj_evo;
    
    clear TFallSubj_evo
end

%     load(filename);
%     data{b}=TFallSubj_evo;
%     clear TFallSubj_evo
%     
% end

% % these files contain all subjects in one structure
% for b=1:length(bin)
%     
%     filename = cat(2,'MAP_controls_',bin{b}, '_allSubj_avblc_evo.mat');
%     load(filename);
%     data{b}=TFallSubj_evo;
%     clear TFallSubj_evo
%     
% end


%Read in the electrode locations for the my montage
cfg = [];
elec= ft_read_sens('GSN128_positions_4clustering.sfp');


%% perform the statistical test using randomization and a clustering approach
% ALPHA
cfg = [];
cfg.channel          = elec.label; %

cfg.neighbourdist    = 10;
cfg.elec             = elec;
cfg.statistic        = 'indepsamplesT'; %because between-subject design
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
nsubjgroup1 = length(S);
nsubjgroup2 = length(Sc);
totalnsubj = nsubjgroup1 + nsubjgroup2;
subjrow = 1:1:totalnsubj;

%designsubj  = 1:1:nsubj;
designgroup1 = repmat(1,1,nsubjgroup1);
designgroup2 = repmat(2,1,nsubjgroup2);

design      = [subjrow; designgroup1 designgroup2];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   
%% Face match (vs mismatch) difwave

[stat]    = ft_freqstatistics(cfg, campers, controls); %
% stat.cond1 = campers;
% stat.cond2 = controls;
% save MAP_campvsctrl_Matchdif_evo_gamma_stat.mat stat
% clear stat
