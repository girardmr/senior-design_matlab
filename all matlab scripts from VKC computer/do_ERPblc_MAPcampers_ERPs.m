% baseline correction of ERPs on WS data  bins
% rlg 3 march 2011

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

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



