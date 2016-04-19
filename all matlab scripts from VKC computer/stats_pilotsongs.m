% analyze textsetting data
clear all; clc

%musical analysis
 
load pilotsongs_anlys.mat

song = fieldnames(pilot);
numSongs = length(song); 
data = {};
%calc corr on duration - nPVI results
for s= 1:numSongs
    
    
    Y1 = pilot.(song{s}).pvispkdur;
    X = 1:1:length(Y1)
    Y2 = pilot.(song{s}).pvimusdur;
    data.(song{s}).npvi = [Y1 Y2];
    [r,p] = corrcoef(data.(song{s}).npvi)
    data.(song{s}).npvicorr = [r(1,2) p(1,2)];

    clear X Y1 Y2 r p
    
    
end

%calc corr on raw duration results
for s= 1:numSongs
    
    
    Y1 = pilot.(song{s}).spkdur;
    X = 1:1:length(Y1)
    Y2 = pilot.(song{s}).notdur;
    data.(song{s}).rawdur = [Y1 Y2];
    [r,p] = corrcoef(data.(song{s}).rawdur )
    data.(song{s}).rawdurcorr = [r(1,2) p(1,2)];

    clear X Y1 Y2 r p
    
    
end
% PROBLEM BECAUSE MIDICODES ARE INTEGERS AND PITCH IN HZ IS NOT??

%%  pitch - all in HZ
for s = 1:numSongs
    
    
    Y1 = pilot.(song{s}).spkpit;
    X = 1:1:length(Y1);

    
    Y2 = pilot.(song{s}).notpitHz;
    
    data.(song{s}).pitchHz = [Y1 Y2];
    
    [r,p] = corrcoef(data.(song{s}).pitchHz);
    data.(song{s}).pitchHzcorr = [r(1,2) p(1,2)]
    
    clear X Y1 Y2 pit pitHz r p
    
     
end

%%  pitch in Midicodes and Hz
for s = 1:numSongs
    
    
    Y1 = pilot.(song{s}).spkpit;
    X = 1:1:length(Y1);

    
    Y2 = double(pilot.(song{s}).notpit);
    
    data.(song{s}).pitchHM = [Y1 Y2];
    
    [r,p] = corrcoef(data.(song{s}).pitchHM);
    data.(song{s}).pitchHMcorr = [r(1,2) p(1,2)]

    clear X Y1 Y2 pit pitHM r p
    
     
end
% summarize results


results = {};

%fid = fopen('pilotsongs_results.txt','w');
%fprintf(fid, 'Rawdur nPVI %s %s %s %s %s \n', results{s,:});
for s= 1:numSongs
    
    results{s,1} = song{s};
    results{s,2} = data.(song{s}).rawdurcorr(1); %r
    results{s,3} = data.(song{s}).rawdurcorr(2); %p
    results{s,4} = data.(song{s}).npvicorr(1);
    results{s,5} = data.(song{s}).npvicorr(2);
    results{s,6} = data.(song{s}).pitchHzcorr(1);
    results{s,7} = data.(song{s}).pitchHzcorr(2);
    results{s,8} = data.(song{s}).pitchHMcorr(1);
    results{s,9} = data.(song{s}).pitchHMcorr(2);

    %fprintf(fid, '%s %s %s %s %s %s %s \n', results{s,:});
    
end

save results_pilotsongs.mat results
    
    
    
