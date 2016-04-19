% revised 24 aug 2012
% use this script; previous ones were not good.

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_109';  S{2}='SLIR_110'; S{3}='SLIR_111'; S{4}='SLIR_112'; 
S{5}='SLIR_113';  S{6}='SLIR_114'; S{7}='SLIR_115'; S{8}='SLIR_116';
S{9}='SLIR_201';   

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';
bin{5}='both_corr';
bin{6}='both_viol';


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        filename=cat(2,suj,'_',bin{b},'_trials.mat')    
        load(filename);
        % compute ERP for evoked analysis (not filtered)
        cfg = [];
        cfg.removemean = 'no';
        data_4evo = ft_timelockanalysis(cfg, data);
        %outfile_4evo = cat(2,suj,'_',bin{b}, '_ERP.mat')
        
        %Low-pass filter trial data
        cfg = [];
        cfg.lpfilter = 'yes'
        cfg.lpfreq = 20;
        data_trials_fil = ft_preprocessing(cfg,data)
        
        % compute ERP on lpf trial data
        cfg = [];
        cfg.removemean = 'no';
        data_ERP = ft_timelockanalysis(cfg, data_trials_fil);
        outfile_4ERP = cat(2,suj,'_',bin{b},'_lpf_20_ERP.mat')
        save (outfile_4ERP,'data_ERP');
        clear data_trials_fil data_ERP outfile_4ERP
        
        % compute TFR w/wavelet on unfiltered trial data data.
        cfg = [];
        cfg.method='wavelet';
        cfg.width   =  5;
        cfg.output  = 'pow';
        cfg.foilim     = [8 50];
        cfg.toi     = -0.100:0.002:0.900; %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no';

        TFRwave_evo = ft_freqanalysis(cfg, data_4evo);
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_4evo outfile TFRwave_evo outfile_4evo
    end
    clear filename
end
