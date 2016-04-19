function speech_analysis
% SPEECH_ANALYSIS Calculate the nuclear and global synchrony scores for a
% given speech file and corresponding metronome track. 
%   SPEECH_FILE: speech track to be imported. Use single quotes ('').
%   METRONOME_TRACK: metronome track to be imported. Use single quotes
%   ('').
%   SAMPLING_RATE: sampling frequency in Hz.
%   METRONOME_TYPE: 0.5 for half note, 1 for whole note.
%   METRONOME_BPM: beats per minute of metronome. 

%Enter inputs.
prompts = {'Enter File Name: ','Enter Metronome Type: ','Enter Metronome BPM: '};
inputbox_title = 'Inputs';
num_lines = 1;
inputs = inputdlg(prompts, inputbox_title, num_lines);

speech_file = inputs{1};
metronome_track = inputs{1};
metronome_type_input = inputs{2};
metronome_bpm_input = inputs{3};

metronome_type = str2num(metronome_type_input);
metronome_bpm = str2num(metronome_bpm_input);

%Load speech file. Load metronome track.
speech_import = load(speech_file);
speech_names = fieldnames(speech_import);
speech_data_all = speech_import.(speech_names{1});
speech_data = speech_data_all(:,2);

metronome_import = load(metronome_track);
metronome_names = fieldnames(metronome_import);
metronome_data_all = metronome_import.(metronome_names{1});
metronome_data = metronome_data_all(:,1);

sampling_rate = 44100; %Sampling rate in Hz. 
rec_time = length(speech_data)/sampling_rate;

%envelope
z = hilbert(speech_data);
env = abs(z);
nyquist = sampling_rate/2; 
cutlp2 = 5; %Sets 5 Hz cutoff frequency
Wn3 = cutlp2/nyquist; %normalizes cutoff to work with butter func.
[a3,b3] = butter(1,Wn3); %produces transfer coefficients for 5 Hz lowpass
y3 = filter(a3,b3,env); %filters data labeled 'env'
%created time vector associated with envelope
step = rec_time/numel(y3);
t = [0:step:rec_time-step];

% %plot filtered envelope of speech recording
% figure(1);
% plot(t,y3,'r');
% title('Envelope of Filtered Data')

%% 
%Locate speech peaks

%peak values and their locations
[pks, loc] = findpeaks(y3);
%create time vector associated with located peaks
time_loc = zeros(length(loc),1);
for jj = 1:length(loc)
    time_loc(jj) = loc(jj)*step-step;
end

%Smooth signal
n = 0;
pk_ind = 1;
temp_max_peak = 0;
counter = 1;
t_division = 0.025;
while counter < (rec_time/t_division+1)
%only look at t_division (ex: 0.025 seconds) of data at a time
for ii = 1:length(time_loc)
    if time_loc(ii) >= n && time_loc(ii) <= n+t_division
        %find max peak in the next time division (ex: 0.025 second piece of
        %data)
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

figure(3);
plot(time_max_peak,max_pks,'m'); 
title('Speech Peaks')


%Locate speech peaks
pk_threshold = 0.25*(max(max_pks)-min(max_pks));
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
for p = 2:length(time_speech_loc) %-1 %%need a statement for last point
    time_diff1 = time_speech_loc(p) - time_speech_loc(p-1);
    %time_diff2 = time_speech_loc(p+1) - time_speech_loc(p);
    if time_diff1 >= 0.666/3 %&& time_diff2 >= 0.2
        speech_loc_2(pk_ind) = speech_loc(p);
        time_speech_loc_2(pk_ind) = time_speech_loc(p);
        speech_pk_2(pk_ind) = speech_pk(p);
        pk_ind = pk_ind+1;
    end
end
hold on;
plot(time_speech_loc_2,speech_pk_2,'x')
hold off;

%% Hand Adjustments

%choose starting point
uiwait(msgbox({'Click the point where you would like the data set that will be submitted for scoring to start.' 'Do not include phrases said with the experimenter.' 'Press the Return key when finished.'},'modal'));
[start_x, start_y] = ginput; 
rr = 1;
for kk = 1:length(time_max_peak)
    if time_max_peak(kk) >= start_x
        time_max_peak(rr) = time_max_peak(kk);
    else
        time_max_peak(rr) = 0;
    end
    rr = rr+1;
end
time_max_peak = time_max_peak(time_max_peak ~= 0);
num_el_start = numel(time_max_peak);
start_ind = numel(max_pks)-num_el_start;
max_pks = max_pks(start_ind+1:end);
ss = 1;
for vv = 1:length(time_speech_loc_2)
    if time_speech_loc_2(vv) >= start_x
        time_speech_loc_2(ss) = time_speech_loc_2(vv);
        speech_loc_2(ss) = speech_loc_2(vv);
        speech_pk_2(ss) = speech_pk_2(vv);
    else
        time_speech_loc_2(ss) = 0;
        speech_loc_2(ss) = 0;
        speech_pk_2(ss) = 0;
    end
    ss = ss+1;
end
time_speech_loc_2 = time_speech_loc_2(time_speech_loc_2 ~= 0);
speech_loc_2 = speech_loc_2(speech_loc_2 ~= 0);
speech_pk_2 = speech_pk_2(speech_pk_2 ~= 0);
t_btwn_pts_y3 = 1/sampling_rate;
t_start = find( t > start_x-(t_btwn_pts_y3/2) & t < start_x+(t_btwn_pts_y3/2));
t = t(t_start:end);
y3 = y3(t_start:end);
figure(3);
plot(time_max_peak, max_pks, 'm', time_speech_loc_2, speech_pk_2, 'x')

%truncate data
truncate = questdlg('Do you wish to truncate the data?','Truncation','Yes','No ','No ');
if truncate == ['Yes']
    uiwait(msgbox({'Click where you wish to truncate the data' 'Press the Return key when finished.'},'modal'));
    [trunc_x, trunc_y] = ginput; %returns time and peak amplitude of chosen point
    %select data only up to truncation point
    mm = 1;
    for jj = 1:length(time_max_peak)
        if time_max_peak(jj) <= trunc_x
            time_max_peak(mm) = time_max_peak(jj);
        else 
            time_max_peak(mm) = 0;
        end
        mm = mm+1;
    end
    time_max_peak = time_max_peak(time_max_peak ~= 0);
    num_el_trunc = numel(time_max_peak);
    max_pks = max_pks(1:num_el_trunc);
    nn = 1;
    for ii = 1:length(time_speech_loc_2)
        if time_speech_loc_2(ii) <= trunc_x
            time_speech_loc_2(nn) = time_speech_loc_2(ii);
            speech_loc_2(nn) = speech_loc_2(ii);
            speech_pk_2(nn) = speech_pk_2(ii);
        else
            time_speech_loc_2(nn) = 0;
            speech_loc_2(nn) = 0;
            speech_pk_2(nn) = 0;
        end
        nn = nn+1;
    end
    time_speech_loc_2 = time_speech_loc_2(time_speech_loc_2 ~= 0);
    speech_loc_2 = speech_loc_2(speech_loc_2 ~= 0);
    speech_pk_2 = speech_pk_2(speech_pk_2 ~= 0);
    t_btwn_pts_y3 = 1/sampling_rate;
    t_end = find( t > trunc_x-(t_btwn_pts_y3/2) & t < trunc_x+(t_btwn_pts_y3/2));
    t = t(1:t_end);
    y3 = y3(1:t_end);
end
rec_time = t(end)-start_x;
figure(3);
plot(time_max_peak, max_pks, 'm', time_speech_loc_2, speech_pk_2, 'x')

%peak correction
%divide max_pks data into fourths
num_el_max_pks = length(time_max_peak);
time_div_ind = round(num_el_max_pks/4);
time_div1 = time_max_peak(1:time_div_ind);
pks_div1 = max_pks(1:time_div_ind);
time_div2 = time_max_peak(time_div_ind+1:2*time_div_ind);
pks_div2 = max_pks(time_div_ind+1:2*time_div_ind);
time_div3 = time_max_peak(2*time_div_ind+1:3*time_div_ind);
pks_div3 = max_pks(2*time_div_ind+1:3*time_div_ind);
time_div4 = time_max_peak(3*time_div_ind+1:end);
pks_div4 = max_pks(3*time_div_ind+1:end);

%divide speech peak data into fourths
sp1 = 1;
sp2 = 1;
sp3 = 1;
sp4 = 1;
for sp = 1:length(time_speech_loc_2)
    if time_speech_loc_2(sp) <= time_div1(end)
        speech_t_div1(sp1) = time_speech_loc_2(sp);
        speech_pk_div1(sp1) = speech_pk_2(sp);
        speech_loc_div1(sp1) = speech_loc_2(sp);
        sp1 = sp1+1;
    elseif (time_speech_loc_2(sp) > time_div1(end)) && (time_speech_loc_2(sp) <= time_div2(end))
        speech_t_div2(sp2) = time_speech_loc_2(sp);
        speech_pk_div2(sp2) = speech_pk_2(sp);
        speech_loc_div2(sp2) = speech_loc_2(sp);
        sp2 = sp2+1;
    elseif (time_speech_loc_2(sp) > time_div2(end)) && (time_speech_loc_2(sp) <= time_div3(end))
        speech_t_div3(sp3) = time_speech_loc_2(sp);
        speech_pk_div3(sp3) = speech_pk_2(sp);
        speech_loc_div3(sp3) = speech_loc_2(sp);
        sp3 = sp3+1;
    elseif time_speech_loc_2(sp) > time_div3(end)
        speech_t_div4(sp4) = time_speech_loc_2(sp);
        speech_pk_div4(sp4) = speech_pk_2(sp);
        speech_loc_div4(sp4) = speech_loc_2(sp);
        sp4 = sp4+1;
    end
end

q_adjust = questdlg('Are these peaks correct?','Hand Adjustment','Yes','No ','Yes');
if q_adjust == ['No ']
    figure(4);
    suptitle('Speech Peaks: Hand Adjustments');
    %first division
    %plot all data, divided into quarters
    subplot(2,2,1);
    plot(time_div1, pks_div1,'m',speech_t_div1,speech_pk_div1,'gx');
    subplot(2,2,2);
    plot(time_div2, pks_div2,'m')
    subplot(2,2,3);
    plot(time_div3, pks_div3,'m')
    subplot(2,2,4);
    plot(time_div4, pks_div4,'m')
    %looking at first 1/4 of data
    q_adjust1 = questdlg('Are the green peaks correct?','Hand Adjustment 1','Yes','No ','Yes');
    if q_adjust1 == ['No ']
        uiwait(msgbox({'Click on the correct speech peaks for the entire waveform.' 'Emphasis should be given to time values (x-axis) rather than peak amplitude (y-axis).' 'Press the Return key when finished.'},'modal'));
        figure(4);
        subplot(2,2,1);
        plot(time_div1, pks_div1,'m');
        %if peaks aren't correct, clear previous data and hand select
        %correct points
        clear speech_loc_div1 speech_pk_div1
        [speech_t_div1, speech_pk_div1] = ginput;
        step_div1 = (time_div1(end))/length(time_div1);
        for mm = 1:length(speech_t_div1)
            speech_loc_div1(mm) = round(speech_t_div1(mm)/step_div1);
        end
    elseif q_adjust1 == ['Yes']
        speech_loc_div1 = speech_loc_div1;
        speech_t_div1 = speech_t_div1;
        speech_pk_div1 = speech_pk_div1;
    end
    figure(4);
    subplot(2,2,1);
    plot(time_div1, pks_div1,'m',speech_t_div1,speech_pk_div1,'bx');
    %ensure that all vectors are row vectors
    [row col] = size(speech_loc_div1);
    if row ~= 1
        speech_loc_div1 = speech_loc_div1';
    end
    [row col] = size(speech_t_div1);
    if row ~= 1
        speech_t_div1 = speech_t_div1';
    end
    [row col] = size(speech_pk_div1);
    if row ~= 1
        speech_pk_div1 = speech_pk_div1';
    end
    %second division
    subplot(2,2,2);
    plot(time_div2, pks_div2,'m',speech_t_div2,speech_pk_div2,'gx');
    q_adjust2 = questdlg('Are the green peaks correct?','Hand Adjustment 2','Yes','No ','Yes');
    if q_adjust2 == ['No ']
        uiwait(msgbox({'Click on the correct speech peaks for the entire waveform.' 'Emphasis should be given to time values (x-axis) rather than peak amplitude (y-axis).' 'Press the Return key when finished.'},'modal'));
        figure(4);
        subplot(2,2,2);
        plot(time_div2, pks_div2,'m');
        clear speech_loc_div2 speech_pk_div2
        [speech_t_div2, speech_pk_div2] = ginput;
        step_div2 = (time_div2(end)-time_div1(end))/length(time_div2);
        for mm = 1:length(speech_t_div2)
            speech_loc_div2(mm) = round(speech_t_div2(mm)/step_div2);
        end        
    elseif q_adjust2 == ['Yes']
        speech_loc_div2 = speech_loc_div2;
        speech_t_div2 = speech_t_div2;
        speech_pk_div2 = speech_pk_div2;
    end
    figure(4);
    subplot(2,2,2);
    plot(time_div2, pks_div2,'m',speech_t_div2,speech_pk_div2,'bx');
    [row col] = size(speech_loc_div2);
    if row ~= 1
        speech_loc_div2 = speech_loc_div2';
    end
    [row col] = size(speech_t_div2);
    if row ~= 1
        speech_t_div2 = speech_t_div2';
    end
    [row col] = size(speech_pk_div2);
    if row ~= 1
        speech_pk_div2 = speech_pk_div2';
    end
    %third division
    subplot(2,2,3);
    plot(time_div3, pks_div3,'m',speech_t_div3,speech_pk_div3,'gx');
    q_adjust3 = questdlg('Are the green peaks correct?','Hand Adjustment 3','Yes','No ','Yes');
    if q_adjust3 == ['No ']
        uiwait(msgbox({'Click on the correct speech peaks for the entire waveform.' 'Emphasis should be given to time values (x-axis) rather than peak amplitude (y-axis).' 'Press the Return key when finished.'},'modal'));
        figure(4);
        subplot(2,2,3);
        plot(time_div3, pks_div3,'m');
        clear speech_loc_div3 speech_pk_div3 
        [speech_t_div3, speech_pk_div3] = ginput;
        step_div3 = (time_div3(end)-time_div2(end))/length(time_div2);
        for mm = 1:length(speech_t_div3)
            speech_loc_div3(mm) = round(speech_t_div3(mm)/step_div3);
        end        
    elseif q_adjust3 == ['Yes']
        speech_loc_div3 = speech_loc_div3;
        speech_t_div3 = speech_t_div3;
        speech_pk_div3 = speech_pk_div3;
    end
    figure(4);
    subplot(2,2,3);
    plot(time_div3, pks_div3,'m',speech_t_div3,speech_pk_div3,'bx');
    [row col] = size(speech_loc_div3);
    if row ~= 1
        speech_loc_div3 = speech_loc_div3';
    end
    [row col] = size(speech_t_div3);
    if row ~= 1
        speech_t_div3 = speech_t_div3';
    end
    [row col] = size(speech_pk_div3);
    if row ~= 1
        speech_pk_div3 = speech_pk_div3';
    end
    %fourth division
    subplot(2,2,4);
    plot(time_div4, pks_div4,'m',speech_t_div4,speech_pk_div4,'gx');
    q_adjust4 = questdlg('Are the green peaks correct?','Hand Adjustment 4','Yes','No ','Yes');
    if q_adjust4 == ['No ']
        uiwait(msgbox({'Click on the correct speech peaks for the entire waveform.' 'Emphasis should be given to time values (x-axis) rather than peak amplitude (y-axis).' 'Press the Return key when finished.'},'modal'));
        figure(4);
        subplot(2,2,4);
        plot(time_div4, pks_div4,'m');
        clear speech_loc_div4 speech_pk_div4
        [speech_t_div4, speech_pk_div4] = ginput;
        step_div4 = (time_div4(end)-time_div3(end))/length(time_div4);
        for mm = 1:length(speech_t_div4)
            speech_loc_div4(mm) = round(speech_t_div4(mm)/step_div4);
        end    
    elseif q_adjust4 == ['Yes']
        speech_loc_div4 = speech_loc_div4;
        speech_t_div4 = speech_t_div4;
        speech_pk_div4 = speech_pk_div4;
    end
    figure(4);
    subplot(2,2,4);
    plot(time_div4, pks_div4,'m',speech_t_div4,speech_pk_div4,'bx');
    [row col] = size(speech_loc_div4);
    if row ~= 1
        speech_loc_div4 = speech_loc_div4';
    end
    [row col] = size(speech_t_div4);
    if row ~= 1
        speech_t_div4 = speech_t_div4';
    end
    [row col] = size(speech_pk_div4);
    if row ~= 1
        speech_pk_div4 = speech_pk_div4';
    end
    clear time_speech_loc_2 speech_pk_2 speech_loc_2
    %concatenate correct peaks
    speech_loc_2 = [speech_loc_div1 speech_loc_div2 speech_loc_div3 speech_loc_div4];
    time_speech_loc_2 = [speech_t_div1 speech_t_div2 speech_t_div3 speech_t_div4];
    speech_pk_2 = [speech_pk_div1 speech_pk_div2 speech_pk_div3 speech_pk_div4];
elseif q_adjust == ['Yes']
    speech_loc_2 = speech_loc_2;
    time_speech_loc_2 = time_speech_loc_2;
    speech_pk_2 = speech_pk_2;
end
    

%%

%Locate speech beat

%resample y3  
size_resample = round(rec_time*150);
y3_resample = resample(y3,size_resample,length(y3))';
step_resample = rec_time/size_resample;
time_resample = [start_x:step_resample:t(end)-step_resample];
resample_start_ind = round(time_resample(1)/step_resample);
speech_loc_resample = round(speech_loc_2*(size_resample/length(max_pks)));
speech_loc_resample_t = speech_loc_resample*step_resample-step_resample;

%locate indices of points 60% up waveform
for kk = 1:length(speech_pk_2)
   ind_found = find(y3_resample>((0.6*speech_pk_2(kk))-(0.1*speech_pk_2(kk))) & y3_resample<=((0.6*speech_pk_2(kk))+(0.1*speech_pk_2(kk))));
   ind_found = ind_found+resample_start_ind;
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
%remove indices that equal zero 
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
    amp_60(mm) = y3_resample(ind_60_new(mm)-resample_start_ind);
end
%visualize 60% points
figure(3);
hold on;
plot(t_60,amp_60,'kx');
title('Speech Beats');
hold off;


%%

%Circular Statistics
%Nuclear Synchrony

%Regroup speech beats by syllable of phrase...only works for 3 syllable
%phrases

%start index of anlyzed data...dependent on hand adjustments
% if q_adjust == ['Yes'];
%     %elimate first two phrases said with experimenter
%     syllable1 = t_60(7:3:end);
%     syllable2 = t_60(8:3:end);
%     syllable3 = t_60(9:3:end);
% elseif q_adjust1 == ['Yes']
%     syllable1 = t_60(7:3:end);
%     syllable2 = t_60(8:3:end);
%     syllable3 = t_60(9:3:end);
% else
%     %start at first selected corect peak for analysis
%     syllable1 = t_60(1:3:end);
%     syllable2 = t_60(2:3:end);
%     syllable3 = t_60(3:3:end);
% end

%start at first selected corect peak for analysis
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
for r = 1:length(syllable3)
    diff_syl1_syl2(r) = syllable2(r) - syllable1(r);
    diff_syl1_syl3(r) = syllable3(r) - syllable1(r);
end

%Phase of second (diff_syl1_syl2 divided by diff_syl1) and third syllables (diff_syl1_syl2 divided by diff_syl1)
for ss = 1:length(diff_syl1_syl2)
    phase(ss) = diff_syl1_syl2(ss)/diff_syl1_syl3(ss);
end
%Nuclear Synchrony score = average of phase;
Nuclear_Synchrony = mean(phase);
Nuclear_stdev = std(phase);

% option to use circ_r function:
% Nuclear_Synchrony = circ_r(2*pi*phase',[],[],1);

%Rose plot
figure(5);
subplot(1,3,1);
h1 = rose(phase*2*pi,30);
x1 = get(h1,'Xdata');
y1 = get(h1,'Ydata');
g1 = patch(x1,y1,'b');
reducepatch(g1, 0.5);
title('Nuclear Synchrony')
score_str = sprintf('Nuclear Synchrony Mean: %f', Nuclear_Synchrony);
nuclear_stdev_str = sprintf('Nuclear Synchrony Standard Deviation: %f', Nuclear_stdev);
nuclear_text = uicontrol('Style','text','Position',[220 40 200 100],'String',score_str); %Position: [x y length_box height_box?]
nuclear_text_stdev = uicontrol('Style','text','Position',[220 10 200 100],'String',nuclear_stdev_str); 

%%
%Identify peaks of metronome

env_m = abs(hilbert(metronome_data));

%resample metronome track to make same size as speech file
size_resample_m = length(speech_data);
met_resample = resample(env_m,size_resample_m,length(env_m))';
step_resample_m = (length(speech_data)/sampling_rate)/size_resample_m;
time_resample_m = [0:step_resample_m:(length(speech_data)/sampling_rate)-step_resample_m];

%locate peaks of metronome -- location of metronome beats
[pks_m, loc_m] = findpeaks(met_resample,'MinPeakHeight',0.25*max(met_resample));
loc_m_t = loc_m/sampling_rate;
loc_m_t2(1) = loc_m_t(1);
loc_m2(1) = loc_m(1);
pks_m2(1) = pks_m(1);
m_ind = 2;
for pp = 2:length(loc_m_t)
    if loc_m_t(pp)-loc_m_t(pp-1) > 0.5
        loc_m_t2(m_ind) = loc_m_t(pp);
        loc_m2(m_ind) = loc_m(pp);
        pks_m2(m_ind) = pks_m(pp);
        m_ind = m_ind+1;
    end
end

% met_ind = 2;
% loc_m_2(1) = loc_m2(1);
% pks_m_2(1) = pks_m2(1);
% for pp = 2:length(loc_m2)
%     m_diff = loc_m2(pp) - loc_m2(pp-1);
%     if m_diff > (loc_m2(2)-loc_m2(1))
%         loc_m_2(met_ind) = loc_m2(pp);
%         pks_m_2(met_ind) = pks_m2(pp);
%         met_ind = met_ind+1;
%     end
% end
% time_met_2 = loc_m_2*step_m;

step_m = 1/sampling_rate; 
time_met_2 = loc_m_t2;
loc_m_2 = loc_m2;
pks_m_2 = pks_m2;

figure(6);
plot(t_60,0.2,'ro',time_met_2,0.1,'bx'); %red = speech beats, blue = metronome 
axis([0 t(end) 0 0.3]);
title('Metronome Beat (blue) vs Speech Beat (red)');


%%
%Global Synchrony

% if q_adjust == ['Yes']
%     %start on the seventh speech beat if first two phrases said with the experimenter.
%     syl1_first_ind = ind_60_new(7);
%     syl3_first_ind = ind_60_new(9);
%     syl1_first_t = t_60(7);
%     syl3_first_t = t_60(9);
% elseif q_adjust1 == ['Yes']
%     %start on seventh speech beat if first two phrases said with
%     %experimenter...assumes first correct phrase is the first phrase spoken
%     %with the experimenter
%     syl1_first_ind = ind_60_new(7);
%     syl3_first_ind = ind_60_new(9);
%     syl1_first_t = t_60(7);
%     syl3_first_t = t_60(9);
% else
%     %start on first peak if hand adjustments done
%     syl1_first_ind = ind_60_new(1);
%     syl3_first_ind = ind_60_new(3);
%     syl1_first_t = t_60(1);
%     syl3_first_t = t_60(3);
% end

syl1_first_ind = ind_60_new(1);
syl3_first_ind = ind_60_new(3);
syl1_first_t = t_60(1);
syl3_first_t = t_60(3);

num_phrases = length(syllable1)-2;
met_track_length = 2*num_phrases;
%find metronome beat for first phrase
for nn = 1:length(time_met_2)
    met_syl1_diff(nn) = abs(time_met_2(nn) - syl1_first_t);
    if met_syl1_diff(nn) == min(met_syl1_diff)
        met_first_ind = nn;
    end
end
%cut down metronome track to same size as speech data to be analyzed
if met_first_ind+met_track_length < length(loc_m_2)
    met_track = loc_m_2(met_first_ind:met_first_ind+met_track_length);
elseif met_first_ind+met_track_length == length(loc_m_2)
    met_track = loc_m_2(met_first_ind:met_first_ind+met_track_length); 
elseif met_first_ind+met_track_length > length(loc_m_2)
    met_track = loc_m_2(met_first_ind:end);
end

%% chocolate analysis 
if metronome_type == 0.5

%divide metronome track into first and second beats per phrase
met_beat1_ind = met_track(1:2:end);
met_beat1 = met_beat1_ind*step_m;
met_beat2_ind = met_track(2:2:end);
met_beat2 = met_beat2_ind*step_m;

t_btwn_beats = 60/metronome_bpm;

%calculate time between speech syllable and associated metronome beat
cc = 1;
for yy = 1:num_phrases %changed from length(syllable1)
    syl1_metbeat1(yy) = abs(syllable1(yy) - met_beat1(yy));
    syl3_metbeat2(yy) = abs(syllable3(yy) - met_beat2(yy));
    if (syl1_metbeat1(yy) < t_btwn_beats) && (syl3_metbeat2(yy) < t_btwn_beats) 
        time_dif_beat1(cc) = syl1_metbeat1(yy);
        time_dif_beat2(cc) = syl3_metbeat2(yy);
        cc = cc+1;
    end
end

%calculate phase
phase1 = time_dif_beat1./t_btwn_beats; %first beat
phase2 = time_dif_beat2./t_btwn_beats; %second beat
phase_all = vertcat(phase1',phase2'); %both first and second beat
Global_Synchrony1 = mean(phase1);
Global_stdev1 = std(phase1);
Global_Synchrony2 = mean(phase2);
Global_stdev2 = std(phase2);
Global_Synchrony = mean(phase_all);
Global_stdev_all = std(phase_all);

%option to use circ_r
%Global_Synchrony = circ_r(phase_all,[],[],1);
%Global_Synchrony1 = circ_r(phase1',[],[],1);
%Global_Synchrony2 = circ_r(phase2',[],[],1)

figure(5);
subplot(1,3,2);
h3 = rose((phase1*2*pi));
x3 = get(h3,'Xdata');
y3 = get(h3,'Ydata');
g3 = patch(x3,y3,'b');
reducepatch(g3, 0.5);
title('Global Synchrony: First Syllable');
global_score_str1 = sprintf('Global Synchrony Mean, Beat 1: %f', Global_Synchrony1 );
global_stdev1_str = sprintf('Global Synchrony Standard Deviation, Beat 1: %f', Global_stdev1);
global_text1 = uicontrol('Style','text','Position',[615 40 200 100],'String',global_score_str1);
global_text_stdev1 = uicontrol('Style','text','Position',[615 0 200 100],'String',global_stdev1_str);

figure(5);
subplot(1,3,3);
h4 = rose((phase2*2*pi));
x4 = get(h4,'Xdata');
y4 = get(h4,'Ydata');
g4 = patch(x4,y4,'b');
reducepatch(g4, 0.5); %reduces original number of patches by 50%
title('Global Synchrony: Third Syllable');
global_score_str2 = sprintf('Global Synchrony Mean, Beat 3: %f', Global_Synchrony2);
global_text2 = uicontrol('Style','text','Position',[1000 40 200 100],'String',global_score_str2);
global_stdev2_str = sprintf('Global Synchrony Standard Deviation, Beat 3: %f', Global_stdev2);
global_text_stdev2 = uicontrol('Style','text','Position',[1000 10 200 100],'String',global_stdev2_str);
global_score_all_str = sprintf('Global Synchrony Mean, All: %f', Global_Synchrony);
global_text_all = uicontrol('Style','text','Position',[805 -30 200 100],'String',global_score_all_str);
global_stdevall_str = sprintf('Global Synchrony Standard Deviation, All: %f', Global_stdev_all);
global_text_stdevall = uicontrol('Style','text','Position',[805 -60 200 100],'String',global_stdevall_str);

%% vanilla analysis
elseif metronome_type == 1

t_btwn_beats = metronome_bpm/60;

%calculate amount of time between speech beat and associated metronome beat
cc = 1;
for yy = 1:num_phrases %changed from length(syllable1)
    syl_metbeat(yy) = abs(syllable1(yy) - met_track(yy));
    if (syl_metbeat(yy) < t_btwn_beats)  %0.666 taken from alison's code
        time_dif_beat1(cc) = syl_metbeat(yy);
        cc = cc+1;
    end
end    

phase1 = time_dif_beat1./t_btwn_beats;
Global_Synchrony = mean(phase1);
Global_stdev = std(phase1);

%option to use circ_r:
%Global_Synchrony = circ_r(phase1',[],[],1);

%Rose plot: nuclear
figure(5);
subplot(1,2,1);
h1 = rose(phase*2*pi,30);
x1 = get(h1,'Xdata');
y1 = get(h1,'Ydata');
g1 = patch(x1,y1,'b');
reducepatch(g1, 0.5);
title('Nuclear Synchrony')
score_str = sprintf('Nuclear Synchrony Mean: %f', Nuclear_Synchrony);
nuclear_stdev_str = sprintf('Nuclear Synchrony Standard Deviation: %f', Nuclear_stdev);
nuclear_text = uicontrol('Style','text','Position',[400 40 200 100],'String',score_str); %Position: [x y length_box height_box?]
nuclear_text_stdev = uicontrol('Style','text','Position',[400 10 200 100],'String',nuclear_stdev_str); 

%Rose plot: global
figure(5);
subplot(1,2,2);
h3 = rose((phase1*2*pi));
x3 = get(h3,'Xdata');
y3 = get(h3,'Ydata');
g3 = patch(x3,y3,'b');
reducepatch(g3, 0.5);
title('Global Synchrony');
global_score_str1 = sprintf('Global Synchrony Mean: %f', Global_Synchrony);
global_text1 = uicontrol('Style','text','Position',[800 40 200 100],'String',global_score_str1);
global_stdev_str = sprintf('Global Synchrony Score: %f', Global_stdev);
global_stdev_text = uicontrol('Style','text','Position',[800 10 200 100],'String',global_stdev_str);

end
