% rlg october 2010
% this needs to be cross-checked extensively on real data!!
clear all

S{1}='01';
nChan = 125;


chancols = repmat('%d8 ',1,(2*nChan));

formatcol1234 = '%s %u %d8 %s ';
formatrestcol = [chancols  '%*[^\n]']; % go to next line after last channel column (skip last info)
format = [formatcol1234 formatrestcol];

%%
for m=1:length(S)
    suj=S{m};
    bcifilename = cat(2,'tutorial_subj',suj,'.fil.seg.bci'); % bcr files are already rerefed to avg. mastoid
    
    fid = fopen(bcifilename);
    
    %C = textscan(fid, '%s %u %d8 %s %*[^\n]','HeaderLines',1); % only read first 4 cols then go to next line
    %C = textscan(fid, '%s %u %d8 %s', '%d8', 250, 'HeaderLines',1); %
    C = textscan(fid, format,'HeaderLines',1); % only read first 4 cols then go to next line
    
    %B = textscan(fid, '%d8',250, 'HeaderLines',1);
    fclose(fid);
    
    
    bin = unique(C{1,1})% detect bins automatically by category names
    
    Table = [];
    for b=1:length(bin)
        temp_ind= find (ismember(C{1,1}, bin{b})==1); %find row indices of this particular bin
        
        data_info.(bin{b}).starttime = C{1,2}(temp_ind);
        data_info.(bin{b}).segperbin = C{1,3}(temp_ind);
        data_info.(bin{b}).status = C{1,4}(temp_ind);
        
        %cycle through columns, which is all channels for each segment
        %
        for seg = 1:length(data_info.(bin{b}).segperbin)
            
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
                    marks
                    Table = [Table; marks];
                    clear marks
                end
            end
            
            clear chan bcinfo
        end
    end
    clear temp_ind
    
    
    markupfilename=cat(2,'MarkupBCI_Tut_suj',num2str(suj),'.txt')
    fid = fopen(markupfilename,'w');
    
    for row= 1:length(Table)
        fprintf(fid, '%s %s %s %s %s\n', Table(row,:));
    %dlmwrite(markupfilename,Table,'delimiter','\t','precision',8) %delimiter is space; can be changed to tab
    end
    
    outfile= cat(2,'subj',suj,'_tut_trialinfo.mat')
    save(outfile,'data_info');
    
    clearvars -except S chancols format* nChan m
    
    
end

