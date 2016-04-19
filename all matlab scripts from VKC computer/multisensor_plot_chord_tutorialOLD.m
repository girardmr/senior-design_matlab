clear all; clc

%DO BIN NAMES AT BEGINNING, LOAD ALL DATA STRUCTURES UP FIRST...
load EGI_layout129.lay.mat
elec= ft_read_sens('GSN128_positions_4clustering.sfp');


novel = load('novl_chords_gravg_avblc_ind.mat');
standard = load('stnd_chords_gravg_avblc_ind.mat');
target = load('trgt_chords_gravg_avblc_ind.mat');

cfg.layout = EGI_layout129
cfg.channel = elec;
help ft_multiplotTFR
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600]
cfg.zlim = [-1 1]
cfg.ylim = [4 14]

figure(1)
ft_multiplotTFR(cfg,standard.TFgravg_ind)

title('standard - induced')

figure(2)
ft_multiplotTFR(cfg,target.TFgravg_ind)
title('target - induced')

figure(3)
ft_multiplotTFR(cfg,novel.TFgravg_ind)
title('novel - induced')


%%
clear all; clc


load EGI_layout129.lay.mat
cfg.layout = EGI_layout129
elec= ft_read_sens('GSN128_positions_4clustering.sfp');

standard = load('stnd_chords_gravg_avblc_evo.mat');
target = load('trgt_chords_gravg_avblc_evo.mat');
novel = load('novl_chords_gravg_avblc_evo.mat');
cfg.channel = elec;

cfg.layout = EGI_layout129
help ft_multiplotTFR
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600]
cfg.zlim = [-2 3]
cfg.ylim = [4 14]

figure(4)
ft_multiplotTFR(cfg,standard.TFgravg_evo)

title('standard - evoked')

figure(5)
ft_multiplotTFR(cfg,target.TFgravg_evo)
title('target - evoked')


figure(6)
ft_multiplotTFR(cfg,novel.TFgravg_evo)
title('novel - evoked')
% ERPs
%%
clearvars -except EGI_layout129

standard = load(cat(2,'chords_ERP_stnd_gravg.mat'));

target = load(cat(2,'chords_ERP_trgt_gravg.mat'));

novel = load(cat(2,'chords_ERP_novl_gravg.mat'));


cfg = [];
%cfg.channel= SigChan; %just the significant ones in the cluster!

cfg.baselinetype = 'no'; %baseline is already in data, % change from metronome beats
cfg.zparam        = 'avg';
%cfg.ylim         = freqband; %alpha
cfg.xlim         = [-0.100 0.700];%time I CAN'T SEE THE COLORBAR!??
%cfg.colorbar = 'EastOutside';
cfg.layout = EGI_layout129
%cfg.ylim = [-2 2]; % uses same maxmin from topoplot
cfg.interactive = 'yes'
cfg.showlabels    = 'yes'
figure

ft_multiplotER(cfg,standard.ERPgravg,target.ERPgravg,novel.ERPgravg);


