%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    inducED
%mod. by rlg 21 feb 2011

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

%you don't need to define conditions in this one
%% AUDITORY BINS (primes)
for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,'MAP_',suj,'_avgAudBins_tfr_ind.mat')
    load(filename)

    for j=1:size(TFRwave_ind.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_ind.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_ind.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_ind 
end


save MAP_controls_AudBins_avg_base_ind.mat avgbase_sepch
clear avgbase_sepch

%% FACE BINS (targets)
for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,'MAP_',suj,'_avgFaceBins_tfr_ind.mat')
    load(filename)

    for j=1:size(TFRwave_ind.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_ind.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_ind.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_ind 
end


save MAP_controls_FaceBins_avg_base_ind.mat avgbase_sepch
clear avgbase_sepch



