% IMPORT  SEGMENTS into fieldtrip format 
% (bigger epoch window)
% read in mat file with average data (already preprocessed in Netstation)
% mod. by rlg 22 May 2012

clear all;clc
tic
%% define subjects
S{1}='W725'; % the campers run last year had the funky category name problem, but all Controls and campers run  in late 2011 or 2012 donm't have this.

load hdrtemplate_w7CDT_125.mat %this header template does not contain sampling rate
%channel labels for adult net (all channels) average ref, tmin (-500ms) and tmax (+1198ms) for the segments
%time in seconds now 

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

%sampling rate is already included in the .mat files 
% or use unique function to detect names automatically?

    
for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,subj,'_CDT.word.tagseg.ref.mat') % ref files contain single trials (only good segments post-AD) 

    sujdata=load(matfilename);
    samplingrate = sujdata.samplingRate;
    timepoints      = [tmin:(1/samplingrate):tmax]; %had to change this line b/c time is in seconds now

    %% this loop does each condition
    
    for b=1:length(bin)
        data= [];    
        data.label      = egi_chanlabels; %contains all electrodes - have to take out the ones I don't want later!
        data.fsample    = samplingrate;
        for i=1:size(sujdata.(bin{b}),3); %iterates for correct number of trials
            data.trial{i} = sujdata.(bin{b})(:,:,i);
            data.time{i}  = timepoints;
        end
        outfile= cat(2,'CDTword_',subj,'_',bin{b},'_trials.mat')
        save(outfile,'data');
        clear data outfile
        
    end
    clear sujdata matfilename
end

toc
