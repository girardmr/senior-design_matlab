% calculate difference waves evoked  match vs. mismatch W6 faces data
% modified on 12/20/11 by rlg

clear all; clc

%select subjects
S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

%select conditions
bin{1}= 'mus_Match_face'; %
bin{2}= 'mus_Mismatch_face'; %
% bin{3}= 'neutson_bothface'; %

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_evo.mat');
    end
    
end

for m=1:length(S)
    suj=S{m};
    
    %% FACES matching vs. mismatching emotion of music (diff spectrum)
    cond1=load(file_cond.(bin{1}){m});
    %clear data
    cond2=load(file_cond.(bin{2}){m});
    
    New=cond1;
    New.TFRwave_evo.powspctrm = cond1.TFRwave_evo.powspctrm - cond2.TFRwave_evo.powspctrm; % Match minus Mismatch
    TFRwave_evo = New.TFRwave_evo;
    
    % name file
    outfile= cat(2,suj,'_MAP_Matchdifwave_avblc_evo.mat')
    save(outfile,'TFRwave_evo');
    clear  TFRwave_evo New outfile cond1 cond2
    
    
end

