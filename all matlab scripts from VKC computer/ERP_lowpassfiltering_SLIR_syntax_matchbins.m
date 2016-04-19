clear all, clc
tic
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104';

bin{1}='both_corr';
bin{2}='both_viol';



for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        filename=cat(2,suj,'_',bin{b},'_trials.mat')    
        load(filename);
   
        cfg = [];
        cfg.lpfilter = 'yes'
        cfg.lpfreq = 20;
        data_ERP = ft_preprocessing(cfg,data)
  
        cfg = [];
        cfg.removemean = 'no';
        data_ERP = ft_timelockanalysis(cfg, data);
        outfile_4evo2 = cat(2,suj,'_',bin{b},'_lpf_ERP.mat')
        save (outfile_4evo2,'data_ERP');
       
        load(filename);  
        
        cfg = [];
        cfg.removemean = 'no';
        data_ERP = ft_timelockanalysis(cfg, data);
          
        cfg = [];
        cfg.method='wavelet';
        cfg.width   =  5;
        cfg.output  = 'pow';
        cfg.foi     = 8:1:50;
        cfg.toi     = -0.100:0.900; %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no';

        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP outfile TFRwave_evo
    end
    clear filename
end

toc