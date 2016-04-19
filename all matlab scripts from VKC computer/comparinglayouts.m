load EGI_layout129.lay.mat

load EGI_129_newmask.lay.mat



load chords_tut_subj18_stnd_ERP.mat


cfg.layout = EGI_129_newmask
ft_layoutplot(cfg, data_ERP)
 
title('mask')

cfg=[];
cfg.layout = EGI_layout129

figure
ft_layoutplot(cfg, data_ERP)
 
title('no mask')

%%

cfg = [];
cfg.elecfile='GSN129_positions.sfp';
cfg.projection = 'stereographic';
cfg.rotate = 0;

EGI_129 = ft_prepare_layout(cfg);

cfg.layout = EGI_129
ft_layoutplot(cfg, data_ERP)
