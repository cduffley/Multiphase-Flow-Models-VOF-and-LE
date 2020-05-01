function [u,v] = CarrierVelocity(x,y)
%Function for determining the carrier fluid velocity at parcel locations.

% NX = 100;
% NY = NX;
% xa = linspace(0,1,NX);
% ya = linspace(0,1,NY);
% [X,Y] = meshgrid(xa,ya);
% 
% %For Quiver Plot
% uPlot = 2*(sin(pi*X).^2).*(sin(pi*Y).*cos(pi*Y));
% vPlot = 2*(sin(pi*X).*cos(pi*X)).*(sin(pi*Y).^2);

%streamfcn = (1/pi)*(sin(pi*x)^2).*(sin(pi*y)^2);
u = 2*(sin(pi*x).^2).*(sin(pi*y).*cos(pi*y));
v = 2*(sin(pi*x).*cos(pi*x)).*(sin(pi*y).^2);

%quiver(X,Y,uPlot,vPlot)