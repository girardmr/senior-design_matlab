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
        load(cat(2,'CP',sujPre,'_',bin{b},'_fft_coh_all.mat'))
        coh1 = FFTcoh;
        clear FFTcoh;
        
        load(cat(2,'CP',sujPost,'_',bin{b},'_fft_coh_all.mat'))
        coh2 = FFTcoh;
        clear FFTcoh;
        
        cohdif = coh1; coh1Z = coh1; coh2Z = coh2;% make new versions
        
        % do Ztransformations b/c distribution of Coherence values are not normal
        coh1Z.wpli_debiasedspctrm = atanh(coh1.wpli_debiasedspctrm);
        FFTcoh = coh1Z;
        outfile= cat(2,'CP',sujPre,'_',bin{b},'_fft_coh_all_Z.mat')
        save(outfile,'FFTcoh')
        clear FFTcoh outfile coh1Z
        
        coh2Z.wpli_debiasedspctrm = atanh(coh2.wpli_debiasedspctrm);
        FFTcoh = coh2Z;
        outfile= cat(2,'CP',sujPost,'_',bin{b},'_fft_coh_all_Z.mat')
        save(outfile,'FFTcoh')
        clear FFTcoh outfile coh2Z
        
        % Ztransformed coherence DIFFERENCE between conditions
    
        cohdif.wpli_debiasedspctrm = atanh(coh2.wpli_debiasedspctrm) - atanh(coh1.wpli_debiasedspctrm);
        
        outfile= cat(2,'CP',sujPre,'vspost_',bin{b},'_fft_coh_all_Z.mat')
        save(outfile,'cohdif');
        clear outfile
        
        % then make a dummy version containing just zeros
        cohdummy = coh2;
        cohdummy.wpli_debiasedspctrm(:) = 0;
        
        outfile= cat(2,'CP',sujPre(1:end-4),'_dummy_',bin{b},'_fft_coh_all_Z.mat')
        save(outfile,'cohdummy');
        
        clear outfile cohdummy cohdif coh1 coh2
        
    end
end


%%


