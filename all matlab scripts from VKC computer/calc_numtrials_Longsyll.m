% calculate # of trials for Frontiers paper
clear all; clc

%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';
% bin{4}='Weak_Weak';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'suj',suj,'_',bin{b},'L.mat')
    end
    
end
    
for m=1:length(S)
    suj=S{m};
    sujname = cat(2,'sopro',suj)
    for b=1:length(bin)
        
        Trialdata.(sujname).(bin{b}) = load(file_cond.(bin{b}){m});%load the file for each condition and each subject, put in one structure
        Numtrials.(sujname).(bin{b}) = length(Trialdata.(sujname).(bin{b}).data.trial);
        Table(m,b) = Numtrials.(sujname).(bin{b}); 
        clear data
        
    end
    subj(m,1) = str2num(suj)
end

%% calc mean and stdev

LongSyllTrialtotals = [];

All = [subj Table];

LongSyllTrialtotals.Table  = All;

for b=1:length(bin)

    binmean = mean(Table(:,b));
    
    binstd = std(Table(:,b));

    LongSyllTrialtotals.(bin{b}) = [binmean binstd]
        
end

 
save LongSyll_numtrials.mat LongSyllTrialtotals
    










