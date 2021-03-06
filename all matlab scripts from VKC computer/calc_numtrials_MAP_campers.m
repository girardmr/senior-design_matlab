
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}='HM_hapface';
bin{5}='SM_hapface';
bin{6}='NS_hapface';
bin{7}='HM_sadface';
bin{8}='SM_sadface';
bin{9}='NS_sadface';
bin{10}= 'mus_Match_face'; % 
bin{11}= 'mus_Mismatch_face'; % 
bin{12}= 'neutson_bothface'; %


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,'MAP_',suj,'_',bin{b},'_trials.mat')
    end
    
end

for m=1:length(S)
    suj=S{m};
    for b=1:length(bin)
        
        Trialdata.(suj).(bin{b}) = load(file_cond.(bin{b}){m});%load the file for each condition and each subject, put in one structure
        Numtrials.(suj).(bin{b}) = length(Trialdata.(suj).(bin{b}).data.trial);
        Table(m,b) = Numtrials.(suj).(bin{b}); 
        clear data
        
    end
    
end
