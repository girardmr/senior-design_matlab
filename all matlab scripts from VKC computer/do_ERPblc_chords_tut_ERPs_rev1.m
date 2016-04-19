% baseline correction (and trim time window) of ERPs on tutorial data
% revised rlg feb 2012

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'chords_tut_subj',suj,'_',bin{b},'_ERP.mat') % these contain ind. subj. averages
        load(filename)
 
        cfg.baseline= [-0.100 0]; % baseline correction

        data_blc = ft_timelockbaseline(cfg,data_ERP);
        clear data
        
        % trim off excess data and narrows to the window in which we want
        % to see the ERP: -100 to 800ms.
        data = ft_selectdata(data_blc,'toilim',[-0.100 0.800]); % 


        outfile= cat(2,'chords_tut_subj',suj,'_',bin{b},'_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_blc filename outfile
        
    end
end



