load EGI_129_newmask.lay.mat

load novl_chords_gravg_avblc_ind.mat

cfg.layout = EGI_129_newmask
help ft_multiplotTFR
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600]
cfg.zlim = [-1 2]

ft_multiplotTFR(cfg,TFRwave_ind)