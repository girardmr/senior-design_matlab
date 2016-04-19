% append datasets from subconditions into match and mismatch conditions.
% SLIR data.
% rlg 17 feb. 2011
clear all;clc
tic
%% define subjects
S{1}='SLIR_109';  S{2}='SLIR_110'; S{3}='SLIR_111'; S{4}='SLIR_112'; 
S{5}='SLIR_113';  S{6}='SLIR_114'; S{7}='SLIR_115'; S{8}='SLIR_116';
S{9}='SLIR_201';  


% warning: these bins are only for the visual face targets
oldbin{1}='SVA_corr'; %match
oldbin{2}='SVA_viol'; %mismatch
oldbin{3}='TEN_corr'; %match
oldbin{4}='TEN_viol'; %mismatch


newbin{1}= 'both_corr'; % old bins 1 and 3
newbin{2}= 'both_viol'; % old bins 2 and 4


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b= 1:length(oldbin)
        
        filename = cat(2,suj,'_',oldbin{b},'_trials.mat');
        load(filename)
        trialdata.(suj).(oldbin{b}) = data;
        clear data filename
    end
    
    %     clear trialdata
    
end

for m=1:length(S) %for each subject
    suj=S{m};
    
    cfg =[]; % have to create cfg here, even though it can be empty.
    %MATCH
    data = ft_appenddata(cfg, trialdata.(suj).(oldbin{1}), trialdata.(suj).(oldbin{3}));
    outfile = cat(2,suj,'_',newbin{1},'_trials.mat');
    save(outfile, 'data')
    
    clear data outfile
    
    %MISMATCH
    cfg =[];
    data = ft_appenddata(cfg, trialdata.(suj).(oldbin{2}), trialdata.(suj).(oldbin{4}));
    outfile = cat(2,suj,'_',newbin{2},'_trials.mat');
    save(outfile, 'data')
    
    clear data outfile
    
end
