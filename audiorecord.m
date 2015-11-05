recObj = audiorecorder(48000, 16, 1)
recordblocking(recObj, 4);
disp('End of Recording.');
y = getaudiodata(recObj);
z = hilbert(y);
env = abs(z);
plot(env,'r','LineWidth',2)