%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    evoked
%mod. by rlg 28 feb 2011

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03'; 

%you don't need to define conditions in this one
%% AUDITORY BINS (primes)
for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,suj,'_avgbins_tfr_evo.mat')
    load(filename)

    for j=1:size(TFRwave_evo.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_evo.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_evo.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_evo 
end


save Dynattpilot_avg_base_evo.mat avgbase_sepch
clear avgbase_sepch

