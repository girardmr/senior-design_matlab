% IMPORT  SEGMENTS into fieldtrip format Sasha, combine files into new bins
% read in mat file with average data (already preprocessed in Netstation)
% mod. by rlg 3 feb 2011

clear all;clc
tic
%% define subjects
load inputfiles.mat % contains names of the files; I made this by:
% filenames = what('datafiles');
% inputfiles = filenames.mat; % and saving output

for m=1:length(inputfiles);
    S{m} = inputfiles{m}(1:end-4); %
end
clear m
% so S contains subject codes

load hdrtemplate_preterm.mat %this header template contains sampling rate
%channel labels for infant net (all channels) average ref, tmin (-100) and tmax (+896ms) for the segments
%time in seconds now

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='ba';
bin{2}='bu';
bin{3}='da';
bin{4}='du';
bin{5}='ga';
bin{6}='gu';

newbin{1} = 'B'; % old 1 +2
newbin{2} = 'D'; % old 3+4
newbin{3} = 'G'; % old 5+6
newbin{4} = 'A'; % old 1 + 3+ 5
newbin{5} = 'U'; % old 2 + 4 +6

%sampling rate is NOT already included in the .mat files


for m=1:length(S)
    subj=S{m};
    matfilename = inputfiles{m} % ref files contain single trials (only good segments post-AD)
    
    sujdata=load(matfilename);
    samplingrate = 250;
    timepoints      = [tmin:(1/samplingrate):tmax]; %had to change this line b/c time is in seconds now
    
    %% this loop does each condition
    ft_oldavg = [];        newavg = [];
    
    for b=1:length(bin)
        data= [];
        data.label      = egi_chanlabels; %contains all electrodes - have to take out the ones I don't want later!
        data.fsample    = samplingrate;
        for i=1:size(sujdata.(bin{b}),3); %iterates for correct number of trials
            data.trial{i} = sujdata.(bin{b})(:,:,i);
            data.time{i}  = timepoints;
        end
        cfg = [];
        cfg.covariance         = 'no';
        ft_oldavg.(bin{b}) = ft_timelockanalysis(cfg,data); % makes fieldtrip happy 
        clear data
        
        %         outfile= cat(2,'chords_tut_subj',subj,'_',bin{b},'_trials.mat')
        %         save(outfile,'data');
        %         clear data outfile
        %
    end
    % now here average together two conditions
    cfg = [];
    cfg.keepindividual = 'no';
    newavg.(newbin{1}) = ft_timelockgrandaverage(cfg,ft_oldavg.(bin{1}), ft_oldavg.(bin{2})); %
    newavg.(newbin{2}) = ft_timelockgrandaverage(cfg,ft_oldavg.(bin{3}), ft_oldavg.(bin{4})); %
    newavg.(newbin{3}) = ft_timelockgrandaverage(cfg,ft_oldavg.(bin{5}), ft_oldavg.(bin{6})); %
    newavg.(newbin{4}) = ft_timelockgrandaverage(cfg,ft_oldavg.(bin{1}), ft_oldavg.(bin{3}), ft_oldavg.(bin{5}));
    newavg.(newbin{5}) = ft_timelockgrandaverage(cfg,ft_oldavg.(bin{2}), ft_oldavg.(bin{4}), ft_oldavg.(bin{6}));
    
    
    % then write each of the new conditions to txt files and matlab- use dlmwrite
    for n = 1:length (newbin)
        newdata = (newavg.(newbin{n}).avg)';% transposes it because cartools wants timepoints in rows, channels in cols
        
        outfile = cat(2, subj,'_',newbin{n},'.txt') % transposes it to be used 
        dlmwrite(outfile, newdata, 'delimiter','\t','precision',6)
        clear outfile newdata
    end
    
    clear sujdata matfilename
end

toc
