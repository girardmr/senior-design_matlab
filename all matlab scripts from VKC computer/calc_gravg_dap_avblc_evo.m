% load in baseline-corrected evoked on camper data
% calculate grand average by averaging together individual subjects and
% save
% mod. rlg 17 feb 2011

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='loud_tone';
bin{2}='omit_tone';


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}=  cat(2,suj,'_',bin{b},'_tfr_avblc_evo.mat');

    end
    
end

for m=1:length(S)
    
    for b=1:length(bin)
        
        data.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        TFdata.(bin{b}){m} = data.(bin{b}){m}.TFRwave_evo; % take only what we need (TFdata)
        
    end
end
clear data

%Read in the electrode location file for this montage

load tut_layout.mat % this layout excludes EOG channels

cfg = [];
cfg.keepindividual = 'no'; %we want a grand average, so don't save individual subjects
cfg.layout       = EGI_layout129; 
   
for b=1:length(bin)
    
    gravg.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,'dap123_',bin{b}, '_gravg_avblc_evo.mat');
    TFgravg_evo =  gravg.(bin{b});
    save(outfile, 'TFgravg_evo');
    
    clear outfile TFgravg_evo
    
end







