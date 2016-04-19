%%compute average across conditions to use as baseline
% dynatta pilot
% rlg 28 feb 2011
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regular';
bin{2}='irregular';


for m=1:length(S) %for each subject
    suj=S{m};
    %load all the files for one subject
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_tfr_ind.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    %% calculate average power for Primes (auditory stim)
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    %cfg.toilim         = [-0.150 0.350]; already trimmed so don't need to
    %trim again
    %  IMPORTANT - HERE I TRIMMED, BECAUSE I WILL TRIM WHEN I TAKE THE GRAND AVERAGES AND ALL SUBJECT AVERAGES TOO
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_ind = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_ind, data.(bin{2}).TFRwave_ind);
    outfile= cat(2,suj,'_avgbins_tfr_ind.mat')
    save(outfile,'TFRwave_ind');
    clear TFRwave_ind outfile
    
    
end




