% plot grandaverage ERPs for 3 conditions in the tutorial.
% This can be modified to plot single subject data by changing input filenames
% rlg november 2010

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='TEN_corr';
bin{2}='TEN_viol';

load(cat(2,'SLIR_101_', bin{1}, '_syntax_lpf_ERP_blc.mat'));
bin1 = data;
clear data

load(cat(2,'SLIR_101_', bin{2}, '_syntax_lpf_ERP_blc.mat'));
bin2 = data;
clear data



%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
cfg.projection = 'polar'; % comment out if plotting positive up
cfg.rotate = 180; % comment out if plotting positive up
upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
cfg.layout = upsidedown; % comment out if plotting positive up
%cfg.layout = layout; use this if plotting positive up
ft_multiplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

saveas(gcf, 'ERP subject average multichan, SLIR_101_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average multichan, SLIR_101_syntax_TEN', 'jpg'); % save as a jpeg file


%% Single channel plot - Cz

figure
cfg = [];
cfg.channel = 'E62'; %Pz
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time 

ft_singleplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % plot negative up

legend('Tense Correct','Tense Violation');
title('ERPs at Electrode Pz- Subject 101');

time4ticks = [0:0.200:1.200]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')

saveas(gcf, 'ERP subject average Pz, SLIR_101_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average Pz, SLIR_101_syntax_TEN', 'jpg'); % save as a jpeg file


%% end SLIR_101, start SLIR_102

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='TEN_corr';
bin{2}='TEN_viol';

load(cat(2,'SLIR_102_', bin{1}, '_syntax_lpf_ERP_blc.mat'));
bin1 = data;
clear data

load(cat(2,'SLIR_102_', bin{2}, '_syntax_lpf_ERP_blc.mat'));
bin2 = data;
clear data



%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
cfg.projection = 'polar'; % comment out if plotting positive up
cfg.rotate = 180; % comment out if plotting positive up
upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
cfg.layout = upsidedown; % comment out if plotting positive up
%cfg.layout = layout; use this if plotting positive up
ft_multiplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

saveas(gcf, 'ERP subject average multichan, SLIR_102_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average multichan, SLIR_102_syntax_TEN', 'jpg'); % save as a jpeg file


%% Single channel plot - Cz

figure
cfg = [];
cfg.channel = 'E62'; %Pz
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time 

ft_singleplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % plot negative up

legend('Tense Correct','Tense Violation');
title('ERPs at Electrode Pz- Subject 102');

time4ticks = [0:0.200:1.200]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')

saveas(gcf, 'ERP subject average Pz, SLIR_102_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average Pz, SLIR_102_syntax_TEN', 'jpg'); % save as a jpeg file


%% end SLIR_102 start SLIR_103

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='TEN_corr';
bin{2}='TEN_viol';

load(cat(2,'SLIR_103_', bin{1}, '_syntax_lpf_ERP_blc'));
bin1 = data;
clear data

load(cat(2,'SLIR_103_', bin{2}, '_syntax_lpf_ERP_blc.mat'));
bin2 = data;
clear data



%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
cfg.projection = 'polar'; % comment out if plotting positive up
cfg.rotate = 180; % comment out if plotting positive up
upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
cfg.layout = upsidedown; % comment out if plotting positive up
%cfg.layout = layout; use this if plotting positive up
ft_multiplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

saveas(gcf, 'ERP subject average multichan, SLIR_103_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average multichan, SLIR_103_syntax_TEN', 'jpg'); % save as a jpeg file


%% Single channel plot - Cz

figure
cfg = [];
cfg.channel = 'E62'; %Pz
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time 

ft_singleplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % plot negative up

legend('Tense Correct','Tense Violation');
title('ERPs at Electrode Pz- Subject 103');

time4ticks = [0:0.200:1.200]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')

saveas(gcf, 'ERP subject average Pz, SLIR_103_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average Pz, SLIR_103_syntax_TEN', 'jpg'); % save as a jpeg file


%% end SLIR_103 start SLIR_104

clear all; clc

load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;

bin{1}='TEN_corr';
bin{2}='TEN_viol';

load(cat(2,'SLIR_104_', bin{1}, '_syntax_lpf_ERP_blc.mat'));
bin1 = data;
clear data

load(cat(2,'SLIR_104_', bin{2}, '_syntax_lpf_ERP_blc.mat'));
bin2 = data;
clear data



%% INTERACTIVE PLOT - ALL CHANNELS
cfg = [];

%cfg.layout = ft_prepare_layout(elec);
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time in seconds
cfg.showlabels  = 'yes'; %show channel labels
cfg.interactive = 'yes';

% if we are plotting negative up, for some reason it
% it turns the layout file upside, too, so that is why I had to
% create another layout with 180 degree rotation
cfg.elecfile='GSN128_positions_4clustering.sfp'; % comment out if plotting positive up
cfg.projection = 'polar'; % comment out if plotting positive up
cfg.rotate = 180; % comment out if plotting positive up
upsidedown = ft_prepare_layout(cfg); % comment out if plotting positive up
cfg.layout = upsidedown; % comment out if plotting positive up
%cfg.layout = layout; use this if plotting positive up
ft_multiplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)

saveas(gcf, 'ERP subject average multichan, SLIR_104_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average multichan, SLIR_104_syntax_TEN', 'jpg'); % save as a jpeg file


%% Single channel plot - Cz

figure
cfg = [];
cfg.channel = 'E62'; %Pz
cfg.zparam  = 'avg';
cfg.xlim    = [-0.100 1.200];%time 

ft_singleplotER(cfg,bin1, bin2)
set(gca,'YDir','reverse') % plot negative up

legend('Tense Correct', 'Tense Violation');
title('ERPs at Electrode Pz- Subject 104');

time4ticks = [0:0.200:1.200]; %% %% times on axis where you want ticks 
set(gca,'XTick',time4ticks);
set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
xlabel('Time (ms)')
ylabel('Amplitude')

saveas(gcf, 'ERP subject average Pz, SLIR_104_syntax_TEN', 'fig'); % save as a Matlab Figure file
%saveas(gcf, 'ERP subject average Pz, SLIR_104_syntax_TEN', 'jpg'); % save as a jpeg file
