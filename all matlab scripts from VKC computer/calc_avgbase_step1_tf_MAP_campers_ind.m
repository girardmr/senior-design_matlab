%%compute average across conditions to use as baseline
% tutorial
% rlg 30 september 2010

clear all; clc

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
    %load all the files for one subject
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_MAP_',bin{b},'_tfr_ind.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    %% calculate average power for Primes (auditory stim)
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    cfg.toilim         = [-0.100 0.650];  %%  IMPORTANT - HERE I TRIMMED, BECAUSE I WILL TRIM WHEN I TAKE THE GRAND AVERAGES AND ALL SUBJECT AVERAGES TOO
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_ind = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_ind, data.(bin{2}).TFRwave_ind, data.(bin{3}).TFRwave_ind);
    outfile= cat(2,'MAP_',suj,'_avgAudBins_tfr_ind.mat')
    save(outfile,'TFRwave_ind');
    clear TFRwave_ind outfile
    
    %% calculate average power for Primes (auditory stim)
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    % if you have a different # of bins, the line below needs to be adjusted!
    cfg.toilim         = [-0.100 0.650];
    
    TFRwave_ind = ft_freqgrandaverage(cfg, data.(bin{4}).TFRwave_ind, data.(bin{5}).TFRwave_ind, data.(bin{6}).TFRwave_ind);
    outfile= cat(2,'MAP_',suj,'_avgFaceBins_tfr_ind.mat')
    save(outfile,'TFRwave_ind');
    clear TFRwave_ind outfile
    
    clear data
    
end




