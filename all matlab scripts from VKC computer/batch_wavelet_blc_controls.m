% batch 27 oct 2011 with all 13 controls
%% evoked 
wavelet_tf_MAPcontrols_evoandERP
clear all; clc

do_ERPblc_MAPcontrols_ERPs
clear all; clc

calc_avgbase_step1_tf_MAPcontrols_evo
clear all; clc

calc_avgbase_step2_tf_MAPcontrols_evo
clear all; clc

dobaselinecorrTF_MAPcontrols_evo
clear all; clc


%% induced
wavelet_tf_MAPcontrols_ind
clear all; clc

calc_avgbase_step1_tf_MAPcontrols_ind
clear all; clc

calc_avgbase_step2_tf_MAPcontrols_ind
clear all; clc

dobaselinecorrTF_MAPcontrols_ind
clear all; clc

%% grand averages/all subj

calc_gravg_MAPcontrols_ERP
clear all; clc

calc_gravg_MAPcontrols_avblc_evo
clear all; clc

calc_gravg_MAPcontrols_avblc_ind
clear all; clc

calc_allSubj_MAPcontrols_ERP
clear all; clc

calc_allSubj_MAPcontr_avblc_evo
clear all; clc

calc_allSubj_MAPcontr_avblc_ind
clear all; clc

