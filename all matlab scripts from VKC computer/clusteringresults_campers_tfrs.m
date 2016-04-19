% clustering results - TFRs
load tut_layout.mat

%% MUSIC
load MAPcamp_1vs2_evo_alf_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.026667 (x), t = 0 to 0.452
cfg = [];
cfg.layout = EGI_layout129;
cfg.alpha =0.05;

ft_clusterplot(cfg,stat)
% stat.cond1
% stat.cond2
%%
load MAPcamp_1vs2_ind_alf_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.044 (x), t = 0 to 0.396
ft_clusterplot(cfg,stat)

%% 
load MAPcamp_1vs2_ind_beta_stat.mat
% Negative cluster: 1, pvalue: 0.048 (x), t = 0.252 to 0.556


%%
load MAPcamp_1vs2_ind_gam_stat.mat

cfg = []; cfg.layout = EGI_layout129; cfg.alpha =0.05;
ft_clusterplot(cfg,stat)
%  
% There are 1 clusters smaller than alpha (0.05)
% Negative cluster: 1, pvalue: 0.076 (+), t = 0.468 to 0.584

%%
load MAPcamp_1vs3_evo_alf_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.004 (*), t = 0 to 0.236

%% 
load MAPcamp_1vs3_evo_beta_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.001 (*), t = 0 to 0.208

%% 
load MAPcamp_1vs3_ind_alf_stat.mat
% There are 2 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.026333 (x), t = 0.42 to 0.6
% Positive cluster: 2, pvalue: 0.059 (+), t = 0 to 0.2

%% 
load MAPcamp_2vs3_ind_alf_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Negative cluster: 1, pvalue: 0.024333 (x), t = 0.192 to 0.42

%%1
load MAPcamp_2vs3_ind_beta_stat.mat
% Positive cluster: 1, pvalue: 0.04 (x), t = 0.264 to 0.6
% There are 1 clusters smaller than alpha (0.05)

%% FACES
load MAPcamp_4vs5_evo_beta_stat.mat

% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.020667 (x), t = 0.176 to 0.368


%% MAIN RESULT %%%%%%%%%%%%%
load MAPcamp_4vs5_evo_gam_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.001 (*), t = 0.144 to 0.516
% latency range got wider!!

%%
load MAPcamp_4vs6_evo_gam_stat.mat
% There are 1 clusters smaller than alpha (0.05)
% Positive cluster: 1, pvalue: 0.012333 (x), t = 0.22 to 0.372

%%
load MAPcamp_4vs5_ind_beta_stat.mat
% Positive cluster: 1, pvalue: 0.028 (x), t = 0 to 0.332


%%
load MAPcamp_5vs6_evo_gam_stat.mat
% Negative cluster: 1, pvalue: 0.052 (+), t = 0.292 to 0.512






