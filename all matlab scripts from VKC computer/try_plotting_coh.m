% try with "ft_connectivityplot"

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
        filename = cat(2,suj,'_',bin{b},'_fft_coh.mat');   
        
        load(filename)
        cohdata.(suj).(bin{b}) = CSDcoh;
                
    end
end

%%
cfg                  = [];
cfg.xparam           = 'freq';
cfg.zparam           = 'cohspctrm';
cfg.xlim             = [4 54]; % frequency band
cfg.cohrefchannel    = 'E47'; % pick something! 
cfg.layout           = EGI_layout129;
cfg.showlabels       = 'yes';
cfg.interactive      = 'yes';
figure

% getting an error message here, may just be layout file issu
ft_multiplotER(cfg, cohdata.(suj).(bin{1}),cohdata.(suj).(bin{2}),cohdata.(suj).(bin{3}))