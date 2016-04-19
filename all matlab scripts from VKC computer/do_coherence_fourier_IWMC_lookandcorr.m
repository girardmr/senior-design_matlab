% trying again FFT coherence on all channel combinations
% then during stas can narrow down to certain channel combinations somehow

clear all; clc

%% define subjects - CP1 pre and post
S{1}='HM19'; S{2}='HM32'; S{3}='HM42'; S{4}='HM43'; S{5}='HM47'; S{6}='HM48';
S{7}='HM66'; S{8}='HM90'; % don't use HM62 because too few trials

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='task_lookandcorr'; % 2 bins together
bin{2}='base';


load tut_layout.mat


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_fft.mat')
        load(filename)
        
        cfg            = [];
        cfg.method     = 'coh';
        
        %cfg.channelcmb = {'all' 'all'};
        % use 10-20 homologues, follow pairs in Bell paper
        
            cfg.channelcmb =  {'E22' 'E25';  ... %Frontal pole?medial frontal (Fp1?F3)
            'E14' 'E124'; ...   %Frontal pole?medial frontal (Fp2? F4)
            'E25' 'E34'; ... % Medial frontal?lateral frontal (F3?F7)
            'E124' 'E122'; ... % Medial frontal?lateral frontal (F4?F8)
            'E25' 'E53'; ... % Medial frontal?parietal (F3?P3)
            'E124' 'E87'; ... % Medial frontal?parietal (F4?P4)
            'E25' 'E72'; ... % Medial frontal?occipital (F3?O1).
            'E124' 'E77'; ... % Medial frontal?occipital (F4?O2).
            };   
        
% below would be left-right channel pairs        
%         cfg.channelcmb =  {'E22' 'E14';  ... %FP1 FP2
%             'E34' 'E122'; ... % F7 F8
%             'E25' 'E124'; ... % F3 F4
%             'E46' 'E109'; ... % T7 T8
%             'E37' 'E105'; ... % C3 C4
%             'E53' 'E87'; ... % P3 P4
%             'E59' 'E92'; ... % P7 P8
%             'E72' 'E77'; ... % O1 O2
%             };
                        
        FFTcoh = ft_connectivityanalysis(cfg, FFTdata);
        
        outfile= cat(2,suj,'_',bin{b},'_fft_coh.mat')
        save(outfile,'FFTcoh');
        clear data  outfile FFTdata FFTcoh filename
        
    end
end





















