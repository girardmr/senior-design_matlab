% for each individual subject:
% take difference between the data points in the two contrasting conditions
% only at times and frequencies included in the (group-defined) cluster.

% maybe calculate difference waves first, then load in each individual participant along
% with stat file, use  bigmat procedure from clusterplotting to choose
% points belonging to the cluster, sum those.
clear all; clc

% CAREFUL, POS CLUSTER!!
%% define subjects - SLIR
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104';
S{5}='SLIR_105';  S{6}='SLIR_106'; S{7}='SLIR_108'; % no subject 107, too few trials
S{8}='SLIR_109';  S{9}='SLIR_110'; S{10}='SLIR_111';

% load stat file w/ sig cluster
load SLIR_syntax_corrvsviol_10TLDSs_ERP_stat.mat

% get conditions
bin{1}= stat.cond1 %
bin{2}= stat.cond2 %

% load in difference waves for each subject
for m=1:length(S)
    suj=S{m};
    for b= 1:length(bin)
        filename = cat(2,suj,'_',bin{b},'_syntax_lpf_ERP_blc.mat')
        
        load(filename)
        %data{m}.(bin{b}) = TFRwave_evo
        ERPdata{m}.(bin{b}) = data
        
        clear filename data
    end
end

% % load in difference waves for each subject
% for m=1:length(S)
%     suj=S{m};
%     filename = cat(2,suj,'_SLIR_difwavboth_ERP.mat')
%
%     load(filename)
%     ERPdata{m} = data
%
%     clear filename data
% end


% %% get info from stat file

% % CAREFUL, NEG CLUSTER!!
Big_mat_all = (stat.negclusterslabelmat == 1); %find time,channel pairs where
% %electrode belongs to significant cluster (neg cluster#1)
Big_mat = squeeze(Big_mat_all);
%
[x,y]=find(Big_mat==1); %find channel,time pairs of significant electrodes
%
C_onlytime = squeeze(sum(Big_mat,1)); %collapse over channels to get earliest timepoint
timeind_min = min(find(C_onlytime~=0)); % just extra info
timeind_max = max(find(C_onlytime~=0));
timelim = [stat.time(timeind_min) stat.time(timeind_max)];

freqband = stat.cfg.frequency; % frequency band


tt = min(stat.time)
uu = max(stat.time)

%% for each subject, get cluster sum
K = [];
difwavSum = {};
%toilim
%time = [0.400 0.700]; % N400 range
%load centrpost_ch.mat
% centrpost_ch = {'E42'; 'E37'; 'E31'; 'E7'; 'E107'; 'E106'; 'E105'; 'E104';...
%     'E48'; 'E43'; 'E38'; 'E32'; 'Cz'; 'E81'; 'E88'; 'E94'; 'E99'; ...
%     'E52'; 'E53'; 'E54'; 'E55'; 'E80'; 'E87'; 'E91'; 'E93'; 'E86';...
%     'E60'; 'E53'; 'E61'; 'E68'; 'E79'; 'E62';  'E87'; 'E92'; ...
%     'E66'; 'E72'; 'E77'; 'E85'; 'E62'};

for m=1:length(S)
    suj=S{m};
    J ={};
    
    for b= 1:length(bin) %start bin loop
        % take just timepoints and frequencies in the sig. cluster,but all channels
        % for now, or better to take stat.time to have equivalent matrices
        % alternative: data = ft_selectdata(TFRwave_ind,'foilim',freqband,'toilim',timelim)
        %     cfg = [];
        %     cfg.avgoverchan = 'yes'
        %     cfg.avgovertime = 'yes'
        %     %cfg.channel = centrpost_ch;
        %
        %     cfg.toilim = time;
        %trimdata = ft_selectdata(ERPdata{m},'toilim',time,'channel', 'E73','avgoverchan','no','avgovertime','yes')
        %trimdata = ft_selectdata_new(cfg,ERPdata{m},'avgoverchan','no','avgovertime','yes')
        trimdata = ft_selectdata(ERPdata{m}.(bin{b}),'toilim',[tt uu],'avgoverchan','no','avgovertime','no');
        
        sujdata_bigmat = squeeze(trimdata.avg);
        
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
    L = J.(bin{2}) - J.(bin{1}) % positivity, so subtract viol - corr?
    
    % use this value per subject for corr analysis:
    difwavClustsum.(subjectname) = L;
    % also save in a number-only table with subj #
    
    K(m,1) = str2num(suj(6:end)); % because suj above are mixed strings and numbers
    K(m,2) = L; % J needs to be a difference here
    K(m,3) = J.(bin{1});
    K(m,4) = J.(bin{2});
        
    
end



dlmwrite('SLIR_10SsTLD_ERPpositivity_sums_cluster.txt',K,'delimiter','\t','precision','%.2f');



