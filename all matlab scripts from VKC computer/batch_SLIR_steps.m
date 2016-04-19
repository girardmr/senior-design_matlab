% scripts that were used on newly referenced mastoid trial data from NS

%import data from .mat files
import_fieldtrip_trials_SLIR_syntax

clear all; clc

% append trials together to collapse all corr vs all viol conditions
append_correctandviolation_SLIR_syntax

clear all; clc

%compute evoked and ERPs - lowpass filter.
wavelet_evo_ERP_lpf20_SLIR_syntax

clear all; clc

% do BLC - baseline of 100ms
do_ERPblc_SLIR_syntax_lpf20_ERPs

clear all; clc

% compute grand averages

calc_gravg_SLIR_syntax_lpf20_ERP

clear all; clc

% topoplots of grand average
plot_gravg_SLIR_syntax_ERP_topoplot_new

% calculate all subjects
calc_allSubj_SLIR_syntax_6bins_ERP


% calculate differance waves - always violation minus correct so
% positivities will be positive
calc_difwave_SLIR_ERP