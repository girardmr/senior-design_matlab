%record audio -- identify microphone
%info = audiodeviceinfo; %info about input/audio devices on system
%nDevices = audiodevinfo(1); %number of input devices
%ID = audiodevinfo(1,4800,16,1); %returns device identifier of firts input device that supports parameters entered.if nothing found, ID=-1
%microphone used by Gordon lab: "USB audio CODEC"
    
clear all; 
clc; 

recObj = audiorecorder(4800,16,1,-1);
disp('Start speaking.');
recordblocking(recObj,5);
disp('End of Recording.');
%play(recObj);
recording = getaudiodata(recObj);
plot(recording,'c');

%save the audio to a file
cd('C:\Users\Madeline\Documents\fall 2015\senior design\senior design_matlab\data');
audiowrite('recording_saved.mp4',recording, 48000);

%read a saved file
[recorded, Fs] = audioread('recording_saved.mp4');
figure;
plot(recorded);



%%second audio file 
recObj_2 = audiorecorder(4800,16,1,-1);
disp('Start speaking.');
recordblocking(recObj_2,5);
disp('End of Recording.');
%play(recObj_2);
recording_2 = getaudiodata(recObj_2);
figure;
plot(recording_2,'m');
%save the audio to a file
cd('C:\Users\Madeline\Documents\fall 2015\senior design\senior design_matlab\data');
audiowrite('recording_saved_2.mp4',recording_2, 48000);
%dulicating to create more files to fill folder...not actually part of
%design
audiowrite('recording_saved_3.mp4',recording_2, 48000);
audiowrite('recording_saved_4.mp4',recording_2, 48000);
audiowrite('recording_saved_5.mp4',recording_2, 48000);