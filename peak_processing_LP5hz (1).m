%record audio
samplingrate = 44100;
recObj = audiorecorder(44100, 16, 1)
recordblocking(recObj, 4);
disp('End of Recording.');
y = getaudiodata(recObj);
%envelope
z = hilbert(y);
env = abs(z);
nyquist = samplingrate/2; 
cutlp2 = 5; %Sets 5 Hz cutoff frequency
Wn3 = cutlp2/nyquist; %normalizes cutoff to work with butter func.
[a3,b3] = butter(1,Wn3); %produces transfer coefficients for 5 Hz lowpass
y3 = filter(a3,b3,env); %filters data labeled 'env'

%created time vector associated with envelope
step = 4/numel(y3);
t = [0:step:4-step];
%plot envelope of speech recording
figure;
plot(t,env,'r');
title('Envelope of raw data')

%peak values and their locations
[pks, loc] = findpeaks(y3);
%create time vector associated with located peaks
time_loc = zeros(length(loc),1);
for jj = 1:length(loc)
    time_loc(jj) = loc(jj)*step-step;
end
%plot peaks against time
figure;
plot(time_loc, pks);
title('Plot of peaks located by findpeaks');

n = 0;
pk_ind = 1;
temp_max_peak = 0;
counter = 1;
t_division = 0.05;
while counter < (4/t_division+1)
%only look at t_division (0.05 seconds) of data at a time
for ii = 2:length(time_loc)
    if time_loc(ii) >= n && time_loc(ii) <= n+t_division
        %find max peak in the 0.05 second piece of data
        if pks(ii) > temp_max_peak
            temp_max_peak = pks(ii); 
            temp_time = time_loc(ii);
        end
    end
end
max_pks(pk_ind) = temp_max_peak;
time_max_peak(pk_ind) = temp_time;
pk_ind = pk_ind+1;
temp_max_peak = 0;
n = n+t_division;
counter = counter+1;
end

figure;
plot(time_max_peak,max_pks,'m');
title('Max peak in every 0.05 seconds of findpeaks')

%Locate speech peaks
pk_threshold = 0.1*(max(max_pks)-min(max_pks)); %arbitrary but to be fiddled with
%pk_threshold = mean(max_pks);
[speech_pk speech_loc w] = findpeaks(max_pks, 'MinPeakHeight', pk_threshold, 'MinPeakDistance', 0.5);
time_speech_loc = zeros(1,length(speech_loc),1);
for m = 1:length(speech_loc)
    time_speech_loc(m) = time_max_peak(speech_loc(m));
end
hold on;
plot(time_speech_loc,speech_pk,'x')