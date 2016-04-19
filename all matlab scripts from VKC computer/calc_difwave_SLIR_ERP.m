% calculate difference waves ERPs
% modified on 12/16/11 by rlg
% maybe go in opposite direction...bin2 - bin1 will give negativity if
% larger N400 to Rhy-, so I can plot all individual subjects

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
bin{6}='both_viol'

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_',bin{b},'_syntax_lpf_ERP_blc.mat')
    end
    
end

for m=1:length(S)
    suj=S{m};
    
    %% both 
    cond1=load(file_cond.(bin{5}){m});
    %clear data
    cond2=load(file_cond.(bin{6}){m});
    
    New=cond1;
    New.data.avg = cond2.data.avg - cond1.data.avg; %     
    data = New.data;

    % name file
    outfile= cat(2,suj,'_SLIR_difwavboth_ERP.mat')
    save(outfile,'data');
    clear  data New outfile cond1 cond2
    
    
end

for m=1:length(S)
    suj=S{m};
    
    %% both 
    cond1=load(file_cond.(bin{3}){m});
    %clear data
    cond2=load(file_cond.(bin{4}){m});
    
    New=cond1;
    New.data.avg = cond2.data.avg - cond1.data.avg; %     
    data = New.data;

    % name file
    outfile= cat(2,suj,'_SLIR_difwavTEN_ERP.mat')
    save(outfile,'data');
    clear  data New outfile cond1 cond2
    
    
end

for m=1:length(S)
    suj=S{m};
    
    %% both 
    cond1=load(file_cond.(bin{1}){m});
    %clear data
    cond2=load(file_cond.(bin{2}){m});
    
    New=cond1;
    New.data.avg = cond2.data.avg - cond1.data.avg; %     
    data = New.data;

    % name file
    outfile= cat(2,suj,'_SLIR_difwavSVA_ERP.mat')
    save(outfile,'data');
    clear  data New outfile cond1 cond2
    
    
end
