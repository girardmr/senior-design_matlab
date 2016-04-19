% plot individual subject data - ERPs and topo - trying to find some
% relatioship w/ behavioral data.
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='W701';  S{2}='W702'; S{3}='W704'; S{4}='W705';  S{5}='W708'; S{6}='W709';
S{7}='W710';  S{8}='W711'; S{9}='W712'; S{10}='W714'; S{11}='W715'; S{12}='W717';
S{13}='W718';  S{14}='W720'; S{15}='W722'; S{16}='W723'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='WordRhyCong';
bin{2}='WordRhyIncong';

% condname{1}='Word Rhythm Congruous';
% condname{2}='WordRhythmIncongruous';
latsnaps = [0.348 0.400 0.448 0.500]
L= length(latsnaps)
L_ms = latsnaps*1000;
zscale = [-3 3];

%% load files into two structures
subjectdata = {};
difwavedata = {};

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_CDT_',bin{b},'_ERP_blc.mat') %load filtered baseline corr ERPs
        load(filename)
        subjectdata.(suj).(bin{b}) = data;
        clear data
        
        load(cat(2,suj,'_CDTword_difwave_ERP.mat')) %load difwave file
        difwavedata.(suj) = data;
        clear data
    end
end

%% set up configuration
cfg = [];
load tut_layout.mat % this layout excludes EOG channels
cfg.layout = EGI_layout129;
%load cmapRWB.mat

%cfg.layout = layout
cfg.interactive = 'no';
%cfg.channel = 'E4';%only FCz%
cfg.channel = 'all'
cfg.parameter  = 'avg';
%cfg.ylim    = zscale;
cfg.zlim = zscale;
%cfg.showlabels  = 'yes'; %show channel labels

cfg.commentpos = 'title';
cfg.shading    = 'interp';
cfg.style = 'straight';
cfg.interactive = 'yes';
%cfg.colorbar = 'EastOutside';
%cfg.colormap = cmap; use default one for now
cfg.fontsize = 12;
cfg.gridscale = 200;

%% plot
figure
for m=1:4 %for each subject
    suj=S{m};
    
    
    for k = 1:(L-1)
        
        spot = ((m-1)*4 +k)
        
        subplot(4,4,spot)
        
        cfg.xlim = [latsnaps(k) latsnaps(k+1)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),'-',num2str(L_ms(k+1)),' ms')
        ft_topoplotER(cfg,difwavedata.(suj))
        
    end
    
    %k = L+1 % last spot in the row
    %cfg.xlim
    %cfg.comment = suj;
    cfg.channel = 'Cz';
    %title(suj)
    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    title(cat(2,suj,' Cz'))

    %legend(bin{1},bin{2});
    
    time4ticks = [0:0.400:0.800]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)') comment out b/c images are too small now
    %     ylabel('Amplitude')
    
end

outfilename = 'CDT Word campers ERP topo N400 page1';

saveas(gcf, outfilename, 'jpg')
%saveas(gcf, outfilename, 'fig')

clear spot

%%
figure
for m=5:8 %for each subject
    suj=S{m};
    
    for k = 1:(L-1)
        spot = ((m-5)*4 +k)
        
        subplot(4,4,spot)
        
        cfg.xlim = [latsnaps(k) latsnaps(k+1)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),'-',num2str(L_ms(k+1)),' ms')
        ft_topoplotER(cfg,difwavedata.(suj))
    end
    
    %k = L+1 % last spot in the row
    %cfg.xlim
    %title(suj)
    cfg.channel = 'Cz';
    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}));
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    %legend(bin{1},bin{2});
    title(cat(2,suj,' Cz'))
    
    time4ticks = [0:0.400:0.800]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)')
    %     ylabel('Amplitude')
    %
    clear spot
end

outfilename = 'CDT Word campers ERP topo N400 page2';

saveas(gcf, outfilename, 'jpg')
%saveas(gcf, outfilename, 'fig')


%%
figure
for m=9:12 %for each subject
    suj=S{m};
    
    for k = 1:(L-1)
        spot = ((m-9)*4 +k)
        
        subplot(4,4,spot)
        
        cfg.xlim = [latsnaps(k) latsnaps(k+1)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),'-',num2str(L_ms(k+1)),' ms')
        ft_topoplotER(cfg,difwavedata.(suj))
    end
    
    %k = L+1 % last spot in the row
    %cfg.xlim
    %title(suj)
    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    %legend(bin{1},bin{2});
    title(cat(2,suj,' Cz'))
    
    time4ticks = [0:0.400:0.800]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)')
    %     ylabel('Amplitude')
    %
    clear spot
end

outfilename = 'CDT Word campers ERP topo N400 page3';

saveas(gcf, outfilename, 'jpg')
%saveas(gcf, outfilename, 'fig')

%%
figure
for m=13:16 %for each subject
    suj=S{m};
    
    for k = 1:(L-1)
        spot = ((m-13)*4 +k)
        
        subplot(4,4,spot)
        
        cfg.xlim = [latsnaps(k) latsnaps(k+1)]
        
        cfg.comment = cat(2,num2str(L_ms(k)),'-',num2str(L_ms(k+1)),' ms')
        ft_topoplotER(cfg,difwavedata.(suj))
    end
    
    %k = L+1 % last spot in the row
    %cfg.xlim
    %title(suj)
    
    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    %legend(bin{1},bin{2});
    title(cat(2,suj,' Cz'))
    
    time4ticks = [0:0.400:0.800]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)')
    %     ylabel('Amplitude')
    %
    clear spot
end

outfilename = 'CDT Word campers ERP topo N400 page4';

saveas(gcf, outfilename, 'jpg')
%saveas(gcf, outfilename, 'fig')





