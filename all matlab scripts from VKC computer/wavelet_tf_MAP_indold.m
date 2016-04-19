%TUTORIAL SCRIPT
%calculate power with wavelets on trial data (induced) tutorial data
%took about 2 minutes to complete for all 6 subjects
%rlg 13 october 2010

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}='HM_hapface';
bin{5}='SM_hapface';
bin{6}='NS_hapface';
bin{7}='HM_sadface';
bin{8}='SM_sadface';
bin{9}='NS_sadface';

%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'MAP_',suj,'_',bin{b},'_trials.mat')
        load(filename)
        
        timestep = 1/data.fsample; %finds the sampling rate of this dataset and finds timestep for analysis
        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        %low-pass filter here
        %data_lp = ft_preproc_lowpassfilter(data, data.fsample, 55); % apply low-pass filter - 55Hz
         cfg = [];
        cfg.lpfilter      = 'yes'; % lowpass filter
        cfg.lpfreq        = 55;
        data_lp = ft_preprocessing(cfg,data);
        
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:50; %frequencies of interest - theta, alpha, and beta
        cfg.toi     = -0.400:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data_lp);
        
        outfile= cat(2,suj,'_MAP_',bin{b},'_tfr_ind.mat')
        save(outfile,'TFRwave_ind');
        clear data data_lp outfile TFRwave_ind
    end
    clear filename
end

toc

