% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 13 october 2010

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regular';
bin{2}='irregular';
% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (induced) power during average
% of all conditions (all bins)

%% auditory bins - primes
load Dap3_avg_base_ind.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:length(bin) %for each condition %%IMPORTANT: ONLY FIRST 3 BINS

        filename= cat(2,suj,'_',bin{b},'_tfr_ind.mat')
        load(filename)

        TFdata=TFRwave_ind.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_ind.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_',bin{b},'_tfr_avblc_ind.mat')
        save(outfile,'TFRwave_ind');
        
        clear TFdata TFRwave_ind baseline outfile
    end

end

clear avgbase_sepch





