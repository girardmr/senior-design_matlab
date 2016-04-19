clear all; clc; close all
%% define subjects

Spre{1}='01_pre'; Spre{2}='02_pre'; Spre{3}='03_pre'; Spre{4}='04_pre'; Spre{5}='05_pre';
Spre{6}='06_pre'; Spre{7}='07_pre'; Spre{8}='08_pre'; Spre{9}='09_pre'; %Spre{10}='10_pre'; 10 didnt' do post

Spost{1}='01_post'; Spost{2}='02_post'; Spost{3}='03_post'; Spost{4}='04_post'; Spost{5}='05_post';
Spost{6}='06_post'; Spost{7}='07_post'; Spost{8}='08_post';  Spost{9}='09_post';


%% load data
for m=1:length(Spre) %for each subject
    sujPre  = Spre{m};
    
    load(cat(2,'CP',sujPre,'_snd_fft_coh_all.mat'))
    data.Pre{m} = FFTcoh;
    clear FFTcoh
    
    sujPost = Spost{m};
    load(cat(2,'CP',sujPost,'_snd_fft_coh_all.mat'));
    
    data.Post{m} = FFTcoh;
    clear FFTcoh
end



load tut_layout.mat % this layout excludes EOG channels
layout = EGI_layout129;


cfg                  = [];
cfg.layout           = layout;
%cfg.xparam           = 'freq';
%cfg.zparam           = 'cohspctrm';
cfg.xlim             = [4 54];
cfg.ylim             = [-1 1]
cfg.showlabels       = 'yes';
cfg.parameter = 'wpli_debiasedspctrm';
cfg.refchannel = 'E46';
%cfg.interactive = 'yes';

for m =1:length(Spre)
    
    suj = num2str(m)
    figure 
    
    ft_multiplotER(cfg, data.Pre{m},data.Post{m});
    outfilename = cat(2,'CP',suj,'prevspostchvsT7');
    title(outfilename);
    
    saveas(gcf, outfilename, 'fig');
    saveas(gcf, outfilename, 'epsc');
    
end

%% T8
cfg                  = [];
cfg.layout           = layout;
%cfg.xparam           = 'freq';
%cfg.zparam           = 'cohspctrm';
cfg.xlim             = [4 54];
cfg.ylim             = [-1 1]
cfg.showlabels       = 'yes';
cfg.parameter = 'wpli_debiasedspctrm';
cfg.refchannel = 'E109';
%cfg.interactive = 'yes';

for m =1:length(Spre)
    
    suj = num2str(m)
    figure 
    
    ft_multiplotER(cfg, data.Pre{m},data.Post{m});
    outfilename = cat(2,'CP',suj,'prevspostchvsT8');
    title(outfilename);
    
    saveas(gcf, outfilename, 'fig');
    saveas(gcf, outfilename, 'epsc');
    
end

