% clustering results - ERPs
load tut_layout.mat

%% FACES



cfg = [];
cfg.layout = EGI_layout129;
cfg.alpha =0.06;

%%
load MAPctrl_4vs6_ind_alf_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.0073333 (*), t = 0 to 0.368
ft_clusterplot(cfg,stat)

load MAPctrl_4vs6_evo_alf_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.052 (+), t = 0.448 to 0.8


%% MUSIC

load MAPctrl_1vs3_ind_gam_stat.mat
% Negative cluster: 1, pvalue: 0.019667 (x), t = 0.18 to 0.272

ft_clusterplot(cfg,stat)

%%
load MAPctrl_1vs3_evo_alf_stat.mat
% Positive cluster: 1, pvalue: 0.0053333 (*), t = 0 to 0.3

ft_clusterplot(cfg,stat)

%%
load MAPctrl_2vs3_evo_beta_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.011333 (x), t = 0.072 to 0.232
ft_clusterplot(cfg,stat)

%% 
load MAPctrl_1vs3_evo_beta_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.036333 (x), t = 0.04 to 0.192

ft_clusterplot(cfg,stat)

%% 
load MAPctrl_2vs3_evo_gam_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.042333 (x), t = 0.1 to 0.224

%%
load MAPctrl_1vs3_evo_gam_stat.mat
% 
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.029667 (x), t = 0.044 to 0.2

%%





