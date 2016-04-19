clear;clc;
folder_files=dir('*.wav');

D=[];
for j=1:size(folder_files,1)
[Y,FS,NBITS]=wavread(folder_files(j).name);
d=size(Y,1)*1000/FS;
D=[D;d];
end
