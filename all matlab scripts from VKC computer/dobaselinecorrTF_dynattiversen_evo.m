% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 7 May 2012

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101'; S{2} = 'SLIR_102'; S{3}='SLIR_103'; S{4} = 'SLIR_104';% 
S{5}='SLIR_105'; S{6} = 'SLIR_106'; S{7}='SLIR_108'; S{8} = 'SLIR_109';% 
S{9}='SLIR_110'; S{10} = 'SLIR_111'; S{11}='SLIR_112'; S{12} = 'SLIR_113';%

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='PhyAcc1';
bin{2}='PhyAcc2';
% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (evoked) power during average
% of all conditions (all bins)

%% auditory bins - primes
load DynattIversen_avg_base_evo.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:length(bin) %for each condition %%IMPORTANT: ONLY FIRST 3 BINS

        filename= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        load(filename)

        TFdata=TFRwave_evo.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_evo.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_',bin{b},'_tfr_avblc_evo.mat')
        save(outfile,'TFRwave_evo');
        
        clear TFdata TFRwave_evo baseline outfile
    end

end

clear avgbase_sepch





