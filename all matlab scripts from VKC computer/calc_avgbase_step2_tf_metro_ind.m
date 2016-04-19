%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    induced
%mod. by rlg sept 30, 2010

clear all; clc
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';


%you don't need to define conditions in this one

for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,'metro_suj',suj,'_avgbins_tfr_ind.mat')
    load(filename)

    for j=1:size(TFRwave_ind.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_ind.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_ind.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_ind 
end


save Metronew_avg_base_ind.mat avgbase_sepch