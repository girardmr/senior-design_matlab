
clear all

S{1}='01';

% bin{1}='neutral';
% bin{2}='small_smile';
% bin{3}='big_smile';

for m=1:length(S)
    suj=S{m};
    bcifilename = cat(2,'tutorial_subj',suj,'.fil.seg.bci'); % bcr files are already rerefed to avg. mastoid
    
  
    fid = fopen(bcifilename);
%    C = textscan(fid, '%s %u %d8 %s %*[^\n]','HeaderLines',1); % only read first 4 cols then go to next line
    %C = textscan(fid, '%s %u %d8 %s', '%d8', 250, 'HeaderLines',1); % only read first 4 cols then go to next line
    C = textscan(fid, '%s %u %d8 %s ','%d8',250,'HeaderLines',1); % only read first 4 cols then go to next line

    B = textscan(fid, '%d8',250, 'HeaderLines',1);
    fclose(fid);
    
    
        bin = unique(C{1,1})% detect bins automatically by category names

 
    for b=1:length(bin)
        temp_ind= find (ismember(C{1,1}, bin{b})==1);
        data_info.(bin{b}).starttime = C{1,2}(temp_ind);
        data_info.(bin{b}).segperbin = C{1,3}(temp_ind);
        data_info.(bin{b}).status = C{1,4}(temp_ind);
        clear temp_ind
        
    end

        outfile= cat(2,'subj',suj,'_tut_trialinfo.mat')
        save(outfile,'data_info');
        clear data_info outfile
    
    
end

