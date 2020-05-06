clear 
clc
close all
% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------

% N, cicle x, y, r,
% final time, # num of steps (suggested)
% grid lines?

% The algorthim fails if the circle falls exactly on the 
% line or corner (Nx=Ny=11). It also may fail for uneven meshes.
Nx =33; Ny = Nx;
x_pos = 0.5; y_pos = 0.75; r = 0.15;
x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
h = y(3) - y(2);
[Y,X] = meshgrid(x,y);
T = 2;

%initalizing circle, initial mx,my and reconstruction
[C,cir_xloc_x,cir_yloc_y,cir_xloc_y,cir_yloc_x] = ...
        circle_init(x,y,h,x_pos,y_pos,r);
[mx,my] = youngsFD(h,x,y,C);
[Cr,xleft,xright,yleft,yright,alpha] = reconstruction_test(x,y,h,mx,my,C);

t = linspace(0,1,10); % If Cnew and CnewX or Y causes error, 
                      % the step size is too small
t = t(2:end); %getting rid of inital value (no advection at the time 0)
dt = t(2)-t(1); %delta t

for i =1:length(t)
u = -2.*cos(pi.*t(i)./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);

v = 2.*cos(pi.*t(i)./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

[Cr,xleft,xright,yleft,yright,mx,my,alpha] = advectionTot(x,y,h,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,Cr);

end

%creating figure for new interface 

figure 
hold on
for i=1:length(Cr)
    for j = 1:length(Cr)
        if i==21 && j ==28
            g = 4;
        end
        if Cr(i,j) >= 1e-12 && (my(i,j) > 1e-15 || my(i,j) < -1e-15)
            slope(i,j) = -1/(my(i,j) / mx(i,j));
            b(i,j,:) = yleft(i,j) - slope(i,j)*(xleft(i,j));
            xline(i,j,:) = linspace(xleft(i,j), xright(i,j),10);
            yline(i,j,:) = slope(i,j)*xline(i,j,:) + b(i,j,:);
            xp = zeros(1,10);
            yp = zeros(1,10);
            xp(:) = xline(i,j,:);
            yp(:) = yline(i,j,:);
            plot(xp,yp,'k','LineWidth',1.1)
        end
        
    end
end
% circle graph
cir_dis = 0:pi/100:2*pi; %decrease step size for more exact circle plot
xcir = 0.15 * cos(cir_dis) + 0.5;
ycir = 0.15 * sin(cir_dis) + 0.75;
plot(xcir,ycir)

%plotting grid lines
hold on
for i = 1:Nx
    plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
    plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
end
title('VOF Interface Tracking')



%% Plot of inital circle with intersection coloring
% if you wish to see the patterns we are talking about in circle_init, you
% should keep grid lines on as well
% cir_xloc_x = [cir_xloc_x,cir_xloc_x];
% cir_yloc_y = [cir_yloc_y,cir_yloc_y];
% plot(cir_xloc_x,cir_xloc_y,'o')
% plot(cir_yloc_x,cir_yloc_y,'o')


%% quiver plot if you wish to check velocity:
% t = 2;
% PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;
% t=0;
% u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
% v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);
% figure
% quiver(X,Y,u,v)


