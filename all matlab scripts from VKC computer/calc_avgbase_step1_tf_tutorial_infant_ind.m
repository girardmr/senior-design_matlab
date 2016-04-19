%%compute average across conditions to use as baseline in new target
% tutorial 
% rlg 30 september 2010

clear all; clc
%% define subjects and conditions% CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='01';  
%S{2}='02';

bin{1}='neutral';
bin{2}='small_smile';
bin{3}='big_smile';

%% calculate average power for targets
for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'Tutorial',suj,'_',bin{b},'_tfr_ind.mat') 
        data.(bin{b})=load(filename);
        clear filename
    end
    
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S; 
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_ind=ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_ind, data.(bin{2}).TFRwave_ind, data.(bin{3}).TFRwave_ind);
    outfile= cat(2,'Tutorial',suj,'_avgbins_tfr_ind.mat')
    save(outfile,'TFRwave_ind');
    clear TFRwave_ind data outfile
end




