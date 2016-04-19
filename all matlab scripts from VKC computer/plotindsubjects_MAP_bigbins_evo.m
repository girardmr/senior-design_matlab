%plot camper data -evoked
clear all; clc; close all

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='w601';  S{2}='w602'; S{3}='w604'; S{4}='w605';  S{5}='w606'; S{6}='w607';
S{7}='w608';  S{8}='w609'; S{9}='w610'; S{10}='w611';  S{11}='w612'; S{12}='w614';
S{13}='w615';  S{14}='w616'; S{15}='w617'; S{16}='w618';  S{17}='w619'; S{18}='w620';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; % 
bin{5}= 'mus_Mismatch_face'; % 
bin{6}= 'neutson_bothface'; %

condname{1}='Happy Music';
condname{2}='Sad Music ';
condname{3}='Neutral Sound';
condname{4}='Face Match';
condname{5}='Face Mismatch';
condname{6}='Face Neutral';

%% set up configuration

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

cfg.layout = layout
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.800] % time 0 to 600ms
cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [4 50] % theta, alpha, and beta frequencies
cfg.zlim = 'maxmin' % theta, alpha, and beta frequencies
cfg.baseline = [-0.400 0.800] % whole epoch
% cfg.baseline = [-0.250 -0.100];
cfg.baselinetype = 'relative';
cfg.zlim = 'maxmin' % theta, alpha, and beta frequencies

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above

        filename = cat(2,suj,'_MAP_',bin{b},'_tfr_evo.mat')
        load(filename)
        subjectdata.(bin{b}) = TFRwave_evo;
        clear TFRwave_evo
        
        figure(m)
        
        subplot(2,3,b)
        ft_singleplotTFR(cfg,subjectdata.(bin{b}))
        title(condname{b},'fontsize',10)
                      
    end
    
    suplabel((cat(2,suj,' Evoked - Avg Chan')),'t')

    outfilename = cat(2,suj,' bigbins evoked avg chan')

    saveas(gcf, outfilename, 'tif')
    clear subjectdata
end


