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
h = y(3) - y(2);
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
C = (u.^2 + v.^2).^(1/2);

%were gonna skip corners, just a test
% commented out is using velocity magnitude
% non commented out is using u and v values
% neither make sense based on definition of youngs fd
for i = 2:length(x)-1
    for j = 2:length(x)-1
        
%     mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
%     my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
%     
%     mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
%     my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
%     
%     mx3 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
%     my3 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
%     
%     mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
%     my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
    
    mx1 = -1/(2*h) .*( u(i+1,j+1) + u(i+1,j) - u(i,j+1) - u(i,j) );
    my1 = -1/(2*h) .*( v(i+1,j+1) - v(i+1,j) + v(i,j+1) - v(i,j) );
    
    mx2 = -1/(2*h) .*( u(i,j+1) + u(i,j) - u(i-1,j+1) - u(i-1,j) );
    my2 = -1/(2*h) .*( v(i,j+1) - v(i,j) + v(i-1,j+1) - v(i-1,j) );
    
    mx3 = -1/(2*h) .*( u(i+1,j) + u(i+1,j-1) - u(i,j) - u(i,j-1) );
    my3 = -1/(2*h) .*( v(i+1,j) - v(i+1,j-1) + v(i,j) - v(i,j-1) );
    
    mx4 = -1/(2*h) .*( u(i,j) + u(i,j-1) - u(i-1,j) - u(i-1,j-1) );
    my4 = -1/(2*h) .*( v(i,j) - v(i,j-1) + v(i-1,j) - v(i-1,j-1) );

    m1 = (mx1^2 + my1^2)^(1/2);
    m2 = (mx2^2 + my2^2)^(1/2);
    m3 = (mx3^2 + my3^2)^(1/2);
    m4 = (mx4^2 + my4^2)^(1/2);
    m(i,j) = (m1+m2+m3+m4)/4;
    
    end
end




