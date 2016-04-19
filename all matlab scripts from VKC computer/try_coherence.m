clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='hobbs01'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='FamVoice';
bin{2}='UnfamVoiceParent';
bin{3}='UnfamVoiceConstant';


load tut_layout.mat


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_csd.mat')
        load(filename)
        
        cfg            = [];
        cfg.method     = 'coh';
        
        cfg.channelcmb = {'all' 'all'};
        CSDcoh = ft_connectivityanalysis(cfg, CSDdata);
        
        outfile= cat(2,suj,'_',bin{b},'_csd_coh.mat')
        save(outfile,'CSDcoh');
        clear data  outfile CSDdata CSDcoh filename

    end
end


    

