% IMPORT  SEGMENTS into fieldtrip format for Vanderbilt Tutorial
% bigger epoch window)
% read in mat file with average data (already preprocessed in Netstation)
% mod. by rlg 28 september 2010 

clear all;clc
tic
%% define subjects
S{1}='08';  S{2}='10'; S{3}='11'; S{4}='12';  S{5}='18'; S{6}='20';

load hdrtemplate_tutorial129.mat %this header template contains sampling rate
%channel labels for adult net (all channels) average ref, tmin (-800ms) and tmax (+1200ms) for the syllable segments
%time in seconds now

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';


%sampling rate is already included in the .mat files 

    
for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,'subj',subj,'_session1.seg.ref.mat') % ref files contain single trials (only good segments post-AD) 

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
        outfile= cat(2,'chords_tut_subj',subj,'_',bin{b},'_trials.mat')
        save(outfile,'data');
        clear data outfile
        
    end
    clear sujdata matfilename
end

toc
