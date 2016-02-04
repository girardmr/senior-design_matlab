num_time_steps_a = length(audio_recording);
num_time_steps_m = length(mp4);

timea=((10/num_time_steps_a):(10/num_time_steps_a):10);
timem=((10/num_time_steps_m):(10/num_time_steps_m):10);
audio_recording_1=audio_recording(:,1);
% mp4_1=mp4(:,1);
plot(timea',audio_recording_1,'r-')
hold 
%plot(timem',mp4_1,'g-')
%hold 
audio_recording_2=audio_recording(:,2);
%mp4_2=mp4(:,2);
figure;
plot(timea',audio_recording_2,'c-')
% hold 
% plot(timem',mp4_2,'g:')
% hold off

%To do:

%figure out what the first and second colums are in the double
%determine how to get the audio input to have two outputs
%save and play metronome
%determine average phase lag
%test the lag with headphones