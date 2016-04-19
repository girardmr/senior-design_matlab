%Z transformation b/c coherence values don't have a normal distribution
% rlg 29 sept 2011


clear all; clc

%% define subjects - CP1 pre and post
S{1}='HM19'; S{2}='HM32'; S{3}='HM42'; S{4}='HM43'; S{5}='HM47'; S{6}='HM48';
S{7}='HM66'; S{8}='HM90'; % don't use HM62 because too few trials

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='task_lookandcorr'; % 2 bins together
bin{2}='base';


for m=1:length(S) %for each subject
    suj  = S{m};
    
    for b=1:length(bin) %coh for pre vs post
        load(cat(2,suj,'_',bin{b},'_fft_coh.mat'))
        data.(bin{b}).(suj)= FFTcoh; clear FFTcoh
        
    end
end

%% 

% calculate mean across frequency bands and then write to a text file...
BigTable = [];
freq = [6 9.2] 
for m=1:length(S) %for each subject
    suj = S{m};
    
    cohTask = ft_selectdata(data.(bin{1}).(suj),'foilim',freq,'avgoverfreq','yes')
    BigTable(m,1:8) = cohTask.cohspctrm'; % just take coh values, transpose to put subjects in rows, chanpairs in columns
    
    cohBase = ft_selectdata(data.(bin{2}).(suj),'foilim',freq,'avgoverfreq','yes')
    BigTable(m,9:16) = cohBase.cohspctrm'; % just take coh values, transpose to put subjects in rows, chanpairs in columns
    
    clear cohTask cohBase
end

% write at end of each freq band
outfilename = 'IWMCoh_Bellchanpairs_LookandCorrvsBase.txt' % 
fid = fopen(outfilename,'w');

%headerline with channel pairs:
fprintf(fid, 'Fp1-F3\t Fp2-F4\t F3-F7\t F4-F8\t F3-P3\t F4-P4\t F3-O1\t F4-O2\t Fp1-F3\t Fp2-F4\t F3-F7\t F4-F8\t F3-P3\t F4-P4\t F3-O1\t F4-O2\t \n');

dlmwrite('IWMCoh_Bellchanpairs_LookandCorrvsBase.txt',BigTable,'delimiter','\t','precision','%.4f','-append')

