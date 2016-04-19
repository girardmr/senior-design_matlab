% for each individual subject: 
% take difference between the data points in the two contrasting conditions
% only at times and frequencies included in the (group-defined) cluster.

% maybe calculate difference waves first, then load in each individual participant along
% with stat file, use  bigmat procedure from clusterplotting to choose
% points belonging to the cluster, sum those.
clear all; clc
load CDT_ctrl_Words_evo_theta_stat.mat
% CAREFUL, POS CLUSTER!!
%% define subjects - campers
S{1}='W7C001';  S{2}='W7C002'; S{3}='W7C004'; S{4}='W7C005';  %S{5}='W7C006'; S{6}='W7C008';
S{5}='W7C009';  S{6}='W7C010'; S{7}='W7C011'; S{8}='W7C012'; S{9}='W7C013';
S{10}='W7C014'; S{11}='W7C015'; S{12}='W7C016'; S{13}='W7C017'; S{14}='W7C018';

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
Big_mat_all = (stat.negclusterslabelmat == 1); %find time,channel pairs where
%electrode belongs to significant cluster (neg cluster#1)
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
K = [];
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
    
    K(m,1) = str2num(suj(4:end)); % because suj above are mixed strings and numbers
    K(m,2) = L; % J needs to be a difference here
    K(m,3) = J.(bin{1});
    K(m,4) = J.(bin{2});
    
    
    clear L J subjectname
end

dlmwrite('CDTword_controls_evotheta_sums.txt',K,'delimiter','\t','precision','%.2f');

        
