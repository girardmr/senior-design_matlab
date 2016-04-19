clear all
% maybe send Slava the sfp file and the prepare_layout code.
% and other plotting functions?
% explain that my scripts use many fieldtrip functions to plot


load soprochan_3D_coord.mat
%For example, this will convert 3-D coordinates (loc) to polar (xpK):
loc=Loc3D;

[phi, theta, r]=cart2sph(loc(:,1),loc(:,2),loc(:,3)); % because they are in rows
theta=pi/2-theta;
xpK=theta.*cos(phi);
ypK=theta.*sin(phi);

%The following is plotting the "butterfly plot" where "Potential" contains your color data (scaled according to your colormap) for the electrodes specified in "loc":

tri = delaunay(xpK,ypK);
tsf = trisurf(tri,xpK,ypK,zeros(1,length(xpK)),'FaceVertexCData',Potential(:), 'Edgecolor','none','FaceColor','interp','CDataMapping','direct');
axis equal;
axis off;
view([0,0,10]);

%If you want to spread out the central electrodes, 
%you need to apply some sort of transformation in the first step above. I am still thinking about it.

% Slava



% Making new mask file
%load soprolay_noCz.lay.mat;
% newmask = soprolay_noCz.mask
% A=cell2mat(newmask)
% [TH,R] = cart2pol(A(:,1),A(:,2));
% clear newmask
% [x,y] = pol2cart(TH,R+0.125);
% 
% newmask = [x y];
% soprolay_noCz.mask {1,1}= newmask;
% soprolay_noCzwithnewmask = soprolay_noCz;
% save soprolay_noCzwithnewmask.mat soprolay_noCzwithnewmask