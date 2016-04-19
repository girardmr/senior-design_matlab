% try ztransform (but not subtraction - so not using cfg.method = 'diff'
clear all; clc
% not really sure what configuration options to use on freqstatistics here.
%

%% define subjects
Spre{1}='01_pre'; Spre{2}='02_pre'; Spre{3}='03_pre'; Spre{4}='04_pre'; Spre{5}='05_pre';
Spre{6}='06_pre'; Spre{7}='07_pre'; Spre{8}='08_pre'; Spre{9}='09_pre'; %Spre{10}='10_pre'; 10 didnt' do post

Spost{1}='01_post'; Spost{2}='02_post'; Spost{3}='03_post'; Spost{4}='04_post'; Spost{5}='05_post';
Spost{6}='06_post'; Spost{7}='07_post'; Spost{8}='08_post';  Spost{9}='09_post';

for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    
    load(cat(2,'CP',sujPre,'_snd_fft_coh_all_Z.mat'))
    data.Pre{m} = FFTcoh;
    
    %hack labelcmb out, get rid of second column with Fz
    
    %     data.PrevsPost{m}.dimord = cohdif.dimord;
    %     data.PrevsPost{m}.wpli_debiasedspctrm = cohdif.wpli_debiasedspctrm;
    %     data.PrevsPost{m}.freq = cohdif.freq;
    %     data.PrevsPost{m}.cfg = cohdif.cfg;
    %     label = cohdif.labelcmb(:,1); % just first column
    %     data.PrevsPost{m}.label = label;
    clear FFTcoh
    
    
    sujPost = Spost{m};
    load(cat(2,'CP',sujPost,'_snd_fft_coh_all_Z.mat'));
    %     data.Dummydata{m}.dimord = cohdummy.dimord;
    %     data.Dummydata{m}.wpli_debiasedspctrm = cohdummy.wpli_debiasedspctrm;
    %     data.Dummydata{m}.freq = cohdummy.freq;
    %     data.Dummydata{m}.cfg = cohdummy.cfg;
    %     label = cohdummy.labelcmb(:,1); % just first column
    %     data.Dummydata{m}.label = label;
    %
    data.Post{m} = FFTcoh;
    clear FFTcoh
    
end


nsubj=length(Spre);
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
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
%cfg.channel          = elec.label; %
%nsubj=length(S);
%cfg.elec             = EGI_layout129.label;
cfg.statistic = 'depsamplesT' %no, this only works for a single-subject study
%cfg.statistic        = 'depsamplesT'; %?
%cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 2500; %should be 2500
%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [8 12]; %alpha
%cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'yes';
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')
%cfg.clustercritval = [-2.2010 2.2010];
%cfg.clustercritval
stat = ft_freqstatistics(cfg,data.Pre{:},data.Post{:});

save CP_cohstats_ZPrevsPost_alf_allchan.mat stat
clear stat


%% beta
cfg = [];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
%cfg.channel          = elec.label; %
%nsubj=length(S);
%cfg.elec             = EGI_layout129.label;
cfg.statistic = 'depsamplesT' %no, this only works for a single-subject study
%cfg.statistic        = 'depsamplesT'; %?
%cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 2500; %should be 2500
%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [13 25]; %beta
%cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'yes';
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')

stat = ft_freqstatistics(cfg,data.Pre{:},data.Post{:});

save CP_cohstats_ZPrevsPost_beta_allchan.mat stat
clear stat


%% gamma
cfg = [];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
%cfg.channel          = elec.label; %
%nsubj=length(S);
%cfg.elec             = EGI_layout129.label;
cfg.statistic = 'depsamplesT' %no, this only works for a single-subject study
%cfg.statistic        = 'depsamplesT'; %?
%cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 2500; %should be 2500
%cfg.latency          = [0 0.600]; % in seconds
cfg.frequency        = [26 54]; % gamma
%cfg.avgovertime      = 'no';
cfg.avgoverfreq      = 'yes';
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')

stat = ft_freqstatistics(cfg,data.Pre{:},data.Post{:});

save CP_cohstats_ZPrevsPost_gam_allchan.mat stat
clear stat
