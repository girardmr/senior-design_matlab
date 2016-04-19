%% OLD DO NOT USE
%calculate power with wavelets on tutorial trial data (evoked) 
%rlg 13 october 2010

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='both_corr';
bin{2}='both_viol';



%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename=cat(2,suj,'_',bin{b},'_trials.mat') %
        load(filename);        
        
                
        SampRate = data.fsample %finds the sampling rate of this dataset and finds timestep for analysis
        timestep = 1/SampRate

        cfg = [];
        % cfg.channel= ; no need to specify chan, it takes all by default

        cfg.removemean  = 'no';
        data_ERP = ft_timelockanalysis(cfg, data); % compute ERP to be saved, and used for evoked
        
        outfile_4evo = cat(2,suj,'_',bin{b},'_ERP.mat')
        save (outfile_4evo,'data_ERP');
        
        clear data
        %% then run wavelet on ERP data
        
 
        cfg = [];
        cfg.method='wavelet';
        cfg.width   =  5; %this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 8:1:50; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.100:timestep:0.900;    %time of interest (whole segment) CAREFUL - time in seconds, 4ms intervals because of 250Hz sampling rate
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')

        TFRwave_evo = ft_freqanalysis(cfg, data_ERP);
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data_ERP outfile TFRwave_evo
    end
    clear filename
end

toc

