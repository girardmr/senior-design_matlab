% for each individual subject: 
% take difference between the data points in the two contrasting conditions
% only at times and frequencies included in the (group-defined) cluster.

% maybe calculate difference waves first, then load in each individual participant along
% with stat file, use  bigmat procedure from clusterplotting to choose
% points belonging to the cluster, sum those.
clear all; clc

% CAREFUL, POS CLUSTER!!
%% define subjects - campers
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; 

% load in difference waves for each subject
for m=1:length(S)
    suj=S{m};
    filename = cat(2,suj,'_CDTword_difwave_ERP.mat')
    
    load(filename)
    ERPdata{m} = data
    
    clear filename data
end

% %% get info from stat file
% % CAREFUL, POS CLUSTER!!
% Big_mat_all = (stat.posclusterslabelmat == 1); %find time,channel pairs where
% %electrode belongs to significant cluster (pos cluster#1)
% Big_mat = squeeze(Big_mat_all)
% 
% [x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes
% 
% C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
% timeind_min = min(find(C_onlytime~=0)); % just extra info
% timeind_max = max(find(C_onlytime~=0));
% timelim = [stat.time(timeind_min) stat.time(timeind_max)];
% 
% freqband = stat.cfg.frequency; % frequency band
% 
% 
% a = min(stat.time)
% b = max(stat.time)


%% for each subject, get cluster sum

difwavSum = {};
%toilim
time = [300 500]; % N400 range
load centrpost_ch.mat
% centrpost_ch = {'E42'; 'E37'; 'E31'; 'E7'; 'E107'; 'E106'; 'E105'; 'E104';...
%     'E48'; 'E43'; 'E38'; 'E32'; 'Cz'; 'E81'; 'E88'; 'E94'; 'E99'; ...
%     'E52'; 'E53'; 'E54'; 'E55'; 'E80'; 'E87'; 'E91'; 'E93'; 'E86';...
%     'E60'; 'E53'; 'E61'; 'E68'; 'E79'; 'E62';  'E87'; 'E92'; ...
%     'E66'; 'E72'; 'E77'; 'E85'; 'E62'};

for m=1:length(S)
    suj=S{m};
    
    % take just timepoints and frequencies in the sig. cluster,but all channels
    % for now, or better to take stat.time to have equivalent matrices
    % alternative: data = ft_selectdata(TFRwave_ind,'foilim',freqband,'toilim',timelim)
    cfg = [];
    cfg.avgoverchan = 'yes'
    cfg.avgovertime = 'yes'
    cfg.channel = centrpost_ch;
    cfg.toilim = time;
    %trimdata = ft_selectdata(ERPdata{m},'foilim',freqband,'toilim',[a b])
    trimdata = ft_selectdata(ERPdata{m},'avgoverchan','yes','avgovertime','yes')

    %sujdata_bigmat = squeeze(trimdata.avg);
    
    % okay now Big_mat and sujdata_bigmat are equivalent
    
%     % redefine sujdata_bigmat by zeroeing out values not belonging to cluster.
%     sujdata_onlyclust = [];
%     
%     for ch = 1:size(Big_mat,1)
%         for t = 1:size(Big_mat,2)
%             %multiplying by 1 or zero
%             sujdata_onlyclust(ch,t) = (sujdata_bigmat(ch,t) * Big_mat(ch,t)) ;
%             
%         end
%     end
    
    % sum across channels
%     H = sum(sujdata_onlyclust,1);
%     
%     % sum across timepoints
%     J = sum(H);
%     % use this value per subject for corr analysis
    J= trimdata.avg
    subjectname = suj;
    difwavSum.(subjectname) = J;
    % also save in a number-only table with subj #
    K(m,1) = str2num(suj(2:end)); % because suj above are mixed strings and numbers
    K(m,2) = J;
            
    clear trimdata sujdata_bigmat sujdata_onlyclust ch t H J 
    
end

%dlmwrite('CDTword_campers_ERP_sums.txt',K,'delimiter','\t','precision','%.2f');

       
        
        
        
        
        