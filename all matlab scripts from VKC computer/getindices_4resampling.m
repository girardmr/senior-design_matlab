clear all; clc
%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
S{1}='dap_01'; S{2}='dap_02'; S{3}='dap_03';

%% define conditions % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY
bin{1}='loud_tone';
bin{2}='omit_tone';


for m=1:length(S) %for each subject
    suj=S{m};
    rand('state',sum(100*clock)); %reset random generator - once or inside loop??
    
    filename_omit = cat(2,suj,'_',bin{2},'_trials.mat')
    data_omit = load(filename_omit)
    clear data
    
    filename_loud = cat(2,suj,'_',bin{1},'_trials.mat')
    data_loud = load(filename_loud)
    clear data
    
    tri = randperm(size(data_loud.data.trial,2)); % random sequence of all of the trials in loud tones
    
    n = size(data_omit.data.trial,2); % change this to be the number of trials in the baseline that you want to match the condition to
    A = tri(1:n); % takes only the # of trials from omitted beats that match the # trials in the loud
    resamp_tri= sort(A);
    
    clear cond tri A data
    outfile = (cat(2,suj,'_trialindices_rs_loud_tone.mat'));
    save(outfile, 'resamp_tri')
    clear outfile resamp_tri
    
end

