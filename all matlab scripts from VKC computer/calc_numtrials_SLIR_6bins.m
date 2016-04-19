
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104'; 
S{5}='SLIR_105';  S{6}='SLIR_106'; S{7}='SLIR_107'; S{8}='SLIR_108';
S{9}='SLIR_109';  S{10}='SLIR_110'; S{11}='SLIR_111'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY


bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';
bin{5}='both_corr';
bin{6}='both_viol';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_',bin{b},'_trials.mat')
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

dlmwrite('SLIR_11Ss_TLD_numtrials.txt',Table,'delimiter','\t','precision','%.1f');

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
    
    
    
    
    
    
    
    
    
    