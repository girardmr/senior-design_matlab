% baseline correction (power) relativechange  from avg power.
% this one uses separate baseline per channel
% modified rlg 13 october 2010

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; S{17} = 'W725';
S{18}='W824'; S{19}='W825'; S{20}='W826'; S{21}='W827'; S{22}='W828'; 
S{23}='W829'; S{24}='W830';
%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is  power during average
% of all conditions (all bins)

%% auditory bins - primes
load CDT_campers_WordBins_avg_base_ind.mat;

for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:length(bin) %for each condition 

        filename= cat(2,suj,'_CDT_',bin{b},'_tfr_ind.mat')
        load(filename)

        TFdata=TFRwave_ind.powspctrm;
        baseline= avgbase_sepch{m};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_ind.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,suj,'_CDT_',bin{b},'_tfr_avblc_ind.mat')
        save(outfile,'TFRwave_ind');
        
        clear TFdata TFRwave_ind baseline outfile
    end

end

clear avgbase_sepch





