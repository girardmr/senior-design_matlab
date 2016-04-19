% baseline correction (and trim time window) of ERPs on tutorial data
% revised rlg feb 2012

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_lpf_20_ERP.mat') % these contain ind. subj. averages
        load(filename)
 
        cfg.baseline= [-0.100 0]; % baseline correction

        data_blc = ft_timelockbaseline(cfg,data_ERP);
        clear data
        
        % trim off excess data and narrows to the window in which we want
        % to see the ERP: -100 to 800ms.
        data = ft_selectdata(data_blc,'toilim',[-0.100 1.200]); % 


        outfile= cat(2,suj,'_',bin{b},'_syntax_lpf_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_blc filename outfile
        
    end
end



