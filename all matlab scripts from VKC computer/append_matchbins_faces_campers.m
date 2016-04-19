% append datasets from subconditions into match and mismatch conditions.
% WS camper data.
% rlg 17 feb. 2011
clear all;clc
tic
%% define subjects
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';


% warning: these bins are only for the visual face targets
oldbin{1}='HM_hapface'; %match
oldbin{2}='SM_hapface'; %mismatch
oldbin{3}='NS_hapface'; %neut
oldbin{4}='HM_sadface'; %mismatch
oldbin{5}='SM_sadface'; %match
oldbin{6}='NS_sadface'; %neut

newbin{1}= 'mus_Match_face'; % old bins 1 and 5
newbin{2}= 'mus_Mismatch_face'; % old bins 2 and 4
newbin{3}= 'neutson_bothface'; %old bins 3 and 6

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b= 1:length(oldbin)
        
        filename = cat(2,'MAP_',suj,'_',oldbin{b},'_trials.mat');
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
    data = ft_appenddata(cfg, trialdata.(suj).(oldbin{1}), trialdata.(suj).(oldbin{5}));
    outfile = cat(2,'MAP_',suj,'_',newbin{1},'_trials.mat');
    save(outfile, 'data')
    
    clear data outfile
    
    %MISMATCH
    cfg =[];
    data = ft_appenddata(cfg, trialdata.(suj).(oldbin{2}), trialdata.(suj).(oldbin{4}));
    outfile = cat(2,'MAP_',suj,'_',newbin{2},'_trials.mat');
    save(outfile, 'data')
    
    clear data outfile
    
    
    %NEUTRAL
    cfg =[];
    data = ft_appenddata(cfg, trialdata.(suj).(oldbin{3}), trialdata.(suj).(oldbin{6}));
    outfile = cat(2,'MAP_',suj,'_',newbin{3},'_trials.mat');
    save(outfile, 'data')
    
    clear data outfile
    
end
