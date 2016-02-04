%record audio
recObj = audiorecorder(48000, 16, 1)
recordblocking(recObj, 4);
disp('End of Recording.');
y = getaudiodata(recObj);
%envelope
z = hilbert(y);
env = abs(z);
%created time vector associated with envelope
step = 4/numel(env);
t = [0:step:4-step];
%plot envelope of speech recording
figure;
plot(t,env,'r');
title('Envelope of raw data')

%peak values and their locations
[pks, loc] = findpeaks(env);
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
while counter < (4/0.1+1)
%only look at 0.1 seconds of data at a time
for ii = 2:length(time_loc)
    if time_loc(ii) >= n && time_loc(ii) <= n+0.1
        %find max peak in the 0.1 second piece of data
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
n = n+0.1;
counter = counter+1;
end

figure;
plot(time_max_peak,max_pks,'m');
title('Max peak in every 0.1 seconds of findpeaks') 