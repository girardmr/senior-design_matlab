% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg feb 22 2011

clear all; clc; close all

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='HapMus';
bin{2}='SadMus';
bin{3}='NeutSon';
bin{4}= 'mus_Match_face'; %
bin{5}= 'mus_Mismatch_face'; %
bin{6}= 'neutson_bothface'; %

condname{1}='Happy Music';
condname{2}='Sad Music';
condname{3}='Neutral Sound';
condname{4}='Face Match';
condname{5}='Face Mismatch';
condname{6}='Face Neutral';


%load data
for b=1:length(bin) %for each condition specified above
    
    filename = cat(2,'MAP_controls_',bin{b}, '_gravg_avblc_ind.mat');
    load(filename)
    gravgdata.(bin{b}) = TFgravg_ind;
    clear TFgravg_ind
end
%% set up configuration

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

cfg.layout = layout
cfg.xparam = 'time'
cfg.yparam = 'freq'
cfg.zparam = 'powspctrm'
cfg.xlim = [0 0.600] % time 0 to 600ms
cfg.interactive = 'no';
cfg.layout = EGI_layout129;
cfg.ylim = [8 50] % theta, alpha, and beta frequencies
cfg.zlim = 'maxmin' % 
cfg.baseline = 'no' % whole epoch
% cfg.baseline = [-0.250 -0.100];
% cfg.baselinetype = 'relative';

cfg.channel = 'all'
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

%% multiplot - music

for b= 1:3
    figure(b)
    cfg.zlim = [-0.5 0.5] % CHANGE ZSCALES
    ft_multiplotTFR(cfg,gravgdata.(bin{b}))
    
    outfile = cat(2,'ind multichan Gravg controls',condname{b});
    supertitle(outfile)
    saveas(gcf, outfile, 'fig'); % save as a Matlab Figure file
    saveas(gcf, outfile, 'tif'); % save as a tiff file

    clear outfile
end

%% multiplot faces
for b= 4:6
    figure(b)
    cfg.zlim = [-0.5 0.5] 
    ft_multiplotTFR(cfg,gravgdata.(bin{b}))
    
    outfile = cat(2,'ind multichan Gravg controls ',condname{b});
    supertitle(outfile)
    saveas(gcf, outfile, 'fig'); % save as a Matlab Figure file
    saveas(gcf, outfile, 'tif'); % save as a tiff file

    clear outfile
end

