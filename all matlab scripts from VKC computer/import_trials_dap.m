% IMPORT  SEGMENTS into fieldtrip format for dynatt pilot
% read in mat file with trial data (already preprocessed in Netstation)
% mod. by rlg 26 feb 2011

clear all;clc
tic
%% define subjects
S{1}='dap_01'; 

load hdrtemplate_dap_125.mat %this header template contains sampling rate
%channel labels for adult net (all channels) average ref, tmin (-1250ms) and tmax (+1246ms) for the segments
%time in seconds now 

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='loud_tone';
bin{2}='omit_tone';


%sampling rate is already included in the .mat files 
% or use unique function to detect names automatically?

    
for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,subj,'.ref.mat') % ref files contain single trials (only good segments post-AD) 

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
