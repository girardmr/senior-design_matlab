S{1}='HM32'; S{2}='HM41'; S{3}='HM42'; S{4}='HM43'; S{5}='HM44'; S{6}='HM47';
S{7}='HM48'; S{8}='HM62'; S{9}='HM90'; 

%epoch2time = 30363 % epoch #2 starts - (normally this will be read from one entry in a .mat file)

for m=1:length(S)
    suj=S{m};
    
    epoch.(suj) = times(m)
    
end
