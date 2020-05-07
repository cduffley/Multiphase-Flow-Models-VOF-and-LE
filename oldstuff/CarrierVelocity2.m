function [u,v] = CarrierVelocity2(xPos,yPos,Nx,Ny)
%Function for determining the carrier fluid velocity at parcel locations.
%Discretizes the carrier fluid velocity based on x and y locations
%Determines the grid position of the fluid particle

x_loc = floor(xPos * Nx);
y_loc = floor(yPos * Ny);

uvel = linspace(0,0,length(x_loc));
vvel = linspace(0,0,length(y_loc));
    
x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
[X,Y] = meshgrid(x,y);
h = x(3)-x(2);

Stream = (1/pi)*(sin(pi*X)^2).*(sin(pi*Y)^2);

uvel_profile = zeros(length(x));
vvel_profile = zeros(length(y));

for i = 1:length(x)
    for j = 1:length(y)
        if i==1 && j==1
            % Top left corner of matrix (lower-left corner of geometry)
            % Use of forward diff for borth uvel and vvel
            uvel_profile(i,j) = (Stream(i,j+1)-Stream(i,j))/(h);
            vvel_profile(i,j) = (Stream(i+1,j)-Stream(i,j))/(h);
            
        elseif i==1 && j==length(y)
            % Top right corner of matrix (upper-left corner of geometry)
            % Use of backward diff for uvel, forward diff for vvel
            uvel_profile(i,j) = (Stream(i,j)-Stream(i,j-1))/(h);
            vvel_profile(i,j) = (Stream(i+1,j)-Stream(i,j))/(h);
            
        elseif i==length(x) && j==1
            % Bottom left corner of martix (lower-right corner of geometry)
            % Use of forward diff for uvel, backward diff for vvel
            uvel_profile(i,j) = (Stream(i,j+1)-Stream(i,j))/(h);
            vvel_profile(i,j) = (Stream(i,j)-Stream(i-1,j))/(h);
            
        elseif i==length(x) && j==length(y)
            % Bottom right corner of matrix (upper-right corner of geometry)
            % Use of backward diff for both uvel and vvel
            uvel_profile(i,j) = (Stream(i,j)-Stream(i,j-1))/(h);
            vvel_profile(i,j) = (Stream(i,j)-Stream(i-1,j))/(h);
            
        elseif i==1
            % Top side of matrix (leftmost boundary of geometry)
            % Use of central diff for uvel, forward diff for vvel
            uvel_profile(i,j) = (Stream(i,j+1)-Stream(i,j-1))/(2*h);
            vvel_profile(i,j) = (Stream(i+1,j)-Stream(i,j))/(h);
            
        elseif i==length(x)
            % Bottom side of matrix (rightmost boundary of geometry)
            % Use of central diff for uvel,backward diff for vvel
            uvel_profile(i,j) = (Stream(i,j+1)-Stream(i,j-1))/(2*h);
            vvel_profile(i,j) = (Stream(i,j)-Stream(i-1,j))/(h);
            
        elseif j==1
            % Left side of matrix (bottommost boundary of geometry)
            % Use of central diff for vvel, forward diff for uvel
            uvel_profile(i,j) = (Stream(i,j+1)-Stream(i,j))/(h);
            vvel_profile(i,j) = (Stream(i+1,j)-Stream(i-1,j))/(2*h);
            
        elseif j==length(y)
            % Right side of matrix (topmost boundary of geometry)
            % Use of central diff for vvel, forward diff for uvel
            uvel_profile(i,j) = (Stream(i,j)-Stream(i,j-1))/(h);
            vvel_profile(i,j) = (Stream(i+1,j)-Stream(i-1,j))/(2*h);
            
        else
            % Points in between the outermost boundaries
            % Use of central difference method for discretizing velocity
            uvel_profile(i,j) = (Stream(i,j+1)-Stream(i,j-1))/(2*h);
            vvel_profile(i,j) = (Stream(i+1,j)-Stream(i-1,j))/(2*h);
        end

    end
end

for i = 1:length(uvel)
     if x_loc(i)==0 && y_loc(i)==0
        x_loc(i) = 2;
        y_loc(i) = 2;
    end
    if x_loc(i)==0
        x_loc(i) = 1;
    end
    if y_loc(i)==0
        y_loc(i) = 1;
    end
        uvel(i) = uvel_profile(x_loc(i),y_loc(i));
        vvel(i) = vvel_profile(x_loc(i),y_loc(i));
end

u = uvel; 
v = vvel; 

end
