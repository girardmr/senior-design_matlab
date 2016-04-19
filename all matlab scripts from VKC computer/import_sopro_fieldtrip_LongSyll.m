% IMPORT PRIME SYLLABLE SEGMENTS into fieldtrip format
% read in mat file with trial data (already preprocessed in Netstation)
% created by rlg 1/27/11 (took about 5 minutes to do process all subjects)

clear all;clc
tic
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

load hdrtemplate_longsyllables.mat %this header template contains sampling rate
%channel labels, tmin (-450ms) and tmax (+1048) for the syllable segments
%time in seconds now

%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';
bin{4}='Weak_Weak';
    
for m=1:length(S)
    suj=S{m};
    matfilename=cat(2,'suj',suj,'.LongSyll.ref.mat')

    sujdata=load(matfilename);
    timepoints      = [tmin:(1/samplingrate):tmax]; %had to change this line b/c time is in seconds now

    %% this loop does each condition

    for b=1:length(bin)
        data= [];    
        data.label      = sopro_chanlabels_egi; %my montage excludes occ., 23/55, eyes...
        data.fsample    = samplingrate;
        for i=1:size(sujdata.(bin{b}),3); %iterates for correct number of trials
            data.trial{i} = sujdata.(bin{b})(:,:,i);
            data.time{i}  = timepoints;
        end
        outfile= cat(2,'suj',suj,'_',bin{b},'L.mat')
        save(outfile,'data');
        clear data outfile
        
    end
    clear sujdata matfilename
end

toc
