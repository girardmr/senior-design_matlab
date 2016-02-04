%Gordon lab Praat values
smoothing_factor = 25;
low = 500;
high = 2500; %low and high data values?

datapath = 'C:\Users\Madeline\Documents\fall 2015\senior design\senior design_matlab\data';
cd(datapath);

%list the audio files in the folder
%dir **.mp4 lists all mp4 files in the folder.
listing = dir('**.mp4'); %struct -- each file and its info
filecount = numel(listing);
for ii = 1:filecount;
    filename = listing(ii).name;
    [recorded, Fs] = audioread(filename);
    figure;
    plot(recorded);
end

%produce metronome track based on childrens spoken track
%load audio
[recorded_audio, Fs_audio] = audioread('recording_saved.mp4');


