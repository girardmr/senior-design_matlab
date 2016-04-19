% baseline correction (and trim time window) of ERPs on tutorial data
% revised rlg feb 2012

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_109';  S{2}='SLIR_110'; S{3}='SLIR_111'; S{4}='SLIR_112'; 
S{5}='SLIR_113';  S{6}='SLIR_114'; S{7}='SLIR_115'; S{8}='SLIR_116';
S{9}='SLIR_201';  

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';
bin{5}='both_corr';
bin{6}='both_viol';


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_lpf_20_ERP.mat') % these contain ind. subj. averages
        load(filename)
 
        cfg.baseline= [-0.100 0]; % baseline correction

        data_blc = ft_timelockbaseline(cfg,data_ERP);
        clear data
        
        % trim off excess data and narrows to the window in which we want
        % to see the ERP: -100 to 1200ms.
        data = ft_selectdata(data_blc,'toilim',[-0.100 1.200]); % 


        outfile= cat(2,suj,'_',bin{b},'_syntax_lpf_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_blc filename outfile
        
    end
end



