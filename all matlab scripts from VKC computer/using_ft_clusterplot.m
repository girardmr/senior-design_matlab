load tut_layout.mat

load Chords_1vs3_ERP_stat.mat

cfg.layout = EGI_layout129;
cfg.alpha = 0.05;
cfg.parameter = 'stat';

ft_clusterplot(cfg,stat)
