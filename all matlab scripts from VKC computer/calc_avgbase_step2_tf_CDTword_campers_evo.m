%takes  average power across conditions for each subject and compiles it
%into a matrix
%a baseline. This version does a separate mean for each frequency AND
%channel.    EVOKED
%mod. by rlg 13 dec 2011

clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; S{17} = 'W725';
S{18}='W824'; S{19}='W825'; S{20}='W826'; S{21}='W827'; S{22}='W828'; 
S{23}='W829'; S{24}='W830';

%you don't need to define conditions in this one
%% Word bins
for m=1:length(S) %for each subject
    suj=S{m};

    filename= cat(2,'CDT_',suj,'_avgWordbins_tfr_evo.mat')
    load(filename)

    for j=1:size(TFRwave_evo.powspctrm,2); %loop frequencies
        for k=1:size(TFRwave_evo.powspctrm,1); %loop channels
            %calculate mean power per frequency per channel across time
            avgbase_sepch{m}(k,j)       = nanmean(TFRwave_evo.powspctrm(k,j,:)); 

        end
    end
    clear filename TFRwave_evo 
end


save CDT_campers_WordBins_avg_base_evo.mat avgbase_sepch
clear avgbase_sepch
