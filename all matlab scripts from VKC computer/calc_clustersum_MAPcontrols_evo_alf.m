% for each individual subject:
% take difference between the data points in the two contrasting conditions
% only at times and frequencies included in the (group-defined) cluster.

% maybe calculate difference waves first, then load in each individual participant along
% with stat file, use  bigmat procedure from clusterplotting to choose
% points belonging to the cluster, sum those.
% modified rlg 6 feb 2012

clear all; clc
load MAPcamp_1vs2_evo_alf_stat.mat % %  USE CAMPERS' CLUSTER WITH CONTROLS' DATA
% CAREFUL, POS CLUSTER!!
%% define subjects - campers
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';
% line 107 also had to be changed to write 4:end instead of 2:end
bin{1}= stat.cond1 %
bin{2}= stat.cond2 %

% load in data for each subject
for m=1:length(S)
    suj=S{m};
    for b = 1:length(bin)
        filename = cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_evo.mat');
        
        load(filename)
        data{m}.(bin{b}) = TFRwave_evo;
        
        clear filename TFRwave_evo
        
    end
end

%% get info from stat file
% CAREFUL, POS CLUSTER!!
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
        % alternative: data = ft_selectdata(TFRwave_ind,'foilim',freqband,'toilim',timelim)
        
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
    
    clear L J subjectname
end

dlmwrite('MAP_controls_evoalf_1vs2_diffsums.txt',K,'delimiter','\t','precision','%.2f');






