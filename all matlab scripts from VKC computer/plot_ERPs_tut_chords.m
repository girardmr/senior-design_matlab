% plotting ERPs

load EGI_129_newmask.lay.mat
bin{1}='stnd';
bin{2}='trgt';
bin{3}='novl';


cfg = [];
cfg.layout = EGI_129_newmask
cfg.xparam = 'time'
cfg.zparam = 'avg'
cfg.showlabels    = 'yes'


ft_multiplotER(cfg,gravg.(bin{1}),gravg.(bin{2}),gravg.(bin{3}))

