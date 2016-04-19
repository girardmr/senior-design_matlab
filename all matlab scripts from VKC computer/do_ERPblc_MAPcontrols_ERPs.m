% baseline correction of ERPs on WS data  bins
% rlg 3 march 2011

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_MAP_',bin{b},'_ERP.mat') % these contain ind. subj. averages; already applied 55hz lowpass
        load(filename)
        
        cfg.baseline = [-0.150 0];
        data = ft_timelockbaseline(cfg,data_ERP);


        % ERP
%         cfg=[];
%         cfg.latency=[-0.150 1.000];   % trims off excess data and narrows to the window we want to see the ERP in             
% 
%         %%
%         data = ft_timelockbaseline(cfg,data_ERP); % 

        outfile= cat(2,suj,'_MAP_',bin{b},'_ERP_blc.mat')
        save(outfile,'data');
        clear outfile data data_ERP data_blc filename outfile
        
    end
end



