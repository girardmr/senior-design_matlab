%%compute average across conditions to use as baseline in new metro
%  
% rlg 30 september 2010

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1} = 'metrobeats';
bin{2} = 'offbeats';

%% calculate average power for targets
for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'suj',suj,'_',bin{b},'_tfr_ind.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S; 
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_ind = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_ind, data.(bin{2}).TFRwave_ind);
    outfile= cat(2,'metro_suj',suj,'_avgbins_tfr_ind.mat')
    save(outfile,'TFRwave_ind');
    clear TFRwave_ind data outfile
end




