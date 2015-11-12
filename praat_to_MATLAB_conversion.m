%Gordon lab Praat values
smoothing_factor = 25;
low = 500;
high = 2500; %low and high data values?

datapath = 'C:\Users\Madeline\Documents\fall 2015\senior design\senior design_matlab\data';
cd(datapath);

%list the audio files in the folder
%dir **.mp4 %lists all mp4 files in the folder.
%filecount = size(dir)-2; %returns the number of audio files...actually returns the total number of files in folder. so folder can only contain the desired audio files
%%why does it return two extra files??
listing = dir('**.mp4'); %struct -- each file and its info
filecount = numel(listing);




