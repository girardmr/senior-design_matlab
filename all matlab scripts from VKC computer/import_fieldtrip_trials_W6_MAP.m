% IMPORT  SEGMENTS into fieldtrip format for Vanderbilt Tutorial
% (bigger epoch window)
% read in mat file with average data (already preprocessed in Netstation)
% mod. by rlg 28 september 2010 ; redid with newly refed data 11 oct 2011
% b/c old data (only campers) had eye channels incl in reref

clear all;clc
tic
%% define subjects
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

load hdrtemplate_w6MAP_125.mat %this header template contains sampling rate
%channel labels for adult net (all channels) average ref, tmin (-800ms) and tmax (+1196ms) for the segments
%time in seconds now 

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}='HM_hapface';
bin{5}='SM_hapface';
bin{6}='NS_hapface';
bin{7}='HM_sadface';
bin{8}='SM_sadface';
bin{9}='NS_sadface';

%sampling rate is already included in the .mat files 
% or use unique function to detect names automatically?

    
for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,subj,'_music.seg.ref.mat') % ref files contain single trials (only good segments post-AD) 

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
        outfile= cat(2,'MAP_',subj,'_',bin{b},'_trials.mat')
        save(outfile,'data');
        clear data outfile
        
    end
    clear sujdata matfilename
end

toc
