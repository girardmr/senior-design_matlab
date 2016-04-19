% calculate difference waves ERPs
% modified on 12/16/11 by rlg
% maybe go in opposite direction...bin2 - bin1 will give negativity if
% larger N400 to Rhy-, so I can plot all individual subjects

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_CDT_',bin{b},'_ERP_blc.mat')
    end
    
end

for m=1:length(S)
    suj=S{m};
    
    %% familiar vs. unfamiliar constant
    cond1=load(file_cond.(bin{1}){m});
    %clear data
    cond2=load(file_cond.(bin{2}){m});
    
    New=cond1;
    New.data.avg = cond2.data.avg - cond1.data.avg; %     
    data = New.data;

    % name file
    outfile= cat(2,suj,'_CDTword_difwave_ERP.mat')
    save(outfile,'data');
    clear  data New outfile cond1 cond2
    
    
end

