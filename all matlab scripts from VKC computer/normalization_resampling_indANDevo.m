% generates new baseline corrected (normalized) INDUCED power spectrum data
% (wavelets) for each subject and condition, in which the # of trials in
% the metronome baseline is the same as in the condition that it's
% being used as a baseline for. save intermediate steps. took 16 minutes to run.
% ADAPTED FOR MONOSYLL ONLY
% what to do: for each condition, load metronome beat raw trial data and
% that condition. Equalize number of trials for metronome beats and perform
% new wavelet analysis get new evoked metronome beat for each condition that it's matched in trial #'s to now.
% Do new baseline correction (normalization) on the experimental
% condition induced data with regard to new baseline;%
% BUT SHOULD EVOKED AND INDUCED BE IN SAME SCRIPT SO THAT IT'S THE SAME
% RANDOM DRAW OF METROBEAT TRIALS?
% MOD by rlg 22 june 2010
% took 1 h 15 min

clear all; clc
rand('state',sum(100*clock)); %reset random generator - once or inside loop??

tic
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

%% define conditions
bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';
bin{4}='Weak_Weak';

match{1}='SSreg';
match{2}='WSreg';
match{3}='SWreg';
match{4}='WWreg';

%% big loop!

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin)
        load (cat(2,'suj',suj,'_',bin{b},'_ms4ind.mat')) % monosyll only trial EEG data (just need to know dim of trials)
        cond = data;
        clear data
        
        load (cat(2,'suj',suj,'_all_metrobeats.mat')); % load(filename)
        metro = data; 
        clear data
        
        tri=randperm(size(metro.trial,2)); % random sequence of all of the trials in the metro beats
        n=size(cond.trial,2); % change this to be the number of trials in the baseline that you want to match the condition to
        A=tri(1:n); % takes only the # of trials from metro beats that match the # trials in the cond
        resamp_tri= sort(A);
        
        clear cond tri A
        
        %% EVOKED
        % just use those trials to do new wavelet on metronome clicks by first calculating ERP...
        cfg = [];
        cfg.keeptrials = 'no';

        data_rs_ERP = timelockanalysis(cfg, metro);
        outfile= cat(2,'suj',suj,'_metro_rs_',match{b},'_ms_ERP.mat') % change name to reflect bin that you're matching to
        
        %save the resampled ERP data and clear unnecessary variables        
        save(outfile,'data_rs_ERP');
        
        % do evoked wavelet analysis on resampled metro beats, for each condition

        cfg = [];
        cfg.channel = {'all', '-E29', '-E47'};
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:80; %frequencies of interest
        cfg.toi     = -0.450:0.002:0.448;    %time of interest (whole segment) CAREFUL - time in seconds!
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_evo = freqanalysis(cfg, data_rs_ERP);
        
        outfile= cat(2,'suj',suj,'_metro_evo_rs_',match{b},'_ms.mat') % change name to reflect bin that you're matching to
        save(outfile,'TFRwave_evo');
        clear data_rs_ERP
        
        % caculate mean power for each channel in metro beats, to be used as new baseline
        for j=1:size(TFRwave_evo.powspctrm,2); %loop frequencies
            for k=1:size(TFRwave_evo.powspctrm,1); %loop channels
                %calculate mean power per frequency per channel
                metrobase_sepch.evoked{b}(k,j)       = nan_mean(TFRwave_evo.powspctrm(k,j,:));
                
            end
        end

        clear data outfile TFRwave_evo j k
        
        % to do baseline correction/normalization, load already completed
        % evoked analysis
        filename= cat(2,'suj',suj,'_',bin{b},'_ms_tfr_evo.mat'); % new monosyll analysis
        load(filename)
        
        TFdata = TFRwave_evo.powspctrm;
        baseline = metrobase_sepch.evoked{b};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_evo.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,'suj',suj,'_',bin{b},'_ms_evo_rs_mblc.mat')
        save(outfile,'TFRwave_evo');
        
        clear TFdata TFRwave_evo baseline outfile 

     
        %% INDUCED
        %  do wavelet analysis on resampled metro beats, for each condition

        cfg = [];
        cfg.trials = resamp_tri; % here is where I tell it to only take those trials for wavelet
        cfg.channel = {'all', '-E29', '-E47'};
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:80; %frequencies of interest
        cfg.toi     = -0.450:0.002:0.448;    %time of interest (whole segment) CAREFUL - time in seconds!
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = freqanalysis(cfg, metro);
        
        outfile= cat(2,'suj',suj,'_metro_ind_rs_',match{b},'_ms.mat') % change name to reflect bin that you're matching to
        save(outfile,'TFRwave_ind');
        clear metro
        
        % caculate mean power for each channel in metro beats, to be used as new baseline
        for j=1:size(TFRwave_ind.powspctrm,2); %loop frequencies
            for k=1:size(TFRwave_ind.powspctrm,1); %loop channels
                %calculate mean power per frequency per channel
                metrobase_sepch.induced{b}(k,j)       = nan_mean(TFRwave_ind.powspctrm(k,j,:));
                
            end
        end

        clear metro outfile TFRwave_ind j k
        
        % to do baseline correction/normalization, load already completed
        % induced analysis (raw power)
        filename= cat(2,'suj',suj,'_',bin{b},'_ms_tfr_ind.mat') % new monosyll analysis; raw
        load(filename)
        
        TFdata = TFRwave_ind.powspctrm;
        baseline = metrobase_sepch.induced{b};

        for fr=1:size(TFdata,2) % loop frequencies
            for ch=1:size(TFdata,1) % loop channels
                TFdata(ch,fr,:) = ((TFdata(ch,fr,:) - baseline(ch,fr)) / baseline(ch,fr)); % compute relative change
            end
        end
        
        TFRwave_ind.powspctrm=TFdata; %(replace old powerspectrum with new baseline corrected power)
       
        outfile= cat(2,'suj',suj,'_',bin{b},'_ms_ind_rs_mblc.mat')
        save(outfile,'TFRwave_ind');
        
        clear TFdata TFRwave_ind baseline outfile 
    end
    
    %%save baselines into one file here
    outfile=cat(2,'metrobase_sepch_ms_indANDevo_rs_suj',suj,'.mat')
    save(outfile,'metrobase_sepch') % each cell corresponds to a diff bin, 1 thru 4
    clear outfile metrobase_sepch
    
end

toc



