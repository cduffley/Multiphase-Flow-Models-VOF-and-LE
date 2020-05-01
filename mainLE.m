clear all;
clc;
%Run Time
t = input('Input simulation time:  ');     %seconds
%Time Step
dt = 10;     %seconds
currentTime = 0;

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
subplot(1,2,1)
[xPos,yPos] = InitPosition(n,mode);
scatter(xPos(),yPos())
title('Initial Particle Positions')
xlim([0 1])
ylim([0 1])

%Particle velocity at t = 0
initVelx = zeros(1,n);
initVely = zeros(1,n);

%Calculate Velocity and Position
%I think this needs calculated at every time step
maxit = 0;
while currentTime <= t && maxit <= 5000
    maxit = maxit + 1;
    [xPos,yPos] = ParticleVelocity(n,t,dt,xPos,yPos,initVelx,initVely);
    fprintf('Iteration: %d\n', maxit)
    currentTime = currentTime + dt;
end
%Output of function should be vectors of vectors [[parcel 1 pos at various times],[parcel 2 pos at various times],[parcel 3 pos at various times], ...]
% for j = 1:length(timeX)
%     for i=1:length(xPos)
%         xPos(i) = xPos(i) + velX*(timeX(i+1)-timeX(i));
%         yPos(i) = yPos(i) + velY*(timeY(i+1)-timeY(i));
%     end
% end

subplot(1,2,2)
scatter(xPos,yPos)
title('Final Particle Positions')
xlim([0 1])
ylim([0 1])