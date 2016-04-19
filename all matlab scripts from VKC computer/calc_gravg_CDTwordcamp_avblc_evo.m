% load in baseline-corrected TFR (new) on CDT campers
% keep individual subjects
% save files 
% mod. 13 dec 2011 by rlg
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';


%%

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}=  cat(2,suj,'_CDT_',bin{b},'_tfr_avblc_evo.mat');
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

load tut_layout.mat % this layout excludes EOG channels

cfg = [];
cfg.keepindividual = 'no'; %
cfg.layout       = EGI_layout129; 

% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure     

  
for b=1:length(bin)
    
    gravg.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,'CDT_campers_',bin{b}, '_gravg_avblc_evo.mat');
    TFgravg_evo =  gravg.(bin{b});
    save(outfile, 'TFgravg_evo');
    
    clear outfile TFgravg_evo
    
end



