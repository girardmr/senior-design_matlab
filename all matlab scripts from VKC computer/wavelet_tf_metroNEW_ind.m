%calculate power with wavelets on trial data (INDUCED) - Metronome beats
%took 130 min  to complete for all 16 subjects
%rlg october 18, 2010

tic
clear all; clc
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

bin{1} = 'metrobeats';
bin{2} = 'offbeats';

%% calculate average power for metronome beats, to be used later as baseline for syllables

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,'suj',suj,'_',bin{b},'.mat')
        load(filename)
        cfg = [];
        cfg.channel = {'all', '-E29', '-E47'};
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:80; %frequencies of interest
        cfg.toi     = -0.750:0.002:0.748;    %time of interest (whole segment) CAREFUL - time in seconds!
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        TFRwave_ind = ft_freqanalysis(cfg, data);

        outfile= cat(2,'suj',suj,'_',bin{b},'_tfr_ind.mat')
        save(outfile,'TFRwave_ind');
        clear filename data outfile TFRwave_ind
    end
    clear filename
end

toc