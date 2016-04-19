% clustering results - ERPs
load tut_layout.mat

%% happy music vs neutson
load MAPcamp_1vs3_ERP_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Negative cluster: 1, pvalue: 0.043667 (x), t = 0.092 to 0.152
cfg = [];
cfg.layout = EGI_layout129;
cfg.alpha =0.05;

ft_clusterplot(cfg,stat)
stat.cond1
stat.cond2


%% sad music vs neutson
load MAPcamp_2vs3_ERP_stat.mat
cfg = [];
cfg.layout = EGI_layout129;
cfg.alpha =0.05;

ft_clusterplot(cfg,stat)
stat.cond1
stat.cond2
% Positive cluster: 1, pvalue: 0.028667 (x), t = 0.104 to 0.168
% Negative cluster: 1, pvalue: 0.016333 (x), t = 0.088 to 0.16

clear stat

