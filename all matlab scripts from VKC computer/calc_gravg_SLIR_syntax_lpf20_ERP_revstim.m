% load in baseline-corrected ERPs on chords tutorial
% calculate grand average by averaging together individual subjects and
% save
% mod. rlg 17 nov 2010

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_109';  S{2}='SLIR_110'; S{3}='SLIR_111'; S{4}='SLIR_112'; 
S{5}='SLIR_113';  S{6}='SLIR_114'; S{7}='SLIR_115'; S{8}='SLIR_116';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';
bin{5}='both_corr';
bin{6}='both_viol';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_',bin{b},'_syntax_lpf_ERP_blc.mat');
        
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
cfg.keepindividual = 'no'; %we want a grand average, so don't save individual subjects
cfg.layout       = EGI_layout129; 
   
for b=1:length(bin)
    
    gravg.(bin{b})=   ft_timelockgrandaverage(cfg,ERPdata.(bin{b}){:});
    outfile     =  cat(2, bin{b}, '_lpf_gravg_8TLD_revstim.mat');
    ERPgravg =  gravg.(bin{b});
    save(outfile, 'ERPgravg');
    
    clear outfile ERPgravg
    
end




