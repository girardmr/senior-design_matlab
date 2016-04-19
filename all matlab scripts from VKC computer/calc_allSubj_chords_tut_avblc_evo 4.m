% load in baseline-corrected TFR EVOKED (new) on chords
% keep individual subjects
% save files 
% mod. oct 14 2010 by rlg

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';

%%

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'chords_tut_subj',suj,'_',bin{b},'_tfr_avblc_evo.mat') 
    end
    
end

%nsubj = length(S);

for m=1:length(S)
    
    for b=1:length(bin)
        
        data.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        TFdata.(bin{b}){m} = data.(bin{b}){m}.TFRwave_evo; % take only what we need (TFdata)
        
    end
end
clear data

load EGI_layout129.lay.mat

% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure
cfg = [];
cfg.keepindividual = 'yes'; %put yes to save averages for each subject in file
cfg.layout       = EGI_layout129;  %;     

  
for b=1:length(bin)
    
    allSubj.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,bin{b}, '_chords_allSubj_avblc_evo.mat');
    TFallSubj_evo =  allSubj.(bin{b});
    save(outfile, 'TFallSubj_evo');
    
    clear outfile TFallSubj_evo
    
end



