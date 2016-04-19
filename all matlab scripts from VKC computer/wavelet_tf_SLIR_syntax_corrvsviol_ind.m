%  %% NEEDS REVISION
%calculate power with wavelets on trial data (induced) tutorial data
%took about 2 minutes to complete for all 6 subjects
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
        filename= cat(2,suj,'_',bin{b},'_trials.mat') % these contain trial data
        load(filename)
        
        SampRate = data.fsample %finds the sampling rate of this dataset and finds timestep for analysis
        timestep = 1/SampRate
        
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'wavelet';
        cfg.width   =  5; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 8:1:50; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.500:timestep:0.900;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data);
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_ind.mat')
        save(outfile,'TFRwave_ind');
        clear data outfile TFRwave_ind
    end
    clear filename
end

toc

