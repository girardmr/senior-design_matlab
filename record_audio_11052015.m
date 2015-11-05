recObj = audiorecorder(4800,16,1);
disp('End of Recording');
y= getaudiodata(recObj);
plot(y);