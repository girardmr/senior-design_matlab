close all;
clear all;
clc;

%record audio
samplingrate = 44100;
recObj = audiorecorder(samplingrate, 16, 1);
rec_time = 5; 
disp('Begin Speaking.');
recordblocking(recObj, rec_time);
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
step = rec_time/numel(y3);
t = [0:step:rec_time-step];

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

%create interpolated matrices
max_pks_step = rec_time/length(max_pks);
max_pks_t = [max_pks_step:max_pks_step:rec_time];
interp_step = 0.001;
time_interp = [0:interp_step:rec_time];
interp_data = interp1(max_pks_t,max_pks,time_interp);
% for rr = 1:length(speech_loc)
%     for qq = 1:length(interp_data)
%         if interp_data(qq) == speech_loc(rr);
%             speech_loc_interp(rr) = qq;
%         end
%     end
% end
speech_loc_interp = round(speech_loc*(length(interp_data)/length(max_pks)));
sp_loc_interp_t = speech_loc_interp*interp_step;

%locate indices of points 60% up waveform
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
%convert indices to time
%index*step = time
for mm = 1:length(ind_60)
    t_60(mm) = ind_60(mm)*interp_step;
end
%find amplitude corresponding to 60% time points
for nn = 1:length(ind_60)
    for pp = 1:length(interp_data)
        if ind_60(nn) == pp;
            amp_60(nn) = interp_data(pp);
        end
    end
end
%visualize 60% points
hold on;
plot(t_60,amp_60,'x');
plot(sp_loc_interp_t,speech_pk,'g*');

    
         