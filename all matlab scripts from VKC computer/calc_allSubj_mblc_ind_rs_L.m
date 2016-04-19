% load in baseline-corrected wavelet TFR data (INDUCED) for baseline corr
% syllable data
% average together individual subjects (or just collect into one file) and plot all channels
% save files
% modified by rlg 1 feb 2011 for NEW long SYll EPOCHS
clear all; clc
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20'; 

bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';
bin{4}='Weak_Weak';


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'suj',suj,'_',bin{b},'_L_ind_rs_mblc.mat');
    end
    
end

%nsubj = length(S);

% collect all single subject data together
for m=1:length(S)
    
    for b=1:length(bin)
        
        data.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        TFdata.(bin{b}){m} = data.(bin{b}){m}.TFRwave_ind; % take only what we need (TFdata)
        
    end
end
clear data

load hydro65.lay.mat
load sopro_ERP_channels.mat % this worked to select just the channels I want... leaves out Cz, occipitals, and mastoids!

% recompute the average,
% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure
cfg = [];
cfg.layout       = hydro65lay;  %'GSN-HydroCel-65 1.0.sfp';     
cfg.channel = sopro_ERP_channels;
cfg.keepindividual = 'yes'; %put yes to save averages for each subject in file, not grandaverage
  
for b=1:length(bin)
    
    TFallSubj_ind   =    freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile         =    cat(2,bin{b}, '_L_allSubj_mblc_ind_rs.mat');
    save(outfile, 'TFallSubj_ind')
    
    clear outfile TFallSubj_ind
    
end





