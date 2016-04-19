function s = statfun_behcorr(cfg, dat, design)

% mean subtract
mdat = mean(dat,2);
dat = dat - mdat(:,ones(1,size(dat,2)));

mdesign = mean(design);
design = design - mean(design);

% covariance
covdat = dat*design';

% variance
vdat = sum(dat.^2,2);
vdes = sum(design.^2);

% correlation
s.stat = covdat./sqrt(vdat.*vdes);
