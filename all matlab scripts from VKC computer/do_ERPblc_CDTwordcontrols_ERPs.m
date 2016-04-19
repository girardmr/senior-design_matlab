% baseline correction of ERPs on WS controls data  bins
% rlg 1 dec 2011
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_CDT_',bin{b},'_ERP.mat') % these contain ind. subj. averages; already applied 55hz lowpass
        load(filename)
        
        cfg.baseline = [-0.150 0];
        data_blc = ft_timelockbaseline(cfg,data_ERP);


        % ERP
         %cfg=[];
        % cfg.latency=[-0.150 1.000];   % trims off excess data and narrows to the window we want to see the ERP in             
% 
%         %%
% use this instead
         %data = ft_timelockanalysis(cfg,data_long); % 
        data = ft_selectdata(data_blc,'toilim',[-0.150 1.000]); % 

        outfile= cat(2,suj,'_CDT_',bin{b},'_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_blc filename outfile
        
    end
end



