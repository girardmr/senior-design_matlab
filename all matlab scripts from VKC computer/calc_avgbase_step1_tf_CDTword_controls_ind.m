%%compute average across conditions to use as baseline
% WS campers
% rlg 13 dec 2011

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';


for m=1:length(S) %for each subject
    suj=S{m};
    %load all the files for one subject
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_CDT_',bin{b},'_tfr_ind.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    %% calculate average power for words
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    cfg.toilim         = [-0.100 0.800];  %%  
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_ind = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_ind, data.(bin{2}).TFRwave_ind);
    outfile= cat(2,'CDT_',suj,'_avgWordbins_tfr_ind.mat')
    save(outfile,'TFRwave_ind');
    clear TFRwave_ind outfile
    
    
end




