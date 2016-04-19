% baseline correction (and trim time window) of ERPs on tutorial data
% revised rlg feb 2012

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101'; S{2} = 'SLIR_102'; S{3}='SLIR_103'; S{4} = 'SLIR_104';% 
S{5}='SLIR_105'; S{6} = 'SLIR_106'; S{7}='SLIR_108'; S{8} = 'SLIR_109';% 
S{9}='SLIR_110'; S{10} = 'SLIR_111'; S{11}='SLIR_112'; S{12} = 'SLIR_113';%

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='PhyAcc1';
bin{2}='PhyAcc2';


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_ERP.mat') % these contain ind. subj. averages
        load(filename)
        
        %Low-pass filter trial data
        cfg = [];
        cfg.lpfilter = 'yes';
        cfg.lpfreq = 20;
        data_fil = ft_preprocessing(cfg,data_ERP);
        
        cfg= [];
        cfg.baseline= [-0.100 0]; % baseline correction

        data_blc = ft_timelockbaseline(cfg,data_fil);
        clear data
        
        % trim off excess data and narrows to the window in which we want
        % to see the ERP: -100 to 1200ms.
        data = ft_selectdata(data_blc,'toilim',[-0.100 0.800]); % 


        outfile= cat(2,suj,'_',bin{b},'_lpf_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_fil data_blc filename outfile
        
    end
end



