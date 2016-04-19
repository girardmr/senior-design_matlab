% load in baseline-corrected TFR EVOKED (new) on metronew
% avg together individual subjects
% save files 
% mod. oct 14 2010 by rlg

clear all; clc
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

bin{1} = 'metrobeats';
bin{2} = 'offbeats';

%%

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'suj',suj,'_',bin{b},'_tfr_avblc_evo.mat') 
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

load hydro65.lay.mat
load sopro_ERP_channels.mat % this worked to select just the channels I want... leaves out Cz, occipitals, and mastoids!

% recompute the average,
% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure
cfg = [];
cfg.keepindividual = 'no'; %put yes to save averages for each subject in file
cfg.layout       = hydro65lay;  %'GSN-HydroCel-65 1.0.sfp';     
cfg.channel = sopro_ERP_channels;

  
for b=1:length(bin)
    
    gravg.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,bin{b}, '_gravg_avblc_evo.mat');
    TFgravg_evo =  gravg.(bin{b});
    save(outfile, 'TFgravg_evo');
    
    clear outfile TFgravg_evo
    
end



