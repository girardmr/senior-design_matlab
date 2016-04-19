%CONTROLS
%EVOKED

load tut_layout.mat

% cfg = [];
cfg.alpha = 0.08;
cfg.layout = EGI_layout129;
cfg.parameter = 'stat'
ft_clusterplot(cfg,stat)

% evoked theta
load CDT_ctrl_Words_evo_theta_stat.mat
% nice fronto-central distribution
% Negative cluster: 1, pvalue: 0.074333 (+), t = 0 to 0.376

% evoked alpha - MODIFY THIS FOR NEW RESULTS WITH SAMP RATE AT 500!
load CDT_ctrl_Words_evo_alf_stat.mat
% mostly left frontal and central/slightly right posterior
%Positive cluster: 1, pvalue: 0.0830 (+), t = 0.204 to 0.458
% greater alpha for matching rhythm vs. mismatch

% beta and gamma N.S.

%% evoked alpha - campers

load CDT_camp_Words_evo_alf_stat.mat
% There are 2 clusters smaller than alpha (0.08)
% Positive cluster: 1, pvalue: 0.056667 (+), t = 0 to 0.264
% Positive cluster: 2, pvalue: 0.073333 (+), t = 0.376 to 0.76

% greater alpha for matching rhythm vs. mismatch - 2 clusters, diff
% latencies than for controls (earlier and later).

% induced beta - campers
%p = 0.0620