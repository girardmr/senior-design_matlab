% load in baseline-corrected TFR INDuced (new) on MAP controls
% keep individual subjects
% save files 
% mod. 20 dec 2011 by rlg
clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='Matchdifwave';

%%

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}=  cat(2,suj,'_MAP_',bin{b},'_avblc_ind.mat');
    end
    
end

%nsubj = length(S);

for m=1:length(S)
    
    for b=1:length(bin)
        
        data.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        TFdata.(bin{b}){m} = data.(bin{b}){m}.TFRwave_ind; % take only what we need (TFdata)
        
    end
end
clear data

load tut_layout.mat % this layout excludes EOG channels

cfg = [];
cfg.keepindividual = 'yes'; %
cfg.layout       = EGI_layout129; 

% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure     

  
for b=1:length(bin)
    
    allSubj.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,'MAP_campers_',bin{b}, '_allSubj_avblc_ind.mat');
    TFallSubj_ind =  allSubj.(bin{b});
    save(outfile, 'TFallSubj_ind');
    
    clear outfile TFallSubj_ind
    
end



