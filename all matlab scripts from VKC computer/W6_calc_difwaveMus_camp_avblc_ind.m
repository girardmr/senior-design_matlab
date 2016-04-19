% calculate difference waves induced  W6 faces data
% modified on 23 jan 2012 by rlg

clear all; clc

%select subjects
S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';


%select conditions
bin{1}='HapMus';
bin{2}='SadMus';

for m=1:length(S)
    suj=S{m};
    
    for b=1:length(bin)
        file_cond.(bin{b}){m}= cat(2,suj,'_MAP_',bin{b},'_tfr_avblc_ind.mat');
    end
    
end

for m=1:length(S)
    suj=S{m};
    
    %% happy vs sad music (diff spectrum)
    cond1=load(file_cond.(bin{1}){m});
    %clear data
    cond2=load(file_cond.(bin{2}){m});
    
    New=cond1;
    New.TFRwave_ind.powspctrm = cond1.TFRwave_ind.powspctrm - cond2.TFRwave_ind.powspctrm; % Happy vs Sad
    TFRwave_ind = New.TFRwave_ind;
    
    % name file
    outfile= cat(2,suj,'_MAP_MusDifwave_avblc_ind.mat')
    save(outfile,'TFRwave_ind');
    clear  TFRwave_ind New outfile cond1 cond2
    
    
end

