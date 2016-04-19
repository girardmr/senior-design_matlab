%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    INDUCED
%mod. by rlg 21 feb 2011

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

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


save MAP_campers_AudBins_avg_base_ind.mat avgbase_sepch
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


save MAP_campers_FaceBins_avg_base_ind.mat avgbase_sepch
clear avgbase_sepch



