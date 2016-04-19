load('/Users/reyna/Documents/cross-domain Metrics and Timbre/EEG Data/CDT_Matlab/old - 250Hz (new is upsampled)/CDTword_W7C012_WordRhyCong_trials_250.mat')

cfg = [];
cfg.resamplefs = 500;
cfg.detrend = 'no'
data_rs = ft_resampledata(cfg,data)

clear data
data = data_rs % rename

save CDTword_W7C012_WordRhyCong_trials.mat data

%% 
clear all

load('/Users/reyna/Documents/cross-domain Metrics and Timbre/EEG Data/CDT_Matlab/old - 250Hz (new is upsampled)/CDTword_W7C012_WordRhyIncong_trials_250.mat')

cfg = [];
cfg.resamplefs = 500;
cfg.detrend = 'no'
data_rs = ft_resampledata(cfg,data)

clear data
data = data_rs % rename

save CDTword_W7C012_WordRhyIncong_trials.mat data
