% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 13 dec 2011

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (EVOKED) power during average
% of all conditions (all bins)

%% words
load CDT_controls_WordBins_avg_base_evo.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:length(bin) %for each condition 

        filename= cat(2,suj,'_CDT_',bin{b},'_tfr_evo.mat')
        load(filename)

        TFdata=TFRwave_evo.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_evo.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_CDT_',bin{b},'_tfr_avblc_evo.mat')
        save(outfile,'TFRwave_evo');
        
        clear TFdata TFRwave_evo baseline outfile
    end

end

clear avgbase_sepch





