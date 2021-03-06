%TUTORIAL SCRIPT
%calculate power with wavelets on trial data (induced) tutorial data
%took about 2 minutes to complete for all 6 subjects
%rlg 13 october 2010

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';

%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'chords_tut_subj',suj,'_',bin{b},'_trials.mat') % these contain trial data
        load(filename)
        
        timestep = 1/data.fsample; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'wltconvol';
        cfg.width   =  5; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:25; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.400:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data);
        
        outfile= cat(2,'chords_tut_subj',suj,'_',bin{b},'_tfr_ind.mat')
        save(outfile,'TFRwave_ind');
        clear data outfile TFRwave_ind
    end
    clear filename
end

toc

