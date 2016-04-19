% calculate # of trials for Frontiers paper
clear all; clc

%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

bin{1}='targ_WA_word';
bin{2}='targ_WA_psudo';
bin{3}='targ_MA_word';
bin{4}='targ_MA_psudo';
bin{5}='targ_IR_word';
bin{6}='targ_IR_psudo';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'suj',suj,'_',bin{b},'.mat')
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

targ_WAmain = Table(:,1)+Table(:,2);
targ_MAmain = Table(:,3)+Table(:,4);
targ_IRmain = Table(:,5)+Table(:,6);


%% calc mean and stdev

TargetsTrialtotals = [];

All = [subj Table];

TargetsTrialtotals.Table  = All;

for b=1:length(bin)

    binmean = mean(Table(:,b));
    
    binstd = std(Table(:,b));

    TargetsTrialtotals.(bin{b}) = [binmean binstd]
           
end

TargetsTrialtotals.targ_WAmain = [mean(targ_WAmain) std(targ_WAmain)];
TargetsTrialtotals.targ_MAmain = [mean(targ_MAmain) std(targ_MAmain)];
TargetsTrialtotals.targ_IRmain = [mean(targ_WAmain) std(targ_IRmain)];


save Targets_numtrials.mat TargetsTrialtotals
    










