% batch for all difference waves calculations to run group contrasts
% on both campers and controls

%% good subjects

% S{1}='w604'; S{2}='w605';  S{3}='w606'; S{4}='w608';  S{5}='w609'; S{6}='w610'; S{7}='w611';  S{8}='w612'; S{9}='w614';
% S{10}='w615';  S{11}='w616'; S{12}='w617'; S{13}='w620';
% 
% S{1}='w6c002';  S{2}='w6c003'; S{3}='w6c004'; S{4}='w6c007';  S{5}='w6c009'; S{6}='w6c010';
% S{7}='w6c011';  S{8}='w6c012'; S{9}='w6c013'; S{10}='w6c014'; S{11} = 'w6c015'; S{12} = 'w6c016'; S{13} = 'w6c017';

W6_calc_difwave_camp_ERP
clear all; clc

W6_calc_difwave_ctrl_ERP
clear all; clc

W6_calc_difwave_ctrl_avblc_evo
clear all; clc

W6_calc_difwave_ctrl_avblc_ind
clear all; clc

W6_calc_difwave_camp_avblc_evo
clear all; clc

W6_calc_difwave_camp_avblc_ind
clear all; clc

calc_gravg_MAPcamp_dif_avblc_evo
clear all; clc

calc_gravg_MAPcontr_dif_avblc_evo
clear all; clc

calc_allSubj_MAPcamp_dif_avblc_evo
clear all; clc

calc_allSubj_MAPcamp_dif_avblc_ind
clear all; clc

calc_allSubj_MAPcontr_dif_avblc_ind
clear all; clc

calc_allSubj_MAPcontr_dif_avblc_evo
clear all; clc


