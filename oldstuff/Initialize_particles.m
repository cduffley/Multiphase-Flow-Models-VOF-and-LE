function particlePos = Initialize_particles(Nx,Ny,mode)
    %Determines the coordinates for each particle.
    %Returns a nx2 matrix of particle coordinates
    switch mode
        case 1
            %Test Mode (1 Particle roughly in the middle)
            particlePos = zeros(Nx,Ny);
            xPos_test = ceil(0.5*Nx);
            yPos_test = ceil(0.5*Ny);
            particlePos(xPos_test,yPos_test) = 1;
            
        case 2
            %Normal Mode
            %Number of particles (From problem statement)
            sqrtn = 12;   %just for convenience
            n = 12^2;
            interval = floor(Nx/sqrtn);
            particlePos = zeros(Nx,Ny);
            particlePos(1,1) = 1;
            
            for j = 1:interval:Ny
                for i = 1:interval:Nx
                    particlePos(i,j) = 1;
                end
            end
            
        case 3
                %randomly generate number of particles (Don't know if this is necessary
                %or if we even care)
                
                %Number of particles (From problem statement)
                n = 5300;
                Nx = 100;
                Ny = 100;
                %Determine particle Coordinates
                xCoord = randi(Nx,n,1);
                yCoord = randi(Ny,n,1);
                %particleCoord = [xCoord yCoord];
                particlePos = zeros(Nx,Ny);
                
                for k = 1:n
                    particlePos(xCoord(k),yCoord(k)) = 1;
                end
                
        otherwise
            fprintf('Select 1,2,3\n')
            fprintf('1 for test\n')
            fprintf('2 for uniformly distributed particles\n')
            fprintf('3 for randomly distributed particles\n')
    end
end
