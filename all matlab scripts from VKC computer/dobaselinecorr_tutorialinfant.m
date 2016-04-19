% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 30 sept 2010

clear all; clc
%% define subjects and conditions% CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='01';  
%S{2}='02';

bin{1}='neutral';
bin{2}='small_smile';
bin{3}='big_smile';


% load file (generated by calc_avgbase_step2_tf_Qtarg_ind.m) containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (induced) power during average
% of all targets (all bins)
load TutorialInfant_avg_base_ind.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:length(bin) %for each condition

        filename= cat(2,'Tutorial',suj,'_',bin{b},'_tfr_ind.mat') 
        load(filename)

        TFdata=TFRwave_ind.powspctrm;
        baseline= targavgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_ind.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,'suj',suj,'_',bin{b},'_targ_tfr_avblc_ind.mat')
        save(outfile,'TFRwave_ind');
        
        clear TFdata TFRwave_ind baseline outfile
    end

end







