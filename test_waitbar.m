clc;
clear all;
close all;

matrix = rand(200,500);

w = waitbar(0, 'Please wait');
n=0;
for ii = 1:200
    for jj = 1:500
        n=n+1;
        matrix2(ii,jj) = matrix(ii,jj)+3;
        waitbar(n/numel(matrix));
    end
end
close(w);


ww = waitbar(0, ['Matrix element 0/', num2str(numel(matrix))]);
nn=0;
for aa = 1:200
    for bb = 1:500
        nn=nn+1;
        matrix_2(aa,bb) = matrix(aa,bb)+3;
        waitbar(nn/numel(matrix), ww, ['Matrix element ', num2str(nn), '/', num2str(numel(matrix))]);
    end
end
close(ww);
