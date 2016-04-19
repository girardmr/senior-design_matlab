% plot textsetting data
clear all; clc

% TO DO LIST FOR PLOTTING: ADD LEGENDS, USE CIRCLES INSTEAD OF LINES

load pilotsongs_anlys.mat

song = fieldnames(pilot);
numSongs = length(song);

figure
%plot duration - nPVI results
for s= 1:numSongs
    % need to plot 2 diff y-axes
    subplot(numSongs,1,s)
    
    Y1 = pilot.(song{s}).spkdur;
    X = 1:1:length(Y1)
    Y2 = pilot.(song{s}).notdur;
    
   % http://www.mathworks.com/help/techdoc/ref/plotyy.html
    [AX,H1,H2] = plotyy(X,Y1,X,Y2, 'plot');
    xlabel('syllable-note pairs')
    set(get(AX(1),'Ylabel'),'String','Rime duration - seconds')
    set(get(AX(2),'Ylabel'),'String','Music Notated duration - beats')
        set(H1,'LineStyle','--')
        set(H2,'LineStyle',':')
      
    title (cat(2,'Durations -',song{s}))
    clear X Y1 Y2 AX H1 H2
end
saveas(gcf, 'Rawdur_pilotsongs', 'fig');

figure
%plot duration - nPVI results
for s= 1:numSongs
    % nope, plot on same yaxis
    subplot(numSongs,1,s)
    
    Y1 = pilot.(song{s}).pvispkdur;
    X = 1:1:length(Y1)
    Y2 = pilot.(song{s}).pvimusdur;
    
   % http://www.mathworks.com/help/techdoc/ref/plotyy.html
    plot(X,Y1,'--',X,Y2,':');
    xlabel('syllable-note pairs')
    ylabel('nPVI')
%     set(get(AX(1),'Ylabel'),'String','nPVI - Rime duration')
%     set(get(AX(2),'Ylabel'),'String','nPVI - Music Notated duration')
%         set(H1,'LineStyle','--')
%         set(H2,'LineStyle',':')
      %now need legend
    legend('Spoken Rimes', 'Music Notated') 
    title (cat(2,'nPVI on durations -',song{s}))
    clear X Y1 Y2 AX H1 H2
end

saveas(gcf, 'nPVI_pilotsongs', 'fig');

%% plot pitch results
figure
for s = 1:numSongs
    
    subplot(numSongs,1,s)
    % need to plot 2 diff y-axes
    
    Y1 = pilot.(song{s}).spkpit;
    X = 1:1:length(Y1);
    Y2 = pilot.(song{s}).notpitHz;
    
    [AX,H1,H2] = plotyy(X,Y1,X,Y2, 'plot');
    
    title (cat(2,'Pitches -',song{s}))
    
    xlabel('syllable-note pairs')
    
    
    set(get(AX(1),'Ylabel'),'String','Pitch(Hz)- Spoken')
    set(get(AX(2),'Ylabel'),'String','Pitch(Hz) - notated Musical')
        set(H1,'LineStyle','--')
        set(H2,'LineStyle',':')
    
    
    title (cat(2,'Pitch -',song{s}))
    
    clear X Y1 Y2 AX H1 H2
    
end

saveas(gcf, 'Pitch_pilotsongs', 'fig');



%% plot pitch results
figure
for s = 1:numSongs
    
    subplot(numSongs,1,s)
    % need to plot 2 diff y-axes
    
    Y1 = pilot.(song{s}).spkpit;
    X = 1:1:length(Y1);
    Y2 = pilot.(song{s}).notpit;
    
    [AX,H1,H2] = plotyy(X,Y1,X,Y2, 'plot');
    
    title (cat(2,'Pitches - Midi and Hz',song{s}))
    
    xlabel('syllable-note pairs')
    
    
    set(get(AX(1),'Ylabel'),'String','Pitch(Hz)- Spoken')
    set(get(AX(2),'Ylabel'),'String','Pitch(midicodes) - notated Musical')
        set(H1,'LineStyle','--')
        set(H2,'LineStyle',':')
    
    
    title (cat(2,'Pitch -',song{s}))
    
    clear X Y1 Y2 AX H1 H2
    
end

saveas(gcf, 'PitchMidiHz_pilotsongs', 'fig');
