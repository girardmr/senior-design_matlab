% load in baseline-corrected evoked on camper data
% calculate grand average by averaging together individual subjects and
% save
% mod. rlg 17 feb 2011

clear all; clc

%% ONLY GOOD SUBJECTS FOR THIS ONE
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';


%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY



bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; %
bin{5}= 'mus_Mismatch_face'; %
bin{6}= 'neutson_bothface'; %


for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}=  cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_evo.mat');
    end
    
end

for m=1:length(S)
    
    for b=1:length(bin)
        
        data.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        TFdata.(bin{b}){m} = data.(bin{b}){m}.TFRwave_evo; % take only what we need (TFdata)
        
    end
end
clear data

%Read in the electrode location file for this montage

load tut_layout.mat % this layout excludes EOG channels

cfg = [];
cfg.keepindividual = 'no'; %we want a grand average, so don't save individual subjects
cfg.layout       = EGI_layout129; 
   
for b=1:length(bin)
    
    gravg.(bin{b})=   ft_freqgrandaverage(cfg,TFdata.(bin{b}){:});
    outfile     =  cat(2,'MAP_campers_',bin{b}, '_gravg_avblc_evo.mat');
    TFgravg_evo =  gravg.(bin{b});
    save(outfile, 'TFgravg_evo');
    
    clear outfile TFgravg_evo
    
end







