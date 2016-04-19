% calculate difference waves ERPs
% modified on 12/16/11 by rlg
% maybe go in opposite direction...bin2 - bin1 will give negativity if
% larger N400 to Rhy-, so I can plot all individual subjects

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; 

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

