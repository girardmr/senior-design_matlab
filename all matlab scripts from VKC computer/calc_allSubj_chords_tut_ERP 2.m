% load in baseline-corrected ERPs on chords tutorial
% collect together individual subjects into one file
% save files 
% created Aug. 24, 2009 by rlg
% mod rlg 15 october 2010

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
        file_cond.(bin{b}){m}= cat(2,'chords_tut_subj',suj,'_',bin{b},'_ERP_blc.mat')
    end
    
end


% collect all single subject data together
for m=1:length(S)
    
    for b=1:length(bin)
        
        ERP.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        ERPdata.(bin{b}){m} = ERP.(bin{b}){m}.data; % take only what we need (ERP data)
        
    end
    clear data
end


%Read in the electrode location file for this montage
load EGI_layout129.lay.mat

cfg = [];
cfg.keepindividual = 'yes'; %put yes to save averages for each subject in file - ready for statistical analysis
%cfg.channel= ; % you can specify channels here, e.g. if you want to
%exclude eye channels (for now keeps all channels)
cfg.layout       = EGI_layout129;  %'GSN-HydroCel-65 1.0.sfp';    
   
for b=1:length(bin)
    
    allSubj.(bin{b})=   ft_timelockgrandaverage(cfg,ERPdata.(bin{b}){:});
    outfile     =  cat(2,'chords_ERP_',bin{b}, '_allSubj.mat');
    ERPallSubj =  allSubj.(bin{b});
    save(outfile, 'ERPallSubj');
    
    clear outfile ERPallSubj
    
end


