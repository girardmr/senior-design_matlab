% baseline correction of ERPs on WS controls data  bins
% rlg 1 dec 2011

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; 

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


%         % ERP
%          cfg=[];
%          cfg.latency=[-0.150 1.000];   % trims off excess data and narrows to the window we want to see the ERP in             
% % 
% %         %%
        data = ft_selectdata(data_blc,'toilim',[-0.150 1.000]); % 

        outfile= cat(2,suj,'_CDT_',bin{b},'_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_blc filename outfile
        
    end
end



