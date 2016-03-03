close all;
clear all;
clc;

% Collect data

%record audio
samplingrate = 44100;
recObj = audiorecorder(samplingrate, 16, 1);
rec_time = 3; 
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

%% 
%Locate speech peaks

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
title('Plot of peaks located by findpeaks, post filtering');

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
%eliminate the second of two points found on the same peak 
pk_ind = 2;
speech_loc_2(1) = speech_loc(1);
time_speech_loc_2(1) = time_speech_loc(1);
speech_pk_2(1) = speech_pk(1);
for p = 2:length(time_speech_loc)
    time_diff = time_speech_loc(p) - time_speech_loc(p-1);
    if time_diff >= 0.2
        speech_loc_2(pk_ind) = speech_loc(p);
        time_speech_loc_2(pk_ind) = time_speech_loc(p);
        speech_pk_2(pk_ind) = speech_pk(p);
        pk_ind = pk_ind+1;
    end
end
hold on;
plot(time_speech_loc_2,speech_pk_2,'x')

%%

%Locate speech beat

%resample y3  
size_resample = 500;
y3_resample = resample(y3,size_resample,length(y3))';
step_resample = rec_time/size_resample;
time_resample = [0:step_resample:rec_time-step_resample];
speech_loc_resample = round(speech_loc_2*(size_resample/length(max_pks)));
speech_loc_resample_t = speech_loc_resample*step_resample-step_resample;

%locate indices of points 60% up waveform
for kk = 1:length(speech_pk_2)
   ind_found = find(y3_resample>((0.6*speech_pk_2(kk))-(0.15*speech_pk_2(kk))) & y3_resample<=((0.6*speech_pk_2(kk))+(0.15*speech_pk_2(kk))));
   %if there are only two indices found
   if length(ind_found) == 2
       ind_60(kk) = ind_found(1);
   else %if there are more than two indices found
       for ll = 2:length(ind_found)
           if ind_found(ll) < speech_loc_resample(kk) 
               ind_60(kk) = ind_found(ll);
           end
       end
   end
end
%remove indices that equal zero (means code is nonfunctional...)
z = 1;
for zz = 1:length(ind_60)
    if ind_60(zz) ~= 0
        ind_60_new(z) = ind_60(zz);
        z = z+1;
    end
end
%convert indices to time
%find associated amplitude
for mm = 1:length(ind_60_new)
    t_60(mm) = ind_60_new(mm)*step_resample-step_resample;
    amp_60(mm) = y3_resample(ind_60_new(mm));
end
%visualize 60% points
hold on;
plot(t_60,amp_60,'x');

%visualize 60% time points on y3
figure;
plot(t, y3, 'r',t_60,amp_60,'bx');
title('Speech beat location, y3');

%%

%Circular Statistics
%Nuclear Synchrony

%Regroup speech beats by syllable of phrase...only works for 3 syllable
%phrases
syllable1 = t_60(1:3:end);
syllable2 = t_60(2:3:end);
syllable3 = t_60(3:3:end);

%Difference in time between every first syllable
syl1_ind = 1;
for q = 2:length(syllable1)
    diff_syl1(syl1_ind) = syllable1(q)-syllable1(q-1);
    syl1_ind = syl1_ind+1;
end
%Difference in time between first and second syllables and first and third
%syllables.
for r = 1:length(syllable2)
    diff_syl1_syl2(r) = syllable2(r) - syllable1(r);
    diff_syl1_syl3(r) = syllable3(r) - syllable1(r);
end

%???Phase of second (diff_syl1_syl2 divided by diff_syl1) and third syllables (diff_syl1_syl2 divided by diff_syl1)
for ss = 1:length(diff_syl1_syl2)
    phase(ss) = diff_syl1_syl2(ss)/diff_syl1_syl3(ss);
end
%Nuclear Synchrony score = average of phase;
Nuclear_Synchrony = mean(phase);

%Rose plot
figure(5);
subplot(1,3,1);
h1 = rose(phase*2*pi,30);
x1 = get(h1,'Xdata');
y1 = get(h1,'Ydata');
g1 = patch(x1,y1,'b');
title('Nuclear Synchrony')
score_str = sprintf('Nuclear Synchrony Score: %f', Nuclear_Synchrony);
nuclear_text = uicontrol('Style','text','Position',[220 40 200 100],'String',score_str); %Position: [x y length_box height_box?]

%h2 = msgbox(score_str);

%%
%Import Metronome track

[metronome, Fs_m] = audioread('tamborine_90bpm_4-4time_20beats_stereo_LEkFjP.mp3');
env_m = abs(hilbert(metronome));
step_m = 1/Fs_m;
time_met = [1:1:length(metronome)]*step_m;
figure;
plot(time_met,env_m);

%%
%Identify peaks of metronome

[pks_m, loc_m] = findpeaks(env_m,'MinPeakHeight',1.5);

met_ind = 2;
loc_m_2(1) = loc_m(1);
pks_m_2(1) = pks_m(1);
for pp = 2:length(loc_m)
    m_diff = loc_m(pp) - loc_m(pp-1);
    if m_diff > 0.2*10^5
        loc_m_2(met_ind) = loc_m(pp);
        pks_m_2(met_ind) = pks_m(pp);
        met_ind = met_ind+1;
    end
end
time_met_2 = loc_m_2*step_m;
hold on;
plot(time_met_2,pks_m_2,'rx');
title('Metronome Peaks');
figure; 
plot(t_60,0.1,'ro',time_met_2,0.1,'bx'); %red = speech beats, blue = metronome 
title('Metronome beat vs Speech beat');


%%
%Global Synchrony

syl1_first_ind = ind_60_new(1);
syl3_first_ind = ind_60_new(3);

num_phrases = length(syllable1);
met_track_length = 2*num_phrases;
met_track = time_met_2(syl1_first_ind:syl1_first_ind+met_track_length);
met_beat1 = met_track(1:2:end);
met_beat2 = met_track(2:2:end);

cc = 1;
for yy = 1:length(syllable1)
    syl1_metbeat1 = abs(syllable1(yy) - met_beat1(yy));
    syl3_metbeat2 = abs(syllable3(yy) - met_beat2(yy));
    if syl1_metbeat1 < 0.666 && syl3_metbeat2 < 0.666 %0.666 taken from alison's code
        time_dif_beat1(cc) = syl1_metbeat1(yy);
        time_dif_beat2(cc) = syl3_metbeat2(yy);
        cc = cc+1;
    end
end

phase1 = time_dif_beat1./0.666;
phase2 = time_dif_beat2./0.666;
phase_all = vertcat(phase1,phase2);
Global_Synchrony = mean(phase_all);

figure(5);
subplot(1,3,2);
h3 = rose((phase1*2*pi));
x3 = get(h3,'Xdata');
y3 = get(h3,'Ydata');
g3 = patch(x3,y3,'b');
title('Global Synchrony: First Syllable');
global_score_str1 = sprintf('Global Synchrony Score, Beat 1: %f', mean(phrase1));
global_text1 = uicontrol('Style','text','Position',[440 15 200 100],'String',global_score_str1);

figure(5);
subplot(1,3,3);
h4 = rose((phase2*2*pi));
x4 = get(h4,'Xdata');
y4 = get(h4,'Ydata');
g4 = patch(x4,y4,'b');
title('Global Synchrony: Third Syllable');
global_score_str2 = sprintf('Global Synchrony Score, Beat 3: %f', mean(phrase2));
global_text2 = uicontrol('Style','text','Position',[660 15 200 100],'String',global_score_str1);
global_score_all_str = sprintf('Global Synchrony Score, All: %f', Global_Synchrony);
global_text_all = uicontrol('Style','text','Position',[550 10 200 100],'String',global_score_all_str);

%circvect ????

%global_score_str = sprintf('Global Synchrony Score: %f', Global_Synchrony);
%h5 = msgbox(global_score_str);




         
