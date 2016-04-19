% for each individual subject: 
% take difference between the data points in the two contrasting conditions
% only at times and frequencies included in the (group-defined) cluster.

% maybe calculate difference waves first, then load in each individual participant along
% with stat file, use  bigmat procedure from clusterplotting to choose
% points belonging to the cluster, sum those.
clear all; clc
load CDT_camp_Words_evo_alf_stat
% CAREFUL, POS CLUSTER!!
%% define subjects - campers
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; 

bin{1}= stat.cond1 %
bin{2}= stat.cond2 %

% load in difference waves for each subject
for m=1:length(S)
    suj=S{m};
    for b= 1:length(bin)
        filename = cat(2,suj,'_CDT_',bin{b},'_tfr_avblc_evo.mat');
        
        load(filename)
        data{m}.(bin{b}) = TFRwave_evo
        
        clear filename TFRwave_evo
    end
end

%% get info from stat file
% CAREFUL, THERE are 2 POS CLUSTERs!!
Big_mat_all = (stat.posclusterslabelmat == 1); %find time,channel pairs where
%electrode belongs to significant cluster (pos cluster#1)
Big_mat = squeeze(Big_mat_all);

[x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes

C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0)); % just extra info
timeind_max = max(find(C_onlytime~=0));
timelim = [stat.time(timeind_min) stat.time(timeind_max)] % what is going on here?

freqband = stat.cfg.frequency % frequency band

tt = min(stat.time)
uu = max(stat.time)
% don't use timelim below - use tt uu for trimdata so that it takes same
% boundaries we used in the stats. then the loop will actually go and zero
% out the data not included in the cluster


%% for each subject, get cluster sum

difwavClustsum = {};

for m=1:length(S) % start subject loop
    suj=S{m};
    J ={};    
    
    for b= 1:length(bin) %start bin loop
        % take just timepoints and frequencies in the sig. cluster,but all channels
        % for now, or better to take stat.time to have equivalent matrices
        % alternative: data = ft_selectdata(TFRwave_evo,'foilim',freqband,'toilim',timelim)
        
        % problem is with ft_selectdata here.

        trimdata = ft_selectdata(data{m}.(bin{b}),'avgoverfreq','yes','foilim',freqband,'toilim',[tt uu]);

        sujdata_bigmat = squeeze(trimdata.powspctrm);
        
        % okay now Big_mat and sujdata_bigmat are equivalent
        
        % redefine sujdata_bigmat by zeroeing out values not belonging to cluster.
        sujdata_onlyclust = [];
        
        for ch = 1:size(Big_mat,1)
            for t = 1:size(Big_mat,2)
                %multiplying by 1 or zero
                sujdata_onlyclust(ch,t) = (sujdata_bigmat(ch,t) * Big_mat(ch,t)) ;
                
            end
        end
        
        % sum across channels
        H = sum(sujdata_onlyclust,1);
        
        
        % sum across timepoints
        J.(bin{b}) = sum(H)
        
        
        clear trimdata sujdata_bigmat sujdata_onlyclust ch t H
    end % end bin loop, should have both bins now for a given subject
    
    subjectname = suj;
    % subtract cluster sums here
    L = J.(bin{1}) - J.(bin{2})
    
    % use this value per subject for corr analysis:
    difwavClustsum.(subjectname) = L;
    % also save in a number-only table with subj #
    
    K(m,1) = str2num(suj(2:end)); % because suj above are mixed strings and numbers
    K(m,2) = L; % J needs to be a difference here
    K(m,3) = J.(bin{1});
    K(m,4) = J.(bin{2});
    
    
    clear L J subjectname
end

dlmwrite('CDTword_campers_evoalf_sums_cluster1.txt',K,'delimiter','\t','precision','%.2f');

        
%% cluster #2        

% get info from stat file
% CAREFUL, THERE are 2 POS CLUSTERs!!
Big_mat_all = (stat.posclusterslabelmat == 2); %find time,channel pairs where
%electrode belongs to significant cluster (pos cluster#2)
Big_mat = squeeze(Big_mat_all);

[x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes

C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0)); % just extra info
timeind_max = max(find(C_onlytime~=0));
timelim = [stat.time(timeind_min) stat.time(timeind_max)] % what is going on here?

freqband = stat.cfg.frequency % frequency band

tt = min(stat.time)
uu = max(stat.time)
% don't use timelim below - use tt uu for trimdata so that it takes same
% boundaries we used in the stats. then the loop will actually go and zero
% out the data not included in the cluster
difwavClustsum = {};

for m=1:length(S) % start subject loop
    suj=S{m};
    J ={};    
    
    for b= 1:length(bin) %start bin loop
        % take just timepoints and frequencies in the sig. cluster,but all channels
        % for now, or better to take stat.time to have equivalent matrices
        % alternative: data = ft_selectdata(TFRwave_evo,'foilim',freqband,'toilim',timelim)
        
        % problem is with ft_selectdata here.

        trimdata = ft_selectdata(data{m}.(bin{b}),'avgoverfreq','yes','foilim',freqband,'toilim',[tt uu]);

        sujdata_bigmat = squeeze(trimdata.powspctrm);
        
        % okay now Big_mat and sujdata_bigmat are equivalent
        
        % redefine sujdata_bigmat by zeroeing out values not belonging to cluster.
        sujdata_onlyclust = [];
        
        for ch = 1:size(Big_mat,1)
            for t = 1:size(Big_mat,2)
                %multiplying by 1 or zero
                sujdata_onlyclust(ch,t) = (sujdata_bigmat(ch,t) * Big_mat(ch,t)) ;
                
            end
        end
        
        % sum across channels
        H = sum(sujdata_onlyclust,1);
        
        
        % sum across timepoints
        J.(bin{b}) = sum(H)
        
        
        clear trimdata sujdata_bigmat sujdata_onlyclust ch t H
    end % end bin loop, should have both bins now for a given subject
    
    subjectname = suj;
    % subtract cluster sums here
    L = J.(bin{1}) - J.(bin{2})
    
    % use this value per subject for corr analysis:
    difwavClustsum.(subjectname) = L;
    % also save in a number-only table with subj #
    
    K(m,1) = str2num(suj(2:end)); % because suj above are mixed strings and numbers
    K(m,2) = L; % J needs to be a difference here
    K(m,3) = J.(bin{1});
    K(m,4) = J.(bin{2});
    
    
    clear L J subjectname
end

dlmwrite('CDTword_campers_evoalf_sums_cluster2.txt',K,'delimiter','\t','precision','%.2f');