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
condname{2}='Sad Music ';
condname{3}='Neutral Sound';
condname{4}='Face Match';
condname{5}='Face Mismatch';
condname{6}='Face Neutral';


%load data
for b=1:length(bin) %for each condition specified above
    
    filename = cat(2,'MAP_controls_',bin{b}, '_gravg_avblc_evo.mat');
    load(filename)
    gravgdata.(bin{b}) = TFgravg_evo;
    clear TFgravg_evo
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
cfg.zlim = [-1 4] % 
cfg.baseline = 'no' % whole epoch
% cfg.baseline = [-0.250 -0.100];
% cfg.baselinetype = 'relative';

cfg.channel = 'all'
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

%% multiplot - music

for b= 1:3
    figure(b)
    cfg.zlim = [-1 2] % CHANGE ZSCALES
    ft_multiplotTFR(cfg,gravgdata.(bin{b}))
    
    outfile = cat(2,'Evo multichan Gravg controls ',condname{b});
    supertitle(outfile)
    saveas(gcf, outfile, 'fig'); % save as a Matlab Figure file
    saveas(gcf, outfile, 'tif'); % save as a tiff file

    clear outfile
end

%% multiplot faces
for b= 4:6
    figure(b)
    cfg.zlim = [-1 4] 
    ft_multiplotTFR(cfg,gravgdata.(bin{b}))
    
    outfile = cat(2,'Evo multichan Gravg controls ',condname{b});
    supertitle(outfile)
    saveas(gcf, outfile, 'fig'); % save as a Matlab Figure file
    saveas(gcf, outfile, 'tif'); % save as a tiff file

    clear outfile
end

%%

%         figure(m)
%
%         subplot(2,3,b)
%         ft_singleplotTFR(cfg,gravgdata.(bin{b}))
%         title(condname{b},'fontsize',10)
%
%     end
%
%     suplabel((cat(2,suj,' Evoked - Avg Chan')),'t')
%
%     outfilename = cat(2,suj,' bigbins evoked avg chan')
%
%     saveas(gcf, outfilename, 'tif')
%     clear subjectdata
%
%
%
% %%
%
% for b=1:length(bin) %for each condition specified above
%
%     filename = cat(2,'MAP_campers_',bin{b}, '_gravg_ERP_13s.mat'); %load filtered baseline corr ERPs
%     load(filename)
%     gravgdata.(bin{b}) = TFgravg_evo;
%     clear data
%
% end
%
% figure
%
% %% first set
% subplot(2,2,1)
% ft_singleplotER(cfg,gravgdata.(bin{1}),gravgdata.(bin{2}),gravgdata.(bin{3}))
% set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%
% %just for legend
% subplot(2,2,3)
% ft_singleplotER(cfg,gravgdata.(bin{1}),gravgdata.(bin{2}),gravgdata.(bin{3}))
% legend(condname{1},condname{2},condname{3},'Location','North')
%
% %% second set
% subplot(2,2,2)
% ft_singleplotER(cfg,gravgdata.(bin{4}),gravgdata.(bin{5}),gravgdata.(bin{6}))
% set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%
% %just for legend
% subplot(2,2,4)
% ft_singleplotER(cfg,gravgdata.(bin{4}),gravgdata.(bin{5}),gravgdata.(bin{6}))
% legend(condname{4},condname{5},condname{6},'Location','North')

%     %% third set
%
%     subplot(2,3,3)
%     ft_singleplotER(cfg,gravgdata.(bin{7}),gravgdata.(bin{8}),gravgdata.(bin{9}))
%     set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%     %just for legend
%     subplot(2,3,6)
%     ft_singleplotER(cfg,gravgdata.(bin{7}),gravgdata.(bin{8}),gravgdata.(bin{9}))
%
%     legend(condname{7},condname{8},condname{9},'Location','North')
% %
% %
% %
%
% suplabel('MAP gravg campers ','t')
%
% outfilename = 'MAP gravg bigbins ERP - E4'
%
% saveas(gcf, outfilename, 'tif')
% saveas(gcf, outfilename, 'fig')
% multiplot


%% OLD SCRIPT from tutorial

%% INTERACTIVE PLOT - ALL CHANNELS
% cfg = [];
%
% %cfg.layout = ft_prepare_layout(elec);
% cfg.zparam  = 'avg';
% cfg.xlim    = [-0.100 0.700];%time in seconds
% cfg.showlabels  = 'yes'; %show channel labels
% cfg.interactive = 'yes';
%
% % if we are plotting negative up, for some reason it
% % it turns the layout file upside, too, so that is why I had to
% % create another layout with 180 degree rotation
% cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
% cfg.projection = 'polar'; % comment out if plotting positive up
% cfg.rotate = 180; % comment out if plotting positive up
% upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
% cfg.layout = upsidedown; % comment out if plotting positive up
% %cfg.layout = layout; use this if plotting positive up
% ft_multiplotER(cfg,bin1, bin2, bin3)
% set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%
% saveas(gcf, 'ERP grand average multichan, tutorial', 'fig'); % save as a Matlab Figure file
% saveas(gcf, 'ERP grand average multichan, tutorial', 'tif'); % save as a tiff file
%
% %% Single channel plot - Cz
%
% figure
% cfg = [];
% cfg.channel = 'Cz';
% cfg.zparam  = 'avg';
% cfg.xlim    = [-0.100 0.700];%time
%
% ft_singleplotER(cfg,bin1, bin2, bin3)
% set(gca,'YDir','reverse') % plot negative up
%
% legend(bin{1},bin{2},bin{3});
%
% time4ticks = [0:0.200:0.600]; %% %% times on axis where you want ticks
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% xlabel('Time (ms)')
% ylabel('Amplitude')
%
% saveas(gcf, 'ERP grand average Cz, tutorial', 'fig'); % save as a Matlab Figure file
% saveas(gcf, 'ERP grand average Cz, tutorial', 'tif'); % save as a tiff file


