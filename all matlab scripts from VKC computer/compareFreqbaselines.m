clear all; clc


load EGI_layout129.lay.mat
cfg.layout = EGI_layout129
elec= ft_read_sens('GSN128_positions_4clustering.sfp');

standard = load('stnd_chords_gravg_psblc_evo.mat');
target = load('trgt_chords_gravg_psblc_evo.mat');
novel = load('novl_chords_gravg_psblc_evo.mat');
cfg.channel = elec;

cfg.layout = EGI_layout129
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600]
cfg.zlim = [-1 50]
cfg.ylim = [4 14]

figure(4)
ft_multiplotTFR(cfg,standard.TFgravg_evo)

title('standard - evoked - psblc')

figure(5)
ft_multiplotTFR(cfg,target.TFgravg_evo)
title('target - evoked - psblc')


figure(6)
ft_multiplotTFR(cfg,novel.TFgravg_evo)
title('novel - evoked - psblc')
%%
clear all; clc
load EGI_layout129.lay.mat
cfg.layout = EGI_layout129;
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600]
%cfg.zlim = [-1 50]
cfg.ylim = [4 14]


ExNovelAbs = load('chords_tut_subj11_stnd_tfr_evo.mat')

ExNovelPSblc = load('chords_tut_subj11_stnd_tfr_psblc_evo.mat')

ExNovelAvBlc = load('chords_tut_subj11_stnd_tfr_avblc_evo.mat')


figure
cfg.zlim = [-1 50]

ft_multiplotTFR(cfg,ExNovelAbs.TFRwave_evo)

title('suj11 - evoked - raw')

figure
cfg.zlim = [-1 50]
ft_multiplotTFR(cfg,ExNovelPSblc.TFRwave_evo)
title('suj11 - evoked - psblc')


figure
cfg.zlim = [-1 5]

ft_multiplotTFR(cfg,ExNovelAvBlc.TFRwave_evo)
title('suj11 - evoked - avblc')