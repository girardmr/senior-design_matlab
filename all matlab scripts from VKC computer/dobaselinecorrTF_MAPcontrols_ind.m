% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 13 october 2010

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %
% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (indKED) power during average
% of all conditions (all bins)

%% auditory bins - primes
load MAP_controls_AudBins_avg_base_ind.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:3 %for each condition %%IMPORTANT: ONLY FIRST 3 BINS

        filename= cat(2,suj,'_MAP_',bin{b},'_tfr_ind.mat')
        load(filename)

        TFdata=TFRwave_ind.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_ind.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_ind.mat')
        save(outfile,'TFRwave_ind');
        
        clear TFdata TFRwave_ind baseline outfile
    end

end

clear avgbase_sepch

%% FACE bins - TARGETS
load MAP_controls_FACEBins_avg_base_ind.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=4:6 %for each condition %%IMPORTANT: ONLY LAST 3 BINS

        filename= cat(2,suj,'_MAP_',bin{b},'_tfr_ind.mat')
        load(filename)

        TFdata=TFRwave_ind.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_ind.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_ind.mat')
        save(outfile,'TFRwave_ind');
        
        clear TFdata TFRwave_ind baseline outfile
    end

end

clear avgbase_sepch




