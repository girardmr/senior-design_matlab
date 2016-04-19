%% try plotting FFT data
clear all
%% define subjects
S{1}='dap3_02'; % just CLM-G

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regularlong';
bin{2}='irregularlong';

load tut_layout.mat


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename = cat(2,suj,'_',bin{b},'_fft.mat');   
        
        load(filename)
        data.(suj).(bin{b}) = FFTdata;
                
        clear FFTdata
    end
end

cfg = [];
cfg.layout = EGI_layout129;
cfg.parameter = 'powspctrm';
cfg.interactive = 'yes'
cfg.showlabels = 'yes';

cfg.ylim = [0 4];
cfg.xlim = [5 50];
ft_multiplotER(cfg,data.(suj).(bin{1}),data.(suj).(bin{2}));