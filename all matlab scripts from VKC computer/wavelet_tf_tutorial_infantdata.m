%TUTORIAL SCRIPT
%calculate power with wavelets on trial data (induced) infant faces study
%took about ? minutes to complete for all 16 subjects
%rlg 30 sept 2010


clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='01';  
%S{2}='02';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='neutral';
bin{2}='small_smile';
bin{3}='big_smile';

%% load sopro_ERP_channels.mat % USE CUSTOM LAYOUT HERE??
%this worked to select just the channels I want... leaves out Cz, occipitals, and mastoids!
%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m}; 
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'Tutorial',suj,'_',bin{b},'_trials.mat') % these contain grandaverages
        load(filename)
        cfg = [];
%        cfg.channel= sopro_ERP_channels;
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:80; %frequencies of interest
        cfg.toi     = -0.200:0.004:0.800;    %time of interest (whole segment) CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data);

        outfile= cat(2,'Tutorial',suj,'_',bin{b},'_tfr_ind.mat')
        save(outfile,'TFRwave_ind');
        clear data outfile TFRwave_ind
    end
    clear filename
end

toc

