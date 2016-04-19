%%compute average across conditions to use as baseline
% WS campers
% rlg 21 feb 2011

clear all; clc
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
    %load all the files for one subject
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_MAP_',bin{b},'_tfr_evo.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    %% calculate average power for Primes (auditory stim)
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    cfg.toilim         = [-0.100 0.650];  %%  IMPORTANT - HERE I TRIMMED, BECAUSE I WILL TRIM WHEN I TAKE THE GRAND AVERAGES AND ALL SUBJECT AVERAGES TOO
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_evo = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_evo, data.(bin{2}).TFRwave_evo, data.(bin{3}).TFRwave_evo);
    outfile= cat(2,'MAP_',suj,'_avgAudBins_tfr_evo.mat')
    save(outfile,'TFRwave_evo');
    clear TFRwave_evo outfile
    
    %% calculate average power for Primes (auditory stim)
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    % if you have a different # of bins, the line below needs to be adjusted!
    cfg.toilim         = [-0.100 0.650];
    
    TFRwave_evo = ft_freqgrandaverage(cfg, data.(bin{4}).TFRwave_evo, data.(bin{5}).TFRwave_evo, data.(bin{6}).TFRwave_evo);
    outfile= cat(2,'MAP_',suj,'_avgFaceBins_tfr_evo.mat')
    save(outfile,'TFRwave_evo');
    clear TFRwave_evo outfile
    
    clear data
    
end




