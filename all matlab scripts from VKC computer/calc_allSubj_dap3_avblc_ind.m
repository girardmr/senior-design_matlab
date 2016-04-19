% load in baseline-corrected TFR indKED 
% keep individual subjects
% save files 
% mod. 24 feb 2012 by rlg
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regular';
bin{2}='irregular';

%%

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_',bin{b},'_tfr_avblc_ind.mat');
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
    outfile     =  cat(2,'dap3_',bin{b}, '_allSubj_4s_avblc_ind.mat');
    TFallSubj_ind =  allSubj.(bin{b});
    save(outfile, 'TFallSubj_ind');
    
    clear outfile TFallSubj_ind
    
end



