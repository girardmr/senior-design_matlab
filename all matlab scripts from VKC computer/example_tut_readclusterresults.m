% read clustering results

cfg.alpha = 0.055

load EGI_layout129.lay.mat
cfg.layout       = EGI_layout129;  %;
ft_clusterplot(cfg,stat)

