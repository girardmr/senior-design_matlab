%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    induced
%mod. by rlg 28 feb 2011

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';


%you don't need to define conditions in this one
%% AUDITORY BINS (primes)
for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,suj,'_avgbins_tfr_ind.mat')
    load(filename)

    for j=1:size(TFRwave_ind.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_ind.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_ind.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_ind
end


save Dap3_avg_base_ind.mat avgbase_sepch
clear avgbase_sepch

