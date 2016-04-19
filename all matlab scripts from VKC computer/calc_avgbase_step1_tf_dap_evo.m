%%compute average across conditions to use as baseline
% dynatta pilot
% rlg 28 feb 2011
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='loud_tone';
bin{2}='omit_tone';



for m=1:length(S) %for each subject
    suj=S{m};
    %load all the files for one subject
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    %% calculate average power for Primes (auditory stim)
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    cfg.toilim         = [-0.899 0.901];  %%  IMPORTANT - HERE I TRIMMED, BECAUSE I WILL TRIM WHEN I TAKE THE GRAND AVERAGES AND ALL SUBJECT AVERAGES TOO
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_evo = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_evo, data.(bin{2}).TFRwave_evo);
    outfile= cat(2,suj,'_avgbins_tfr_evo.mat')
    save(outfile,'TFRwave_evo');
    clear TFRwave_evo outfile
    
    
end




