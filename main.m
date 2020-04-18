%git test
%i definitely dont understand the project yet so 
%im gonna play around and see if i can get something going

% interface tracking test for deliverable number 2
clear 
clc
Nx =33;
Ny = 33;

x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
[X,Y] = meshgrid(x,y);

T = 2;
t = T/2; %this is for book example, deliverable 2 has t = T/pi
PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;
% okay so intgertaing this funtion will give us our
% x and y velocities (he wants this done analytically)
% so does this mean that the resulting velocities 
% are our color function? or at least used instead of a
% color funtion?

u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

quiver(X,Y,u,v)







