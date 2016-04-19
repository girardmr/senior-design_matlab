% convert times from spreadsheet video coding to fit with EEG recordings
% for infant coherence project
% 
% then open up evt file in Excel and save in tab-delimited format
clear all; clc

%% define subjects % CUT AND PASTE FROM PRIOR SCRIPTS IN DATASET TO ENSURE CONSISTENCY

S{1} ='HM19'; S{2}='HM32'; S{3}='HM42'; S{4}='HM43'; S{5}='HM47';
S{6} ='HM48'; S{7}='HM62'; S{8}='HM66'; S{9}='HM90'; 

%load HMepochtimes.mat
% don't need to adjust for epoch time anymore.

%baselinestart{1} = '0'; baselinestart{2} = 'base'; 

for m=1:length(S)
    suj=S{m};
    filename = cat(2,suj,'_task.txt');
    
    
    codeddata = importdata(filename)
    
    % column 1 is time (sec). %col 2 is trial #. % col #3 is start/end.
    % col#4 is attention level.
    numtrials = max(codeddata.data(:,2))
    
    %epoch2time = (epoch.(suj))*1000 % do not do this anymore
    Table = {};
    
    for n = 1: numtrials
        % odd lines are start times
        linenum = ((n*2) -1)
        starttime  = (codeddata.data(linenum,1))*1000 % time in ms from col #1
        trial = codeddata.data(linenum,2)
        attntype = codeddata.data(linenum,4) % attn type from col#4
        start_corr = starttime %+ no need to correct starting time by adding time of epoch #2 marker
        
        tag = cat(2,'s_a',num2str(attntype))
        
        marks = {}; % make cell structure
                
        marks{1,1} = num2str(start_corr)
        marks{1,2} = tag
        Table = [Table; marks]
        
        % even lines are end times
        endtime = (codeddata.data((linenum+1)))*1000 % time in ms
        endtime_corr = endtime % no need to correct starting time by adding epoch2time
        
        markend{1,1} = num2str(endtime_corr)
        markend{1,2} = 'entr';
        Table = [Table; markend]
        
        clear mark markend tag attntype starttime start_corr
    end
    
    markupfilename=cat(2,suj,'_task.evt') % can use for batch if same filename as EEG raw +.evt
    fid = fopen(markupfilename,'w');
    %write results to a space-delimited output file that can be read into
    %Markup format in EGI
%    take out this line: fprintf(fid, '%s %s \n', baselinestart{1,:})
    
    for row= 1:size(Table,1)
        fprintf(fid, '%s\t%s\n', Table{row,:});
    end
    
%     fid = fopen(markupfilename,'a'); % append to what we just wrote
% 
%     for row2= 1:size(TableSegStatus,1)
%         fprintf(fid, '%s %s %s %s \n', TableSegStatus{row2,:});
%     end    
    
%     outfile= cat(2,suj,'_trialinfo.mat') % also save .mat structure in case you need further matlab manipulations
%     save(outfile,'data_info');
    
    clearvars -except S  m %epoch  
    
    
    
end

