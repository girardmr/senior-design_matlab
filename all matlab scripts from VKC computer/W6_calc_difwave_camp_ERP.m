% calculate difference waves induced  match vs. mismatch W6 faces data
% modified on 12/20/11 by rlg

clear all; clc

%select subjects
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';


%select conditions

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_MAP_',bin{b},'_ERP_blc.mat');
    end
    
end

for m=1:length(S)
    suj=S{m};
    
    %% hapmusic vs neutson
    cond1=load(file_cond.(bin{1}){m});
    %clear data
    cond2=load(file_cond.(bin{3}){m});
    
    New=cond1;
    New.data.avg = cond1.data.avg - cond2.data.avg; % 
    data = New.data;
    
    % name file
    outfile= cat(2,suj,'_MAP_dif1v3_ERP_blc.mat')
    save(outfile,'data');
    clear  data New outfile cond1 cond2
    
    %% hapmus vs sadmus 
    cond1=load(file_cond.(bin{1}){m});
    %clear data
    cond2=load(file_cond.(bin{2}){m});
    
    New=cond1;
    New.data.avg = cond1.data.avg - cond2.data.avg; % 
    data = New.data;
    
    % name file
    outfile= cat(2,suj,'_MAP_dif1v2_ERP_blc.mat')
    save(outfile,'data');
    clear  data New outfile cond1 cond2
    
    
    
end

