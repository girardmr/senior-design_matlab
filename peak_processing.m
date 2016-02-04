close all;
clear all;
clc;

%record audio
recObj = audiorecorder(48000, 16, 1);
rec_time = 5; 
disp('Begin Speaking.');
recordblocking(recObj, rec_time);
disp('End of Recording.');
y = getaudiodata(recObj);
%envelope
z = hilbert(y);
env = abs(z);
%created time vector associated with envelope
step = rec_time/numel(env);
t = [0:step:rec_time-step];
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

%Smooth signal
n = 0;
pk_ind = 1;
temp_max_peak = 0;
counter = 1;
t_division = 0.05;
while counter < (rec_time/t_division+1)
%only look at t_division (0.05 seconds) of data at a time
for ii = 1:length(time_loc)
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
pk_threshold = 0.25*(max(max_pks)-min(max_pks));
%pk_threshold = mean(max_pks);
[speech_pk speech_loc w] = findpeaks(max_pks, 'MinPeakHeight', pk_threshold, 'MinPeakDistance', 0.25);
time_speech_loc = zeros(1,length(speech_loc),1);
for m = 1:length(speech_loc)
    time_speech_loc(m) = time_max_peak(speech_loc(m));
end
hold on;
plot(time_speech_loc,speech_pk,'x')

interp_step = 0.001;
interp_data = interp1(time_loc,pks,[0:interp_step:rec_time]);
speech_loc_interp = round(speech_loc*(length(interp_data)/length(max_pks)));

for kk = 1:length(speech_pk)
   ind_found = find(interp_data>((0.6*speech_pk(kk))-(0.05*speech_pk(kk))) & interp_data<=((0.6*speech_pk(kk))+(0.05*speech_pk(kk))));
   %if there are only two indices found
   if length(ind_found) == 2
       ind_60(kk) = ind_found(1);
   else %if there are more than two indices found
       for ll = 2:length(ind_found)
           if ind_found(ll) < speech_loc_interp(kk)  
               ind_60(kk) = ind_found(ll);
           end
       end
   end
end
    
    
%     for ll = 1:length(env)   %data set you want to cycle through...the envelope?
%         if env(ll) == 0.6*speech_pk(kk)
%             
