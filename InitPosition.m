function [xCoord, yCoord] = InitPosition(n, mode)
%Function that lists the x and y coordinates of all n particles for an
%initial position. Development of particles is dependent on the mode of
%distribution with 1 being a test mode, 2 being a uniform distribution, and
%3 being a random distribution. 
xCoord = zeros(1,n);
yCoord = zeros(1,n);

switch mode
    case 1
        %Test Mode (1 Particle roughly in the middle)
        %particlePos = zeros(Nx,Ny);
        xCoord = 0.5;
        yCoord = 0.5;
    case 2
        %Uniform Distribution
        sqrtn = sqrt(n);
        %Limits prevent placing of particles near the boundary, which later
        %causes issues in velocity calculations
        x = linspace(0.001,0.999,sqrtn);
        y = linspace(0.001,0.999,sqrtn);
        
        for i=1:length(x)
            for j=1:length(y)
                xCoordinate(i,j) = x(i); 
                yCoordinate(i,j) = y(j);
            end
        end
        
        xCoord = reshape(xCoordinate,[],1)';
        yCoord = reshape(yCoordinate,[],1)';
        
        
    case 3
        %Random Distribution
        %Limits prevent placing of particles near the boundary, which later
        %causes issues in velocity calculations
        xCoord = 0.0001 + (1-0.0001)*rand(1,n);
        yCoord = 0.0001 + (1-0.0001)*rand(1,n);
end
end