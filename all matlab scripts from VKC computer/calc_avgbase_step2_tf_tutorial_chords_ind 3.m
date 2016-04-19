%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    INDUCED
%mod. by rlg sept 30, 2010

clear all; clc
%% define subjects
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';

%you don't need to define conditions in this one

for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,'chords_tut_subj',suj,'_avgbins_tfr_ind.mat')
    load(filename)

    for j=1:size(TFRwave_ind.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_ind.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_ind.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_ind 
end


save Tutorial_chords_avg_base_ind.mat avgbase_sepch