%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    EVOKED
%mod. by rlg sept 30, 2010

clear all; clc
%% define subjects
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104';


%you don't need to define conditions in this one

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


save SLIR_syntax_avg_base_evo.mat avgbase_sepch