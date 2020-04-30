clear all;
clc;

%Grid size (Only effects Uniform Distribution at the moment)
Nx = 33;
Ny = 33;
%Input number of parcels
n = input('Choose number of parcels: ');
%If no input specified, defaults to 12^2 parcels
if isempty(n)
    n = 12^2;
end
%One particle roughly in middle
%mode = 1;
%Uniform Distribution of particles
%mode = 2;
%Random Distribution of particles
%mode = 3;
%Choose run mode
mode = menu('Choose run mode','test','uniform','random');

%Call initialization function
[xPos,yPos] = InitPosition(n,mode);
scatter(xPos(:),yPos(:))
xlim([0 1])
ylim([0 1])