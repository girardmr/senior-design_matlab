% analyze textsetting data
clear all; clc

load pilotsongs_mus.mat

song = fieldnames(pilot);

%musical analysis

for s = 1:length(song)
    
    musdur = pilot.(song{s}).notdur;  
    
    pvi_musdur = pvi_ts(musdur); % using A.P's nPVI function for time series
    
    pilot.(song{s}).pvimusdur = pvi_musdur'; % store new nPvi time series in pilotsong structure
    
    pit = double(pilot.(song{s}).notpit);
    midi2Hz(pit);
    pitHz = midi2Hz(pit);
    pilot.(song{s}).notpitHz  = pitHz;
    
    clear pvi_musdur musdur pit pitHz
    
end

%load speech analysis for each song
for s = 1: length(song)

    filename = cat(2,song{s},'_spo.txt')
    data = load(filename)

    spkdur = data(:,2); % duration in seconds
    spkpit = data(:,3); % mean pitch in Hz
    pilot.(song{s}).spkdur = spkdur;
    pilot.(song{s}).spkpit = spkpit;

    pvi_spkdur = pvi_ts(spkdur);
    
    pilot.(song{s}).pvispkdur = pvi_spkdur'; 

    clear data spkdur spkpit pvispkdur pvimusdur
    
end

save pilotsongs_anlys.mat pilot
