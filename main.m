clear 
clc
close all
% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------


% currently the algorthim fails if the circle falls exactly on the 
% line or corner (try Nx=Ny=11). also for uneven meshes.
Nx =33;
Ny = Nx;
x_pos = 0.5;
y_pos = 0.75;
r = 0.15;
x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
h = y(3) - y(2);
[X,Y] = meshgrid(x,y);
T = 2;

% circle stuff
% cir_dis = 0:pi/100:2*pi; %decrease step size for more exact circle plot
% xcir = 0.15 * cos(cir_dis) + 0.5;
% ycir = 0.15 * sin(cir_dis) + 0.75;
% plot(xcir,ycir)
% hold on
% for i = 1:Nx
%     plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
%     plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
% end

%initalizing circle, initial mx,my and reconstruction
[C,cir_xloc_x,cir_yloc_y,cir_xloc_y,cir_yloc_x] = ...
        circle_init(x,y,h,x_pos,y_pos,r);
[mx,my] = youngsFD(h,x,y,C);
% [Cr,xleft,xright,yleft,yright,alpha] = reconstruct(x,y,h,mx,my,C);
[Cr,xleft,xright,yleft,yright,alpha] = reconstruction_test(x,y,h,mx,my,C);

t = linspace(0,T,100);
t = t(2:end); %getting rid of inital value (no advection at the time)
dt = t(3)-t(2);



for i =1:1
u = -2.*cos(pi.*t(i)./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
u = 1.*X;
v = 2.*cos(pi.*t(i)./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);
v = 0.*X;
[Cr,xleft,xright,yleft,yright,mx,my,alpha] = advectionTot(x,y,h,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,Cr);

end

% b = Y - (X+alpha./mx)*slope; %wont work for mx=0



% test C values (page 96)

% C = [0,0.02,.1;...
%    0.2, 0.8,1;...
%    0.7, 1,1];

xgrid = linspace(0,3,4);
ygrid = xgrid;
% figure
% hold on
% for i = 1:length(xgrid)
%     plot(ones(1,length(xgrid))*xgrid(i),ygrid,'k','Linewidth',0.25)
%     plot(xgrid,ones(1,length(ygrid))*ygrid(i),'k','Linewidth',0.25)
% end
linex = linspace(xgrid(2), xgrid(3),10);
% liney = slope*linex + b;
% % plot(linex,liney)
% cch = ((0.802 - 0.5)/2 * (0.852-0.5))/(0.5^2);


% current graph stuff
cir_xloc_x = [cir_xloc_x,cir_xloc_x];
cir_yloc_y = [cir_yloc_y,cir_yloc_y];
% plot(cir_xloc_x,cir_xloc_y,'o')
% plot(cir_yloc_x,cir_yloc_y,'o')


T = 2;
t = T/2; %this is for book example, deliverable 2 has t = T/pi
PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;

u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

