% batch  to redo all campers with correct reference
%% evoked 
wavelet_tf_MAPcampers_evoandERP
clear all; clc

do_ERPblc_MAPcampers_ERPs
clear all; clc

calc_avgbase_step1_tf_MAP_campers_evo % there was an error in this script; subject #'s were wrong, fixd now
clear all;

calc_avgbase_step2_tf_MAP_campers_evo
clear all; 

dobaselinecorrTF_MAPcampers_evo
clear all;


%% induced
wavelet_tf_MAPcampers_ind
clear all; clc

calc_avgbase_step1_tf_MAP_campers_ind
clear all; clc

calc_avgbase_step2_tf_MAP_campers_ind
clear all; clc

dobaselinecorrTF_MAPcampers_ind
clear all; clc


%% grand averages/all subj

calc_gravg_MAPcampers_allbins_ERP_good
clear all; clc

calc_gravg_MAPcampers_allbins_avblc_evo
clear all; clc

calc_gravg_MAPcampers_allbins_avblc_ind
clear all; clc

calc_allSubj_MAPcamp_ERP
clear all; clc

calc_allSubj_MAPcamp_avblc_evo
clear all; clc

calc_allSubj_MAPcamp_avblc_ind
clear all; clc





