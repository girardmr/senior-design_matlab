% clustering results - ERPs
load tut_layout.mat

%% FACES



cfg = [];
cfg.layout = EGI_layout129;
cfg.alpha =0.07;

%% NEW
load MAPctrl_4vs6_ind_alf_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.0023333 (*), t = 0 to 0.36

ft_clusterplot(cfg,stat)
%% NEW (marginal)
load MAPctrl_5vs6_ind_alf_stat.mat
%Positive cluster: 1, pvalue: 0.059667 (+), t = 0 to 0.372


%% NEW
load MAPctrl_5vs6_ind_gam_stat.mat
% Negative cluster: 1, pvalue: 0.017 (x), t = 0.416 to 0.588

%% MUSIC
% NEW
load MAPctrl_1vs3_ind_gam_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Negative cluster: 1, pvalue: 0.035333 (x), t = 0.124 to 0.276

ft_clusterplot(cfg,stat)

%% NEW
load MAPctrl_1vs3_evo_alf_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.019667 (x), t = 0.004 to 0.288

ft_clusterplot(cfg,stat)

%% NEW
load MAPctrl_2vs3_evo_beta_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.021 (x), t = 0.052 to 0.244

ft_clusterplot(cfg,stat)

%% NEW
load MAPctrl_1vs2_evo_beta_stat.mat
%Negative cluster: 1, pvalue: 0.038333 (x), t = 0.352 to 0.6

%% NEW
load MAPctrl_1vs3_evo_beta_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.049333 (x), t = 0.036 to 0.196

ft_clusterplot(cfg,stat)

%% NEW (marginal)
load MAPctrl_2vs3_evo_gam_stat.mat
% There are 1 clusters smaller than alpha (0.06)
% Positive cluster: 1, pvalue: 0.056 (+), t = 0.088 to 0.188







