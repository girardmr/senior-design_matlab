%Z transformation b/c coherence values don't have a normal distribution
% rlg 29 sept 2011


clear all; clc

%% define subjects - CP1 pre and post
Spre{1}='01_pre'; Spre{2}='02_pre'; Spre{3}='03_pre'; Spre{4}='04_pre'; Spre{5}='05_pre';
Spre{6}='06_pre'; Spre{7}='07_pre'; Spre{8}='08_pre'; Spre{9}='09_pre'; %Spre{10}='10_pre'; 10 didnt' do post

Spost{1}='01_post'; Spost{2}='02_post'; Spost{3}='03_post'; Spost{4}='04_post'; Spost{5}='05_post';
Spost{6}='06_post'; Spost{7}='07_post'; Spost{8}='08_post';  Spost{9}='09_post';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='snd'; % all 3 bins together



for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    sujPost = Spost{m};
    
    for b=1:length(bin) %coh for pre vs post
        load(cat(2,'CP',sujPre,'_',bin{b},'_fft_coh_Z.mat'))
        data.Pre{m}= FFTcoh; clear FFTcoh
        
        load(cat(2,'CP',sujPost,'_',bin{b},'_fft_coh_Z.mat'))
        data.Post{m}= FFTcoh; clear FFTcoh
        
    end
end

%% THETA

% calculate mean across frequency bands and then write to a text file...
BigTable = [];
freq = [4 7]
for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    
    cohPre = ft_selectdata(data.Pre{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,1:8) = cohPre.wpli_debiasedspctrm'; % just take coh values, transpose to put subjects in rows, chanpairs in columns
    
    cohPost = ft_selectdata(data.Post{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,9:16) = cohPost.wpli_debiasedspctrm'; % post in same row
    
    clear cohPre cohPost
end

% write at end of each freq band
outfilename = 'CP_theta_1020_prevspost.txt' % can use for batch if same filename as seg +.evt
fid = fopen(outfilename,'w');

%headerline with channel pairs:
fprintf(fid, 'FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t \n');

dlmwrite('CP_theta_1020_prevspost.txt',BigTable,'delimiter','\t','precision','%.4f','-append')


%% ALPHA

% calculate mean across frequency bands and then write to a text file...
BigTable = [];
freq = [8 12]
for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    
    cohPre = ft_selectdata(data.Pre{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,1:8) = cohPre.wpli_debiasedspctrm'; % just take coh values, transpose to put subjects in rows, chanpairs in columns
    
    cohPost = ft_selectdata(data.Post{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,9:16) = cohPost.wpli_debiasedspctrm'; % post in same row
    
    clear cohPre cohPost
end

% write at end of each freq band
outfilename = 'CP_alpha_1020_prevspost.txt' % can use for batch if same filename as seg +.evt
fid = fopen(outfilename,'w');

%headerline with channel pairs:
fprintf(fid, 'FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t \n');

dlmwrite('CP_alpha_1020_prevspost.txt',BigTable,'delimiter','\t','precision','%.4f','-append')

%% BETA

% calculate mean across frequency bands and then write to a text file...
BigTable = [];
freq = [13 25]
for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    
    cohPre = ft_selectdata(data.Pre{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,1:8) = cohPre.wpli_debiasedspctrm'; % just take coh values, transpose to put subjects in rows, chanpairs in columns
    
    cohPost = ft_selectdata(data.Post{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,9:16) = cohPost.wpli_debiasedspctrm'; % post in same row
    
    clear cohPre cohPost
end

% write at end of each freq band
outfilename = 'CP_beta_1020_prevspost.txt' % can use for batch if same filename as seg +.evt
fid = fopen(outfilename,'w');

%headerline with channel pairs:
fprintf(fid, 'FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t \n');

dlmwrite('CP_beta_1020_prevspost.txt',BigTable,'delimiter','\t','precision','%.4f','-append')

%% GAMMA

% calculate mean across frequency bands and then write to a text file...
BigTable = [];
freq = [26 54]
for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    
    cohPre = ft_selectdata(data.Pre{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,1:8) = cohPre.wpli_debiasedspctrm'; % just take coh values, transpose to put subjects in rows, chanpairs in columns
    
    cohPost = ft_selectdata(data.Post{m},'foilim',freq,'avgoverfreq','yes')
    BigTable(m,9:16) = cohPost.wpli_debiasedspctrm'; % post in same row
    
    clear cohPre cohPost
end

% write at end of each freq band
outfilename = 'CP_gamma_1020_prevspost.txt' % can use for batch if same filename as seg +.evt
fid = fopen(outfilename,'w');

%headerline with channel pairs:
fprintf(fid, 'FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t FP1-FP2\t F7-F8\t F3-F4\t T7-T8\t C3-C4\t P3-P4\t P7-P8\t O1-O2\t \n');

dlmwrite('CP_gamma_1020_prevspost.txt',BigTable,'delimiter','\t','precision','%.4f','-append')

