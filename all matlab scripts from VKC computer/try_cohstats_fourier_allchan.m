%% works on all channels! but didn't find anything significant in MECP2 data
% Sept 1, 2011


clear all; clc

%% define subjects % MECp2 boys
S{1}='07'; S{2}='08'; S{3}='09'; S{4}='10'; S{5}='11'; S{6}='14'; S{7}='16';
S{8}='17'; S{9}='18'; S{10}='19'; S{11}='20'; S{12}='21';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='FamVoice';
bin{2}='UnfamVoiceParent';
bin{3}='UnfamVoiceConstant';


load tut_layout.mat


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'voices',suj,'_',bin{b},'_fft_coh.mat')
        load(filename)
        data.(bin{b}){m} = FFTcoh;
%         data.(bin{b}){m}.dimord = FFTcoh.dimord;
%         data.(bin{b}){m}.wpli_debiasedspctrm = FFTcoh.wpli_debiasedspctrm;
%         data.(bin{b}){m}.freq = FFTcoh.freq;
%         data.(bin{b}){m}.cfg = FFTcoh.cfg;
% 
%         label = FFTcoh.labelcmb(:,1); % just first column
%         data.(bin{b}){m}.label = label;
        
        clear FFTcoh %label
    end
end


%%
nsubj=length(S);
%elec= ft_read_sens('GSN128_positions_4clustering.sfp');

cfg = [];
cfg.neighbourdist    = 10;
cfg.layout           = EGI_layout129;
cfg.method        = 'distance'

neighbours = ft_neighbourselection(cfg,EGI_layout129);

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
cfg.numrandomization = 500; %should be 2500
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
cfg.clustercritval = [-2.2010 2.2010];


stat = ft_freqstatistics(cfg,data.(bin{1}){:},data.(bin{3}){:});

save try_cohstats_bin1vs3_alf.mat stat


%% beta
cfg = [];
cfg.design  = design;
%cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'

cfg.statistic        = 'depsamplesT'; %?
%cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 500; %should be 2500
cfg.frequency        = [13 30]; %beta
%cfg.avgovertime      = 'no'; 
cfg.avgoverfreq      = 'no';
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')


stat = ft_freqstatistics(cfg,data.(bin{1}){:},data.(bin{3}){:});

save try_cohstats_bin1vs3_beta.mat stat


%% gamma
cfg = [];
cfg.design  = design;
cfg.uvar = 1;   % "subject" is unit of observation
cfg.ivar = 2;   % ind variables
cfg.neighbours       = neighbours;
cfg.parameter   = 'wpli_debiasedspctrm'
cfg.statistic        = 'depsamplesT'; %?
%cfg.minnbchan        = 2;
cfg.clusteralpha     = 0.05;
cfg.alpha            = 0.025;
cfg.clustertail      = 0; %has to be 1 if Ftest
cfg.tail             = 0; %has to be 1 if Ftest
cfg.numrandomization = 500; %should be 2500
cfg.frequency        = [31 50]; %gamma
%cfg.avgovertime      = 'no'; 
cfg.avgoverfreq      = 'no';
cfg.avgoverchan      = 'no';

cfg.correctm         = 'cluster';
cfg.method           = 'montecarlo';
cfg.feedback         = 'gui';

cfg.computestat    = 'yes'; %'yes' or 'no', calculate the statistic (default='yes')
cfg.computecritval = 'yes'; %'yes' or 'no', calculate the critical values of the test statistics (default='no')
cfg.computeprob    = 'yes';%'yes' or 'no', calculate the p-values (default='no')


stat = ft_freqstatistics(cfg,data.(bin{1}){:},data.(bin{3}){:});

save try_cohstats_bin1vs3_gam.mat stat

