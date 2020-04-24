clear 
clc

% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------


% currently the algorthim fails if the circle falls exactly on the 
% line or corner (try Nx=Ny=11). also for uneven meshes.
Nx =333;
Ny = Nx;
x_pos = 0.5;
y_pos = 0.75;
r = 0.15;
x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
h = y(3) - y(2);
[X,Y] = meshgrid(x,y);

%% circle stuff
cir_dis = 0:pi/100:2*pi; %decrease step size for more exact circle plot
xcir = 0.15 * cos(cir_dis) + 0.5;
ycir = 0.15 * sin(cir_dis) + 0.75;
plot(xcir,ycir)
hold on
for i = 1:Nx
    plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
    plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
end

[C,cir_xloc_x,cir_yloc_y,cir_xloc_y,cir_yloc_x] = ...
        circle_init(x,y,h,x_pos,y_pos,r);

%% for the reconstruct function

% test C values (page 96)
C = [0,0.02,0.1;0.2,0.8,1;0.7,1,1];
% corresponding test x , y and h values
x = linspace(0,1,3);
y = x;
h = x(2)-x(1);
% Calculation of x and y components of normal vector
[mx,my] = youngsFD(h,x,y,C);

tol = 1e-5;
max_it = 100000; 
err = 1;
num_it=0;
alpha_guess=1;
mx = mx(2,2);
my=my(2,2);
C = C(2,2);
while abs(err) > tol && num_it <= max_it

Area = Alpha(mx,my,h,alpha_guess,C);

err1 = abs(Area - C*h^2);
alpha_guess1 = alpha_guess;
area1 = Area;
alpha_guess = alpha_guess *1.01;

Area = Alpha(mx,my,h,alpha_guess,C);

err2 = abs(Area - C*h^2);
area2 = Area;
alpha_guess2 = alpha_guess;

alpha_new = alpha_guess1 - err1/((err1-err2)/(alpha_guess1-alpha_guess2));
alpha_guess = alpha_new;
num_it = num_it+1;
err = err1;
alpha = alpha_new;
end
figure
hold on
for i = 1:length(x)
    plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
    plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
end


slope = -1/(mx^2 + my^2)^(1/2);
delx = alpha/mx;
dely = alpha/my;

slpch = dely/delx;






%% current graph stuff
cir_xloc_x = [cir_xloc_x,cir_xloc_x];
cir_yloc_y = [cir_yloc_y,cir_yloc_y];
% plot(cir_xloc_x,cir_xloc_y,'o')
% plot(cir_yloc_x,cir_yloc_y,'o')


T = 2;
t = T/2; %this is for book example, deliverable 2 has t = T/pi
PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;

u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

% figure
% quiver(X,Y,u,v)
% C = (u.^2 + v.^2).^(1/2);




