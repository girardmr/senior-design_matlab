clear all; clc
% not really sure what configuration options to use on freqstatistics here.
% 

%% define subjects
S{1}='01_pre'; S{2}='02_pre'; S{3}='03_pre'; S{4}='04_pre'; S{5}='05_pre';
S{6}='06_pre'; S{7}='07_pre'; S{8}='08_pre'; S{9}='09_pre'; %S{10}='10_pre'; no 10 for post


for m=1:length(S) %for each subject
    suj=S{m};
    
    load(cat(2,'CP',suj,'vspost_snd_fft_coh_Z.mat'))
    %data.PrevsPost{m} = cohdif;
    
    %hack labelcmb out, get rid of second column with Fz
    
    data.PrevsPost{m}.dimord = cohdif.dimord;
    data.PrevsPost{m}.wpli_debiasedspctrm = cohdif.wpli_debiasedspctrm;
    data.PrevsPost{m}.freq = cohdif.freq;
    data.PrevsPost{m}.cfg = cohdif.cfg;
    label = cohdif.labelcmb(:,1); % just first column
    data.PrevsPost{m}.label = label;
    clear cohdif filename
    
    load(cat(2,'CP',suj(1:end-4),'_dummy_snd_fft_coh_Z.mat'));
    data.Dummydata{m}.dimord = cohdummy.dimord;
    data.Dummydata{m}.wpli_debiasedspctrm = cohdummy.wpli_debiasedspctrm;
    data.Dummydata{m}.freq = cohdummy.freq;
    data.Dummydata{m}.cfg = cohdummy.cfg;
    label = cohdummy.labelcmb(:,1); % just first column
    data.Dummydata{m}.label = label;
    
    %data.Dummydata{m} = cohdummy
    clear cohdummy
    
end


nsubj=length(S);
%%
%elec= ft_read_sens('GSN128_positions_4clustering.sfp');
load tut_layout.mat

cfg = [];
cfg.neighbourdist    = 10;
cfg.layout           = EGI_layout129;
cfg.method        = 'distance'

neighbours = ft_neighbourselection(cfg,EGI_layout129); % redo these for just 8 channel pairs?

designsubj  = 1:1:nsubj;
designcond1 = repmat(1,1,nsubj);
designcond2 = repmat(2,1,nsubj);
design      = [designsubj designsubj; designcond1 designcond2];

%% alpha
cfg = [];
cfg.design  = design;
%cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
cfg.layout           = EGI_layout129;

%cfg.channel          = elec.label; %
%nsubj=length(S);
%cfg.elec             = EGI_layout129.label;
cfg.statistic = 'diff' %??
%cfg.statistic        = 'depsamplesT'; %?
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05; %?
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %?
cfg.tail             = 0; %
cfg.numrandomization = 2500; %?
%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [8 12]; %alpha
%cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'no';
% cfg.avgoverchan      = 'no';
%
%cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')

%cfg.clustercritval
stat = ft_freqstatistics(cfg,data.PrevsPost{:},data.Dummydata{:});

save CP_cohstats_PrevsPost_alf.mat stat
clear stat

%% beta
cfg = [];
cfg.design  = design;
%cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
cfg.layout           = EGI_layout129;

%cfg.channel          = elec.label; %
%nsubj=length(S);
%cfg.elec             = EGI_layout129.label;
cfg.statistic = 'diff' %??
%cfg.statistic        = 'depsamplesT'; %?
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05; %?
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %don't use
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 2500; %?
%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [13 25]; %beta
%cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'no';
% cfg.avgoverchan      = 'no';
%
%cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')


stat = ft_freqstatistics(cfg,data.PrevsPost{:},data.Dummydata{:});

save CP_cohstats_PrevsPost_beta.mat stat
clear stat

%% gamma
cfg = [];
cfg.design  = design;
%cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
cfg.layout           = EGI_layout129;

%cfg.channel          = elec.label; %
%nsubj=length(S);
%cfg.elec             = EGI_layout129.label;
cfg.statistic = 'diff' %??
%cfg.statistic        = 'depsamplesT'; %?
cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05; %?
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %don't use
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 2500; %?
%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [26 54]; %gamma
%cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'no';
% cfg.avgoverchan      = 'no';
%
%cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')


stat = ft_freqstatistics(cfg,data.PrevsPost{:},data.Dummydata{:});

save CP_cohstats_PrevsPost_gam.mat stat
