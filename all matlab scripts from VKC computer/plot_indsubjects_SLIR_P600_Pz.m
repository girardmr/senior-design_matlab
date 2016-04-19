% plot individual subject data - ERPs and topo - % need some modification
% from original SLIR
% need to first compute difwaves for corr?viol
% need to modify also output names

clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='SLIR_101';  S{2}='SLIR_102'; S{3}='SLIR_103'; S{4}='SLIR_104'; 
S{5}='SLIR_105';  S{6}='SLIR_106'; S{7}='SLIR_107'; S{8}='SLIR_108';
S{9}='SLIR_109';  S{10}='SLIR_110'; S{11}='SLIR_111'; 

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='both_corr';
bin{2}='both_viol';


% condname{1}='Word Rhythm Congruous';
% condname{2}='WordRhythmIncongruous';
latsnaps = [0.550 0.650 0.750 0.850];
L= length(latsnaps);
L_ms = latsnaps*1000;
yscale = [-8 8];
%% load files into two structures
subjectdata = {};
difwavedata = {};

for m=1:length(S) %for each subject
    suj=S{m};
    
    for b=1:length(bin) %for each condition specified above
        
        filename = cat(2,suj,'_',bin{b},'_syntax_lpf_ERP_blc.mat') %load filtered baseline corr ERPs
        load(filename)
        subjectdata.(suj).(bin{b}) = data;
        clear data
        
        load(cat(2,suj,'_SLIR_difwavboth_ERP.mat')) %load difwave file
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
cfg.ylim    = yscale;
% cfg.ylim
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
    cfg.channel = 'E62'; %Pz
    %title(suj)
    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    title(cat(2,suj,' Pz'))

    %legend(bin{1},bin{2});
    
    time4ticks = [0:0.400:1.000]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)') comment out b/c images are too small now
    %     ylabel('Amplitude')
    
end

outfilename = 'SLIR syntax ERP topo P600 page1';

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
    cfg.channel = 'E62'; %Pz
    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}));
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    %legend(bin{1},bin{2});
    title(cat(2,suj,' Pz'))
    
    time4ticks = [0:0.400:1.000]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)')
    %     ylabel('Amplitude')
    %
    clear spot
end

outfilename = 'SLIR syntax ERP topo P600 page2';

saveas(gcf, outfilename, 'jpg')
%saveas(gcf, outfilename, 'fig')


%%
figure
for m=9:11 %for each subject
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
    cfg.channel = 'E62'; %Pz

    cfg.xlim = [-0.100 1.000]
    
    subplot(4,4,(spot+1))
    
    ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}))
    set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
    %legend(bin{1},bin{2});
    title(cat(2,suj,' Pz'))
    
    time4ticks = [0:0.400:1.000]; %% %% times on axis where you want ticks
    set(gca,'XTick',time4ticks);
    set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
    %     xlabel('Time (ms)')
    %     ylabel('Amplitude')
    %
    clear spot
end

outfilename = 'SLIR syntax ERP topo P600 page3';


saveas(gcf, outfilename, 'jpg')
%saveas(gcf, outfilename, 'fig')
% 
% %%
% figure
% for m=13:14 %for each subject
%     suj=S{m};
%     
%     for k = 1:(L-1)
%         spot = ((m-13)*4 +k)
%         
%         subplot(4,4,spot)
%         
%         cfg.xlim = [latsnaps(k) latsnaps(k+1)]
%         
%         cfg.comment = cat(2,num2str(L_ms(k)),'-',num2str(L_ms(k+1)),' ms')
%         ft_topoplotER(cfg,difwavedata.(suj))
%     end
%     
%     %k = L+1 % last spot in the row
%     %cfg.xlim
%     %title(suj)
%     title(cat(2,suj,' Pz'))
%     cfg.xlim = [-0.100 1.000]
%     
%     subplot(4,4,(spot+1))
%     
%     ft_singleplotER(cfg,subjectdata.(suj).(bin{1}),subjectdata.(suj).(bin{2}))
%     set(gca,'YDir','reverse') % PLOT NEGATIVE UP (OPTIONAL)
%     %legend(bin{1},bin{2});
%     title(cat(2,suj,'Pz'))
%     
%     time4ticks = [0:0.400:1.000]; %% %% times on axis where you want ticks
%     set(gca,'XTick',time4ticks);
%     set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
%     %     xlabel('Time (ms)')
%     %     ylabel('Amplitude')
%     %
%     clear spot
% end
% 
% outfilename = 'SLIR syntax ERP topo P600 page4';
% 
% saveas(gcf, outfilename, 'jpg')
% %saveas(gcf, outfilename, 'fig')





