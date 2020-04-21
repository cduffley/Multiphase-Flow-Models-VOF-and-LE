clear 
clc

% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------



Nx =33;
Ny = 33;
x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
h = y(3) - y(2);
[X,Y] = meshgrid(x,y);

%% circle stuff
cir_dis = 0:pi/50:2*pi; %decrease step size for more exact circle
xcir = 0.15 * cos(cir_dis) + 0.5;
ycir = 0.15 * sin(cir_dis) + 0.75;
plot(xcir,ycir)
hold on
for i = 1:Nx
    plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
    plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
end

x_pos = 0.5;
y_pos = 0.75;
r = 0.15;

j=1;
for i = 1:length(x)
    if x(i) > x_pos-r && x(i) < x_pos+r
        cir_xloc_x(j) = x(i);
        xnode(j) = i;
        j=j+1;
    end
end

cir_xloc_y1 = -(-((cir_xloc_x-x_pos).^2 - r^2)).^(1/2) + y_pos;
cir_xloc_y2 = (-((cir_xloc_x-x_pos).^2 - r^2)).^(1/2) + y_pos;
cir_xloc_y = [cir_xloc_y1,cir_xloc_y2];
cir_xloc_x = [cir_xloc_x,cir_xloc_x];
% xnode = [xnode];

for i=1:length(xnode)
    for j=1:length(x)-1
    if y(j) < cir_xloc_y1(i) && y(j+1) > cir_xloc_y1(i)
    ynodefromx1(i) = j;
    end
    if y(j) < cir_xloc_y2(i) && y(j+1) > cir_xloc_y2(i)
    ynodefromx2(i) = j;
    end
    end
end

j=1;
for i = 1:length(y)
    if y(i) > y_pos-r && y(i) < y_pos+r
        cir_yloc_y(j) = y(i);
        ynode(j) = i;
        j=j+1;
    end
end

cir_yloc_x2 = (-((cir_yloc_y-y_pos).^2 - r^2)).^(1/2) + x_pos;
cir_yloc_x1 = -(-((cir_yloc_y-y_pos).^2 - r^2)).^(1/2) + x_pos;
cir_yloc_x = [cir_yloc_x1,cir_yloc_x2];
cir_yloc_y = [cir_yloc_y,cir_yloc_y];
% ynode = [ynode,ynode];

for i=1:length(ynode)
    for j=1:length(y)-1
    if x(j) < cir_yloc_x1(i) && x(j+1) > cir_yloc_x1(i)
    xnodefromy1(i) = j;
    end
    if x(j) < cir_yloc_x2(i) && x(j+1) > cir_yloc_x2(i)
    xnodefromy2(i) = j;
    end
    end
end

plot(cir_xloc_x,cir_xloc_y,'o')
plot(cir_yloc_x,cir_yloc_y,'o')

C = CFDsemiTrapzoid(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y);

%i_xy - xvalues from y
%cir_yloc_x1 is the left side
% bottom left
isdoubletri = false;
for i_xy=1:length(cir_yloc_x1)
    
    for i_xx=1:length(cir_xloc_y2)-1 %was cir_xloc_x,too long
    
        if cir_yloc_x1(i_xy) > cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy) < cir_xloc_x(i_xx+1)
            
             isdoubletri = true;
             i_xxhold = i_xx;
        end 
    end
    if isdoubletri == true
        % small tri, on 'right'
    linear_distance = ((cir_yloc_x1(i_xy)- cir_xloc_x(i_xxhold+1))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y1(i_xxhold+1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy1(i_xy)+1) - cir_yloc_x1(i_xy))/2 * abs( y(ynodefromx1(i_xxhold))...
                - cir_xloc_y1(i_xxhold+1));
    area = area_tri + area_sliver;
    C(xnodefromy1(i_xy),ynode(i_xy)-1) = area/h^2;
    
    
        % cut rect, one the 'left'
    linear_distance = ((cir_yloc_x1(i_xy)- cir_xloc_x(i_xxhold))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y1(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy1(i_xy)) - cir_yloc_x1(i_xy))/2 * abs( y(ynodefromx1(i_xxhold))...
                - cir_xloc_y1(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(xnodefromy1(i_xy),ynode(i_xy)) = area/h^2;
    
    % last triangle 'way left'
    diff = cir_xloc_x(1) - cir_yloc_x1;
    diff(diff<0) = 10;
    [m,i_min] = min(diff);
    
    isdoubletri = false;
    else
       isdoubletri = false;   
    end   
end







T = 2;
t = T/2; %this is for book example, deliverable 2 has t = T/pi
PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;

u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

figure
quiver(X,Y,u,v)
% C = (u.^2 + v.^2).^(1/2);




