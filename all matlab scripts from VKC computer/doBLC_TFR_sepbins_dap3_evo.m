% clear all; clc
% try fieldtrip's baseline correction 
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regular';
bin{2}='irregular';
% load file  containing baselines for each subject in each frequency band
% (separate for each channels) - baseline is (induced) power during average
% of all conditions (all bins)


for m=1:length(S) %for each subject
    suj=S{m};

    for b=1:length(bin) %for each condition %%IMPORTANT: ONLY FIRST 3 BINS

        filename= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        load(filename)
        TFdata=TFRwave_evo;
        clear TFRwave_evo
        
        cfg = [];
        cfg.baseline = [-0.150 0.350];
        cfg.baselinetype = 'relchange';
        cfg.param = 'powspctrm';
        
        TFRwave_evo = ft_freqbaseline(cfg,TFdata)
        
       
        outfile= cat(2,suj,'_',bin{b},'_tfr_spblc_evo.mat')
        save(outfile,'TFRwave_evo');
        
        clear TFdata TFRwave_evo baseline outfile data
    end

end







