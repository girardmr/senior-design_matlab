% IMPORT  SEGMENTS into fieldtrip format for Vanderbilt Tutorial
% (bigger epoch window)
% read in mat file with average data (already preprocessed in Netstation)
% mod. by rlg 24 aug 2012 
% TO DO: POSSIBLE TO LOAD LAYOUT FILE INTO DATAFILE SO THAT IT ALWAYS HAS A
% LAYOUT?

clear all;clc
tic
%% define subjects
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104'; 
S{5}='SLIR_105';  S{6}='SLIR_106'; S{7}='SLIR_107'; S{8}='SLIR_108';
S{9}='SLIR_109';  S{10}='SLIR_110'; S{11}='SLIR_111'; 

load hdrtemplate_syntax_125.mat %this header template contains sampling rate
%channel labels for adult net (all channels) average ref, tmin (-500ms) and tmax (+1198ms) for the segments
%time in seconds now

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='SVA_corr';
bin{2}='SVA_viol';
bin{3}='TEN_corr';
bin{4}='TEN_viol';

%sampling rate is already included in the .mat files 

    
for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,subj,'_syntax.seg.mref.mat') % ref files contain single trials (only good segments post-AD) 

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
