% created by rlg, nov 4, 2010
% reads in files prepared in excel - must be windows formatted text
% 4 columns: lyrics, notation, midicodes, beats - for each syllable
clear all; clc

song{1} = 'jhenry'
song{2} = 'fire'
song{3} = 'wind'

pilot = {};

for s = 1:size(song,2)
    
    filename = cat(2,song{s},'.txt')
    
    fid = fopen(filename);
    
    music = textscan(fid, '%s %f32 %d8 %f32', 'HeaderLines',1)
    
    fclose(fid);
    
    pilot.(song{s}).syllables = music{1};
    pilot.(song{s}).notdur = music{4}; % durations in fractions of a beat
    pilot.(song{s}).notpit = music{3}; % pitch in midicode
    
       
    clear music filename fid
    
end

    
    
save pilotsongs_mus.mat pilot