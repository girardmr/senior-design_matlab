clear;clc;
folder_files=dir('*.wav');

filename='folderfilename3.txt';
fid = fopen(filename,'w');

for j=1:size(folder_files,1)
    fprintf(fid,cat(2,folder_files(j).name,'\n'));
end

fclose(fid);