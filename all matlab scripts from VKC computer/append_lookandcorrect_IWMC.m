% append datasets from subconditions into one big bin
% iwmc data.
% rlg 31 aug 2012
clear all;clc
tic
%% define subjects
S{1}='HM19'; S{2}='HM32'; S{3}='HM42'; S{4}='HM43'; S{5}='HM47'; S{6}='HM48';
S{7}='HM66'; S{8}='HM90'; % don't use HM62 because too few trials

%old bins
oldbin{1}='nolook';
oldbin{2}='look';
%oldbin{3}='correct'; 

% new bin
newbin{1}= 'task_lookandcorr'; % old bins 1 and 2


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
    %all 3 task conditions
    data = ft_appenddata(cfg, trialdata.(suj).(oldbin{1}), trialdata.(suj).(oldbin{2}));
    outfile = cat(2,suj,'_',newbin{1},'_trials.mat');
    save(outfile, 'data')
    
    clear data outfile
    
    
end
