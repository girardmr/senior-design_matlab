% rlg october 2010
% this needs to be cross-checked extensively on real data!!
% make into a real matlab function??
% thanks to Wes Grantham for help with the code!
clear all
%specify subject data here
S{1}='08';


%%
for m=1:length(S)
    suj=S{m};
    %% change line here to fit with the filenames of your experiment
    bcifilename = cat(2,'subj',suj,'_chords_tut.bci'); %
    
    fid = fopen(bcifilename);
    
    headr = fgetl(fid);    % read in the header line (and ignore it)
    line1 = fgetl(fid);    % read in the first line of data
    ii = find(line1 == 9);   % get the position of the tab characters (separators in your data file)
    ntabs = length(ii);     % number of tabs
    n_total_columns = ntabs+1;   % total number of columns
    n_numeric_columns = n_total_columns - 5;   % number of "numeric" columns (all except first 4 and the last 1)
    chancols = repmat('%d8 ',1,n_numeric_columns);% columns containing channel data
    formatcol1234 = '%s %u %d8 %s '; %format of first four columns
    formatrestcol = [chancols  '%*[^\n]']; % go to next line after last channel column (skip last info)
    format = [formatcol1234 formatrestcol];
    frewind(fid);   % re-position file pointer
    C = textscan(fid, format,'HeaderLines',1); %
    fclose(fid);
    
    bin = unique(C{1,1})% detect bins automatically by category names
    
    TableChan = {};
    TableSegStatus = {};
    
    for b=1:length(bin)
        temp_ind= find (ismember(C{1,1}, bin{b})==1); %find row indices of this particular bin
        
        data_info.(bin{b}).starttime = C{1,2}(temp_ind);
        data_info.(bin{b}).segperbin = C{1,3}(temp_ind);
        data_info.(bin{b}).status = C{1,4}(temp_ind);
        
        % cycle through columns, which is all channels for each segment
        
        for seg = 1:length(data_info.(bin{b}).segperbin)
            %status = data_info.(bin{b}).status(seg)
            % all segment status - good and bad
            markstatus = {};
            markstatus{1,1} = 'segment';
            
            if strcmp('good',data_info.(bin{b}).status(seg)) == 1;
                markstatus{1,2} = 'good';
            elseif strcmp('bad',data_info.(bin{b}).status(seg)) == 1;
                markstatus{1,2} = 'bad';
            end
            
            markstatus{1,3} = cat(2,'{',bin{b},'}'); % category
            markstatus{1,4} = num2str(seg); % segment #
            TableSegStatus = [TableSegStatus; markstatus];
            clear markstatus
            
            % hint: "temp_ind(seg)" = the row number in the C cells for that segment
            for n=5:2:(length(C)-1) %odd columns are channel #'s
                %segcheck = C{1,3}(temp_ind(seg)); % segment # for that bin - stay on right row
                chan = C{1,n}(temp_ind (seg),1); % refers to channel column
                bcinfo = C{1,n+1}(temp_ind (seg),1); % refers to bad chan info for that channel
                data_info.(bin{b}).bciperseg{seg,1}(chan,1:2) = [chan bcinfo];
                % If channels have names and not numbers, this iwll have to be modified to something like:
                %%%%% chstr = num2str(chan);  data_info.(bin{b}).bciperseg{seg,1}.(chstr) = bcinfo;
                %y = y+1
                
                if bcinfo == 0; %if this chan info says bad  CHECK assignment!!
                    marks= {};
                    marks{1,1} = 'channel';
                    marks{1,2} = 'bad';
                    %elseif bcinfo == 1 % if this chan info says good
                    %marks{1,2} = 'good';
                    
                    marks{1,3} = num2str(chan);
                    marks{1,4} = cat(2,'{',bin{b},'}');
                    marks{1,5} = num2str(seg);
                    TableChan = [TableChan; marks];
                    clear marks
                end
            end
            
            clear chan bcinfo
        end
    end
    clear temp_ind
    
    %% change name of output file here
    markupfilename=cat(2,'MarkupBCI_chordsTut_suj',suj,'.txt')
    fid = fopen(markupfilename,'w');
    %write results to a space-delimited output file that can be read into
    %Markup format in EGI
    for row= 1:length(TableChan)
        fprintf(fid, '%s %s %s %s %s \n', TableChan{row,:});
    end
    
    fid = fopen(markupfilename,'a'); % append to what we just wrote

    for row2= 1:length(TableSegStatus)
        fprintf(fid, '%s %s %s %s \n', TableSegStatus{row2,:});
    end    
    
    outfile= cat(2,'subj',suj,'_tut_trialinfo.mat') % also save .mat structure in case you need further matlab manipulations
    save(outfile,'data_info');
    
    clearvars -except S  m
    
    
end

