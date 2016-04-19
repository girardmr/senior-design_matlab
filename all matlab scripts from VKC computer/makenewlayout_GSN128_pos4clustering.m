clear all
cfg=[];


cfg.elecfile='GSN128_positions_4clustering.sfp';
cfg.projection = 'polar';
cfg.rotate = 0;

EGI_layout129 = ft_prepare_layout(cfg);
save tut_layout.mat EGI_layout129


% newmask = EGI_129.mask
% A=cell2mat(newmask)
% [TH,R] = cart2pol(A(:,1),A(:,2));
% clear newmask
% [x,y] = pol2cart(TH,R+0.15);
% 
% newmask = [x y];
% EGI_129.mask {1,1}= newmask;
% EGI_129_newmask = EGI_129;
% cfg =[];
% cfg.layout = EGI_129_newmask;
% ft_layoutplot(cfg)


% the mask thing is not working
% 
% load chords_tut_subj18_stnd_ERP.mat
% 
% 
% cfg.layout = EGI_129_newmask
% ft_layoutplot(cfg, data_ERP)
%save EGI_129_newmask.lay.mat EGI_129_newmask


% %%
% soprolay_noCz.label = soprolay_noCz.label(1:124,:)
% soprolay_noCz.pos = soprolay_noCz.pos(1:52,:)
% soprolay_noCz.width = soprolay_noCz.width(1:52,:)
% soprolay_noCz.height = soprolay_noCz.height(1:52,:)
% % 
% 
% clear cfg
% save soprolay_noCz1.lay.mat soprolay_noCz
% 
% clear all
% 
% load soprolay_noCz.lay.mat;
% newmask = soprolay_noCz.mask
% A=cell2mat(newmask)
% [TH,R] = cart2pol(A(:,1),A(:,2));
% clear newmask
% [x,y] = pol2cart(TH,R+0.125);
% 
% newmask = [x y];
% soprolay_noCz.mask {1,1}= newmask;
% soprolay_noCzwithnewmask = soprolay_noCz;
% save soprolay_noCzwithnewmask.mat soprolay_noCzwithnewmask
% 
% %%%
% % clear all
% % cfg=[];
% cfg.elecfile='Hydrocel65.sfp';
% hydro65layoutnofiduc=prepare_layout(cfg)
% save hydro65layoutnofiduc