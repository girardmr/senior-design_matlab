
clear all
cfg=[];


cfg.elecfile='EGI129_1020pos.sfp';
cfg.projection = 'polar';
cfg.rotate = 0;

EGI_lay1020 = ft_prepare_layout(cfg);
save EGI129_1020lay.mat EGI_lay1020

cfg =[];
cfg.layout = EGI_lay1020;
ft_layoutplot(cfg)
