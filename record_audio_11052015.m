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
audiowrite('recording_saved.mp4',recording, 48000);

%read a saved file
[recorded, Fs] = audioread('recording_saved.mp4');
figure;
plot(recorded);

