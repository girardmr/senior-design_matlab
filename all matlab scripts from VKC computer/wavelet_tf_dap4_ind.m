% dynatt pilot data
%calculate power with wavelets on trial data (induced)  data
%took about 7 min. for 4 subjects
%rlg 9 feb 2012

clear all; clc
tic %calculate time it takes for script to run, "toc" on final line

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
%S{1}='dap3_01'; S{2}='dap3_02'; S{3}='dap3_03'; S{4}='dap3_04';
S{1}='dap4_02'; % just CLM-G, dap4

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='regular';
bin{2}='irregular';

%% calculate wavelet power

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_',bin{b},'_trials.mat')
        load(filename)
        
        SampRate = data.fsample %finds the sampling rate of this dataset and finds timestep for analysis
        timestep = 1/SampRate

        % you can increase computation speed by increasing the numerator of this
        % equation, but that will affect the temporal resolution amd your graphical
        % output will be less smooth
        
        %low-pass filter here (this data is already LPfiltered)
        %data_lp = ft_preproc_lowpassfilter(data, data.fsample, 55); % apply low-pass filter - 55Hz
%          cfg = [];
%         cfg.lpfilter      = 'yes'; % lowpass filter
%         cfg.lpfreq        = 55;
%         data_lp = ft_preprocessing(cfg,data);
        
        cfg = [];
        %        cfg.channel= ;
        cfg.method  = 'wavelet';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:75; %frequencies of interest - try step of 2Hz here
        cfg.toi     = -0.150:timestep:0.800;    %time of interest CAREFUL - time in seconds, 4ms
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data); % use data_lp if we did low-pass fileter
        
        outfile= cat(2,suj,'_',bin{b},'_tfr_ind.mat') 
        save(outfile,'TFRwave_ind');
        clear data data_lp outfile TFRwave_ind
    end
    clear filename
end

toc

