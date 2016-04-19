% IMPORT  SEGMENTS into fieldtrip format for Vanderbilt Tutorial
% (bigger epoch window)
% read in mat file with average data (already preprocessed in Netstation)
% mod. by rlg 24 aug 2012 
% TO DO: POSSIBLE TO LOAD LAYOUT FILE INTO DATAFILE SO THAT IT ALWAYS HAS A
% LAYOUT?

clear all;clc
tic
%% define subjects
S{1}='HM19'; S{2}='HM32'; S{3}='HM42'; S{4}='HM43'; S{5}='HM47'; S{6}='HM48';
S{7}='HM66'; S{8}='HM90'; % don't use HM62 because too few trials

load hdrtemplate_IWMC_129.mat %this header template contains sampling rate
%channel labels for adult net (all channels) average ref, tmin (0ms) and tmax (+2498ms) for the segments
%time in seconds now
% need to check positions for infant net!!!!!!!!!!!!!!!!!!!!

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='nolook';
bin{2}='look';
bin{3}='correct';

%sampling rate is already included in the .mat files 

    
for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,subj,'_task.seg.ref.mat') % ref files contain single trials (only good segments post-AD) 

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
        outfile= cat(2,subj,'_',bin{b},'_trials.mat')
        save(outfile,'data');
        clear data outfile
        
    end
    clear sujdata matfilename
end

toc
