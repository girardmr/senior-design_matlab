% trying again FFT coherence on all channel combinations
% then during stas can narrow down to certain channel combinations somehow

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='07'; S{2}='08'; S{3}='09'; S{4}='10'; S{5}='11'; S{6}='14'; S{7}='16';
S{8}='17'; S{9}='18'; S{10}='19'; S{11}='20'; S{12}='21'; S{13}='22'; S{14}='23';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='FamVoice';
bin{2}='UnfamVoiceParent';
bin{3}='UnfamVoiceConstant';


load tut_layout.mat


for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'voices',suj,'_',bin{b},'_fft.mat')
        load(filename)
        
        cfg            = [];
        cfg.method     = 'wpli_debiased';
        
        cfg.channelcmb = {'all' 'all'};
        FFTcoh = ft_connectivityanalysis(cfg, FFTdata);
        
        outfile= cat(2,'voices',suj,'_',bin{b},'_fft_coh.mat')
        save(outfile,'FFTcoh');
        clear data  outfile FFTdata FFTcoh filename

    end
end


    

