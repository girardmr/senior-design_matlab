% load in baseline-corrected ERPs on chords tutorial
% collect together individual subjects into one file
% save files 
% created Aug. 24, 2009 by rlg
% mod rlg 27 april 2012

clear all; clc

%% define subjects % SHOWED N400?
S{1}='W701'; S{2}='W702'; S{3}='W704'; S{4}='W711'; S{5}='W714'; 
S{6}='W717'; S{7}='W718'; S{8}='W722';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_CDT_',bin{b},'_ERP_blc.mat');
    end
    
end

% collect all single subject data together
for m=1:length(S)
    
    for b=1:length(bin)
        
        ERP.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        ERPdata.(bin{b}){m} = ERP.(bin{b}){m}.data; % take only what we need (ERP data)
        
    end
    %clear ERP
end

%Read in the electrode location file for this montage
load tut_layout.mat % this layout excludes EOG channels

cfg = [];
cfg.keepindividual = 'yes'; %put yes to save averages for each subject in file - ready for statistical analysis
%cfg.channel= ; % you can specify channels here, e.g. if you want to
%exclude eye channels (for now keeps all channels)
cfg.layout       = EGI_layout129;  % 
   
for b=1:length(bin)
    
    allSubj.(bin{b})=   ft_timelockgrandaverage(cfg,ERPdata.(bin{b}){:});
    outfile     =  cat(2,'CDT_campers_',bin{b},'_allSubj_subgroup_ERP.mat'); 
    ERPallSubj =  allSubj.(bin{b});
    save(outfile, 'ERPallSubj');
    
    clear outfile ERPallSubj
    
end

