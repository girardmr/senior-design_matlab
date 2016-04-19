%calculate power with wavelets on ERP data (EVOKED) - new long syllables
%took about 1 min. to complete for all 16 subjects
%rlg 27 jan 2011

tic
clear all; clc
%% define subjects
S{1}='02';  S{2}='03';  S{3}='04';
S{4}='05';  S{5}='06';  S{6}='07';
S{7}='08';  S{8}='09';  S{9}='10';
S{10}='13'; S{11}='14'; S{12}='15';
S{13}='17'; S{14}='18'; S{15}='19';
S{16}='20';

%% define conditions
bin{1}='Strong_Strong';
bin{2}='Weak_Strong';
bin{3}='Strong_Weak';
bin{4}='Weak_Weak';

%% calculate average power for bisyllabic nouns

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
         filename= cat(2,'suj',suj,'_',bin{b},'L_erp.mat')
        load(filename)
        cfg = [];
        cfg.channel = {'all', '-E29', '-E47'};
        cfg.method  = 'wltconvol';
        cfg.width   =  6; %Qwid;%this can be a vector if you want to do classical-Q
        cfg.output  = 'pow';
        cfg.foi     = 4:1:80; %frequencies of interest
        cfg.toi     = -0.250:0.002:0.500;    %time of interest (not whole segment) CAREFUL - time in seconds!
        cfg.keeptrials = 'no'; %return individual trials or average (default = 'no')
        
        TFRwave_evo = ft_freqanalysis(cfg, data);

        outfile= cat(2,'suj',suj,'_',bin{b},'_L_tfr_evo.mat')
        save(outfile,'TFRwave_evo');
        clear data outfile TFRwave_evo
    end
    clear filename
end

toc