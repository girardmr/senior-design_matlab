%%compute average across conditions to use as baseline
% WS campers
% rlg 13 dec 2011

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; S{17} = 'W725';
S{18}='W824'; S{19}='W825'; S{20}='W826'; S{21}='W827'; S{22}='W828'; 
S{23}='W829'; S{24}='W830';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';


for m=1:length(S) %for each subject
    suj=S{m};
    %load all the files for one subject
    for b=1:length(bin) %for each condition specified above
        filename= cat(2,suj,'_CDT_',bin{b},'_tfr_evo.mat')
        data.(bin{b})=load(filename);
        clear filename
    end
    
    %% calculate average power for words
    cfg = [];
    cfg.keepindividual = 'no'; %now compute average spectra across bins for each S;
    cfg.toilim         = [-0.100 0.800];  %%  
    % if you have a different # of bins, the line below needs to be adjusted!
    TFRwave_evo = ft_freqgrandaverage(cfg, data.(bin{1}).TFRwave_evo, data.(bin{2}).TFRwave_evo);
    outfile= cat(2,'CDT_',suj,'_avgWordbins_tfr_evo.mat')
    save(outfile,'TFRwave_evo');
    clear TFRwave_evo outfile
    
    
end




