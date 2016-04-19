% trying again FFT coherence on all channel combinations
% then during stas can narrow down to certain channel combinations somehow

clear all; clc

%% define subjects - CP1 pre and post
S{1}='01_pre'; S{2}='02_pre'; S{3}='03_pre'; S{4}='04_pre'; S{5}='05_pre';
S{6}='06_pre'; S{7}='07_pre'; S{8}='08_pre'; S{9}='09_pre'; S{10}='10_pre';

S{11}='01_post'; S{12}='02_post'; S{13}='03_post';  S{14}='04_post'; S{15}='05_post';
S{16}='06_post'; S{17}='07_post'; S{18}='08_post';  S{19}='09_post';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='snd'; % all 3 bins together

load tut_layout.mat
tic

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'CP',suj,'_',bin{b},'_fft.mat')
        load(filename)
        
        cfg            = [];
        cfg.method     = 'wpli_debiased';
        
        %cfg.channelcmb = {'all' 'all'};
        % use 10-20 homologues
        cfg.channelcmb =  {'E22' 'E14';  ... %FP1
            'E34' 'E122'; ... % F7 F8
            'E25' 'E124'; ... % F3 F4
            'E46' 'E109'; ... % T7 T8
            'E37' 'E105'; ... % C3 C4
            'E53' 'E87'; ... % P3 P4
            'E59' 'E92'; ... % P7 P8
            'E71' 'E77'; ... % O1 O2
            };
        
        
        
        FFTcoh = ft_connectivityanalysis(cfg, FFTdata);
        
        outfile= cat(2,'CP',suj,'_',bin{b},'_fft_coh.mat')
        save(outfile,'FFTcoh');
        clear data  outfile FFTdata FFTcoh filename
        
    end
end



toc
