
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

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

dlmwrite('MAP_controls_numtrials.txt',Table,'delimiter','\t','precision','%.1f');

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
    
    
    
    
    
    
    
    
    
    