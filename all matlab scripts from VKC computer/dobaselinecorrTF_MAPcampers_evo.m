% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 13 october 2010

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY


bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; %
bin{5}= 'mus_Mismatch_face'; %
bin{6}= 'neutson_bothface'; %
% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (EVOKED) power during average
% of all conditions (all bins)

%% auditory bins - primes
load MAP_campers_AudBins_avg_base_evo.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:3 %for each condition %%IMPORTANT: ONLY FIRST 3 BINS

        filename= cat(2,suj,'_MAP_',bin{b},'_tfr_evo.mat')
        load(filename)

        TFdata=TFRwave_evo.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_evo.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_evo.mat')
        save(outfile,'TFRwave_evo');
        
        clear TFdata TFRwave_evo baseline outfile
    end

end

clear avgbase_sepch

%% FACE bins - TARGETS
load MAP_campers_FaceBins_avg_base_evo.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=4:6 %for each condition %%IMPORTANT: ONLY LAST 3 BINS

        filename= cat(2,suj,'_MAP_',bin{b},'_tfr_evo.mat')
        load(filename)

        TFdata=TFRwave_evo.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_evo.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_evo.mat')
        save(outfile,'TFRwave_evo');
        
        clear TFdata TFRwave_evo baseline outfile
    end

end

clear avgbase_sepch




