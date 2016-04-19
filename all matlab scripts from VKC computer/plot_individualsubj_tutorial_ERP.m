 %% OLD
 % clear all; clc
% 
% load EGI_layout129.lay.mat
% elec= ft_read_sens('GSN128_positions_4clustering.sfp');
% 
% layout = EGI_layout129;
% 
% bin{1}='stnd';
% bin{2}='trgt';
% bin{3}='novl';
% 
% load(cat(2,'chords_ERP_',bin{1}, '_gravg.mat'));
% bin1 = ERPgravg;
% clear ERPgravg
% 
% load(cat(2,'chords_ERP_',bin{2}, '_gravg.mat'));
% bin2 = ERPgravg;
% clear ERPgravg
% 
% load(cat(2,'chords_ERP_',bin{3}, '_gravg.mat'));
% bin3 = ERPgravg;
% clear ERPgravg
% 
% 
% %% INTERACTIVE PLOT - ALL CHANNELS
% cfg = [];
% cfg.layout = layout;
% 
% %cfg.layout = ft_prepare_layout(elec);
% 
% cfg.zparam        = 'avg';
% cfg.xlim         = [-0.100 0.700];%time I CAN'T SEE THE COLORBAR!??
% %cfg.ylim = 
% 
% cfg.interactive = 'yes'
% ft_multiplotER(cfg,bin1, bin2, bin3)
% legend(bin{1},bin{2},bin{3});
% time4ticks = [0:0.200:0.600]; %% times on axis wherewhere you 
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% %
% % 
% %% Single channel plot - Cz
% 
% figure
% cfg = [];
% cfg.channel  = 'Cz'
% cfg.layout  = layout;
% cfg.zparam        = 'avg';
% cfg.xlim         = [-0.100 0.700];%time I CAN'T SEE THE COLORBAR!??
% %cfg.ylim = ; % uses same maxmin from topoplot
% 
% cfg.interactive = 'yes'
% ft_singleplotER(cfg,bin1, bin2, bin3)
% 
% time4ticks = [0:0.200:0.600]; %% times on axis wherewhere you 
% set(gca,'XTick',time4ticks);
% set(gca,'XTickLabel',time4ticks*1000); % plots time in ms
% legend(bin{1},bin{2},bin{3});
% 
% 
% elec= ft_read_sens('GSN128_positions_4clustering.sfp');
% 
