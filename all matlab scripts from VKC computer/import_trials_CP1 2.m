% IMPORT  SEGMENTS into fieldtrip format for CP
% experiment  -
% read in mat file with trial data (already preprocessed in Netstation)
% mod. by rlg 18 july 2011

clear all;clc
tic
%% define subjects - CP1 pre and post
S{1}='01_pre'; S{2}='02_pre'; S{3}='03_pre'; S{4}='04_pre'; S{5}='05_pre';
S{6}='06_pre'; S{7}='07_pre'; S{8}='08_pre'; S{9}='09_pre'; S{10}='10_pre';

S{11}='01_post'; S{12}='02_post'; S{13}='03_post';  S{14}='04_post'; S{15}='05_post';
S{16}='06_post'; S{17}='07_post'; S{18}='08_post';  S{19}='09_post';

load hdrtemplate_CP_111.mat %this header template contains sampling rate
%channel labels for adult net (no outer) average ref, tmin (-500) and tmax (+1198ms) for the segments
%time in seconds now

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='ba';
bin{2}='pa';
bin{3}='ga';


%sampling rate is already included in the .mat files
% or use unique function to detect names automatically?


for m=1:length(S)
    subj=S{m};
    matfilename=cat(2,'CP',subj,'_snd.seg.ref.mat') % ref files contain single trials (only good segments post-AD)
    
    sujdata=load(matfilename);
    samplingrate = sujdata.samplingRate;
    timepoints      = [tmin:(1/samplingrate):tmax]; %had to change this line b/c time is in seconds now
    
    %% this loop does each condition
    trialdata = {}; % put three bins together
    
    for b=1:length(bin) % syllables
        data= [];
        data.label      = egi_chanlabels; %contains all electrodes - have to take out the ones I don't want later!
        data.fsample    = samplingrate;
        for i=1:size(sujdata.(bin{b}),3); %iterates for correct number of trials
            data.trial{i} = sujdata.(bin{b})(:,:,i);
            data.time{i}  = timepoints;
        end
        %outfile= cat(2,'CP',subj,'_',bin{b},'_trials.mat')
        %save(outfile,'data');
        trialdata.oldbin{b} = data;
        clear data outfile
        
    end
    data = {};
    cfg =[];
    data = ft_appenddata(cfg, trialdata.oldbin{1}, trialdata.oldbin{2}, trialdata.oldbin{3});
    outfile= cat(2,'CP',subj,'_snd_trials.mat')
    save(outfile,'data');
    
    
    clear trialdata data sujdata matfilename
end

toc
