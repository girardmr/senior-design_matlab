
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %


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

dlmwrite('MAP_campers_numtrials.txt',Table,'delimiter','\t','precision','%.1f');

% %% change name of output file here
% outputfilename=cat(2,'MAP_campers_numtrials.txt')
% fid = fopen(outputfilename,'w');
% %write results to a space-delimited output file
% 
% fprintf(fid,'%s %s %s %s %s %s \n', 'subject', bin)
% 
% fid = fopen(outputfilename,'a'); % append to what we just wrote
% 
% for row= 1:size(Table,1)
%     suj=S{m};
%     
%     fprintf(fid, '%s %d %d %d %d %d %d \n', suj, Table{row,:});
% end
% 
% 
% 
% 
%     
%     
%     
%     
%     
    
    
    
    
    
    
    
    
    
    