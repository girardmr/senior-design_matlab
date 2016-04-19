% the ft_freqgrandaverage function doesn't work

% load in baseline-corrected COH (new) 
% keep individual subjects
% save files 
% mod. july 2011 by rlg
clear all; clc

%% define subjects - MECP2 duplications boys
S{1}='07'; S{2}='08'; S{3}='09'; S{4}='10'; S{5}='11'; S{6}='14'; S{7}='16';
S{8}='17'; S{9}='18'; S{10}='19'; S{11}='20'; S{12}='21'; 


%% define conditions here - must use exact same labels as "Categories"in egi .seg
bin{1}='FamVoice';
bin{2}='UnfamVoiceParent';
bin{3}='UnfamVoiceConstant';

%%

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}=  cat(2,'voices',suj,'_',bin{b},'_fft_cohFz.mat')
    end
    
end

%nsubj = length(S);

for m=1:length(S)
    
    for b=1:length(bin)
        
        data.(bin{b}){m}=load(file_cond.(bin{b}){m}); %load the file for each condition and each subject, put in one structure
        
        
        
        Fcohdata.(bin{b}){m} = data.(bin{b}){m}.FFTcoh; % take only what we need (coherence data)
        
    end
end
clear data

load tut_layout.mat % this layout excludes EOG channels

cfg = [];
cfg.keepindividual = 'yes'; %
cfg.layout       = EGI_layout129; 

for b=1:length(bin)
    
    allSubj.(bin{b})=   ft_freqgrandaverage(cfg,Fcohdata.(bin{b}){:});
    outfile     =  cat(2,'MeCP2_',bin{b}, '_allSubj_cohFz_12s.mat');
    allSubj_cohFz =  allSubj.(bin{b});
    save(outfile, 'allSubj_cohFz');
    
    clear outfile allSubj_cohFz
    
end

% this collects all identical time/frequency/channel samples over all
% subjects into a single data structure     
% ?? need to use something else to do freq grandaverage; why doesn't this
% work??
  
% for b=1:length(bin)
%     
%     allSubj.(bin{b})=   ft_freqgrandaverage(cfg,Fcohdata.(bin{b}){:});
%     outfile     =  cat(2,'MeCP2_',bin{b}, '_allSubj_cohFz_12s.mat');
%     allSubj_cohFz =  allSubj.(bin{b});
%     save(outfile, 'allSubj_cohFz');
%     
%     clear outfile allSubj_cohFz
%     
% end



