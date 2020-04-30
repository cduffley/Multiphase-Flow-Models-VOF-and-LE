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

%Call initialization function (uncomment subplot line when finished)
%subplot(1,2,1)
[xPos,yPos] = InitPosition(n,mode);
scatter(xPos(),yPos())
title('Initial Particle Positions')
xlim([0 1])
ylim([0 1])

%Calculate Velocity and Position
%I think this needs calculated at every time step
% for i=1:length(xCoord)
%     vel = ParticleVelocity();
%     xPos(i) = velX*dt;
%     yPos(i) = velY*dt;
% end

% subplot(1,2,2)
% scatter(xPos(:),yPos(:))
% title('Final Particle Positions')
% xlim([0 1])
% ylim([0 1])