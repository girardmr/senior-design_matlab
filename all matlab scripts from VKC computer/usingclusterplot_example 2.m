% sample using ft_clusterplot for ERPs with >1 significant cluster

load EGI_layout129.lay.mat

cfg.layout = EGI_layout129;
cfg.alpha = 0.06; % use this alpha value to include the marginally significant cluster
ft_clusterplot(cfg,stat)

% different symbols denote different p-thresholds
% colorscale denotes?? tvalues at different time points??