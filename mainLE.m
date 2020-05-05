clear all;
clc;

%Run Parameter Prompt
prompt = {'Run Time (0-1)','Time Step  [pi/(time step)]', '# of Parcels', 'Reynolds #', 'Stokes #'};
dlgtitle = 'Input';
dims = [1 40];
definput = {'1','100','144', '100', '0.2'};
params = inputdlg(prompt,dlgtitle,dims,definput);

%Convert Cell Array Values to Scalar Values
%Extract Run Time
t = str2double(params{1});
t = t*pi;
%Extract Time Step
dt = str2double(params{2});
dt = pi/dt;
%Extract Number of Parcels
n = str2double(params{3});
%Extract Reynolds Number
Re = str2double(params{4});
%Extract Stokes Number
St = str2double(params{5});

%%%%%%%%%%%Run Time
%%%%%%%%%%%t = input('Input simulation time:  ');     %seconds
%Time Step
%%%%%%%%%%%dt = 1;     %seconds
currentTime = 0;

%Grid size (Only effects Uniform Distribution at the moment)
Nx = 33;
Ny = 33;
%Input number of parcels
%%%%%%n = input('Choose number of parcels: ');

%If no input specified, defaults to 12^2 parcels
%%%%%%%%%if isempty(n)
%%%%%%%%%%    n = 12^2;
%%%%%%%%%%end
%One particle roughly in middle
%mode = 1;
%Uniform Distribution of particles
%mode = 2;
%Random Distribution of particles
%mode = 3;

%Choose run mode
list = {'Single Parcel', 'Uniform', 'Random'};
[mode,tf] = listdlg('PromptString',{'Select run mode',''}, 'SelectionMode', 'single','ListString',list);

%Call initialization function (uncomment subplot line when finished)
subplot(2,2,1)
[xPos,yPos] = InitPosition(n,mode);
xPosInit = xPos;
yPosInit = yPos;
scatter(xPosInit(),yPosInit())
title('Initial Parcel Positions')
xlim([0 1])
ylim([0 1])

%Particle velocity at t = 0
initVelx = zeros(1,n);
initVely = zeros(1,n);

%Calculate Velocity and Position
%I think this needs calculated at every time step
maxit = 0;
%initialize parcel velocities
uVel = initVelx;
vVel = initVely;
while currentTime <= t && maxit <= 5000
    maxit = maxit + 1;
    [xPos,yPos, uVel, vVel] = ParticleVelocity(n,t,dt,xPos,yPos,uVel,vVel, Re, St);
    fprintf('Iteration: %d\n', maxit)
    currentTime = currentTime + dt;
end

%Plot Final parcel positions
subplot(2,2,2)
scatter(xPos,yPos)
title('Final Parcel Positions')
xlim([0 1])
ylim([0 1])

%Choose 100 random parcels
xIndex = ceil(length(xPos)*rand(1,100));
yIndex = ceil(length(yPos)*rand(1,100));
xPosInit_100 = zeros(1,length(xIndex));
yPosInit_100 = zeros(1,length(yIndex));
xPos_100 = zeros(1,length(xIndex));
yPos_100 = zeros(1,length(yIndex));

for z = 1:length(xIndex)
    xPosInit_100(z) = xPosInit(xIndex(z));
    yPosInit_100(z) = yPosInit(yIndex(z));
    
    xPos_100(z) = xPos(xIndex(z));
    yPos_100(z) = yPos(yIndex(z));
end

%Plot 100 randomly selected initial parcels
subplot(2,2,3)
scatter(xPosInit_100,yPosInit_100)
title('100 Initial Parcel Positions')
xlim([0 1])
ylim([0 1])

%Plot 100 randomly selected parcels
subplot(2,2,4)
scatter(xPos_100,yPos_100)
title('100 Final Parcel Positions')
xlim([0 1])
ylim([0 1])