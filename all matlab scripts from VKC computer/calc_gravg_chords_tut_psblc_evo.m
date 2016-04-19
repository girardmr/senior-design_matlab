% load in baseline-corrected TFR EVOKED (new) on chords tutorial
% average together individual subjects
% save files 
% mod. 14 october 2010

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';



%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'chords_tut_subj',suj,'_',bin{b},'_tfr_psblc_evo.mat') %new baseline correction - pre-stim period
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

%load sopro_ERP_channels.mat % this worked to select just the channels I want... leaves out Cz, occipitals, and mastoids!
load EGI_129_newmask.lay.mat


% recompute the average,
% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure
cfg = [];
cfg.keepindividual = 'no'; %put yes to save averages for each subject in file
%cfg.channel= sopro_ERP_channels;
cfg.layout       = EGI_129_newmask;  %'GSN-HydroCel-65 1.0.sfp';  

for b=1:length(bin)
    
    gravg.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,bin{b}, '_chords_gravg_psblc_evo.mat')
    TFgravg_evo =  gravg.(bin{b})
    save(outfile, 'TFgravg_evo')
    
    clear outfile TFgravg_evo
    
end


