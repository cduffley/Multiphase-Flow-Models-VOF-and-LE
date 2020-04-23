clear 
clc

% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------


% currently the algorthim fails if the circle falls exactly on the 
% line or corner (try Nx=Ny=11). also for uneven meshes.
Nx =333;
Ny = 333;
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
% cir_xloc_x = [cir_xloc_x,cir_xloc_x];
% xnode = [xnode];

for i=1:length(xnode)
    for j=1:length(x)-1 %changed from x to y
    if y(j) < cir_xloc_y1(i) && y(j+1) > cir_xloc_y1(i)
    ynodefromx1(i) = j; %from the given xs, determine nodes of y, 1 for bottom
    end
    if y(j) < cir_xloc_y2(i) && y(j+1) > cir_xloc_y2(i)
    ynodefromx2(i) = j; % 2 for top
    end
    end
end
ynodefromx1(ynodefromx1<1) = 1;
ynodefromx2(ynodefromx2<1) = 1;


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


for i=1:length(ynode)
    for j=1:length(y)-1
    if x(j) < cir_yloc_x1(i) && x(j+1) > cir_yloc_x1(i)
    xnodefromy1(i) = j; %not from y1, from y, 1
    end
    if x(j) < cir_yloc_x2(i) && x(j+1) > cir_yloc_x2(i)
    xnodefromy2(i) = j;
    end
    end
end
xnodefromy1(xnodefromy1<1) = 1;
xnodefromy2(xnodefromy2<1) = 1;

%[m,leftcir_min] = min(cir_xloc_y1); %yvalues on bottom 
%[m,rightcir_max] = max(cir_xloc_y2); %yvalues on top
[m,leftcir_min] = min(cir_yloc_x1); %xvales on left
[m,rightcir_max] = max(cir_yloc_x2); %xvalues on right

% bot_ycir_x = [cir_yloc_x1(1:botcir_min),cir_yloc_x2(1:topcir_max)];
% top_ycir_x = [cir_yloc_x1(botcir_min:end),cir_yloc_x2(topcir_max:end)];

C =CFDsemiTrapzoid(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y);

% C = CFDtri1(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
%     cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
%     ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
%     h,r,x,y,C,leftcir_min,rightcir_max);

% botleft_ycir_x = cir_yloc_x1(1:botcir_min);
% topleft_ycir_x = cir_yloc_x1(botcir_min:end);
% botright_ycir_x = cir_yloc_x2(1:topcir_max);
% topright_ycir_x = cir_yloc_x2(topcir_max:end);
%keep these cause trap may use them

[m,leftcir_min] = min(cir_xloc_y1); %takes the min of the bottom (y1(x)), tells us how many xvalues used on left
[m,rightcir_max] = max(cir_xloc_y2); %how many x values used on right
[m,botcir_min] = min(cir_yloc_x1); %takes the min of the left side (x1(y)) tells us how many yvalues used on bottom
[m,topcir_max] = max(cir_yloc_x2); %how many y values used on the top

bot_ycir_x = [cir_yloc_x1(1:botcir_min),cir_yloc_x2(1:topcir_max)];
top_ycir_x = [cir_yloc_x1(botcir_min:end),cir_yloc_x2(topcir_max:end)];
left_xcir_y = [cir_xloc_y1(1:leftcir_min),cir_xloc_y2(1:rightcir_max)];
right_xcir_y = [cir_xloc_y1(leftcir_min:end),cir_xloc_y2(rightcir_max:end)];

botleft_ycir_x = cir_yloc_x1(1:botcir_min); % 1 for left
botleft_xcir_x = cir_xloc_x(1:leftcir_min); 
botleft_ycir_y = cir_yloc_y(1:botcir_min);
botleft_xcir_y = cir_xloc_y1(1:leftcir_min);
botleft_xnodefromy = xnodefromy1(1:botcir_min); %1 for left
botleft_ynodefromx = ynodefromx1(1:leftcir_min); %1 for bot

botright_ycir_x = cir_yloc_x2(1:botcir_min); %here 2 is right
botright_xcir_x = cir_xloc_x(rightcir_max:end); 
botright_ycir_y = cir_yloc_y(1:botcir_min);
botright_xcir_y = cir_xloc_y1(rightcir_max:end); %here 1 is bottom
botright_xnodefromy = xnodefromy2(1:botcir_min);  %2 for right
botright_ynodefromx = ynodefromx1(rightcir_max:end); %1 for bot

topleft_ycir_x = cir_yloc_x1(topcir_max:end); % 1 is left, end is top
topleft_xcir_x = cir_xloc_x(1:leftcir_min); %left
topleft_ycir_y = cir_yloc_y(topcir_max:end); %end for top
topleft_xcir_y = cir_xloc_y2(1:leftcir_min); %2 for top
topleft_xnodefromy = xnodefromy1(topcir_max:end); %1 for left, end for top
topleft_ynodefromx = ynodefromx2(1:leftcir_min); %2 for top,

topright_ycir_x = cir_yloc_x2(topcir_max:end); % 1 is left, end is top
topright_xcir_x = cir_xloc_x(rightcir_max:end); %right
topright_ycir_y = cir_yloc_y(topcir_max:end); %end for top
topright_xcir_y = cir_xloc_y2(rightcir_max:end); %2 for top
topright_xnodefromy = xnodefromy2(topcir_max:end); %1 for left, end for top
topright_ynodefromx = ynodefromx2(topcir_max:end); %2 for top,

% bottom left
isdoubletri = false;
for i_xy=1:length(botleft_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
   
    for i_xx=1:length(botleft_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  botleft_xcir_x(i_xx) < botleft_ycir_x(i_xy) &&... %botleft_ycir_x steps from large to small
              botleft_xcir_x(i_xx) > botleft_ycir_x(i_xy+1) && trap ==false%botleft_xcir_x steps from small to large
        
           if i_xx ~= length(botleft_xcir_x) && (botleft_ycir_x(i_xy) > botleft_xcir_x(i_xx+1) && ...
                botleft_ycir_x(i_xy+1) < botleft_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (botleft_ycir_x(i_xy) > botleft_xcir_x(i_xx-1) && ...
                botleft_ycir_x(i_xy+1) < botleft_xcir_x(i_xx-1))
            trap = true;
           end
           
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end          
          
        end
         
    end    
    if isdoubletri == true
        % small tri, on 'left'
    linear_distance = ((botleft_ycir_x(i_xy+1)- botleft_xcir_x(i_xxhold))^2 +...
        (botleft_ycir_y(i_xy+1)- botleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botleft_xnodefromy(i_xy)) - botleft_ycir_x(i_xy+1))/2 * abs( y(botleft_ynodefromx(i_xxhold)+1)...
                - botleft_xcir_y(i_xxhold));
    area = area_tri + area_sliver;
    C(botleft_xnodefromy(i_xy)-1,ynode(i_xy)) = area/h^2;

        % cut rect, one the 'right'
    linear_distance = ((botleft_ycir_x(i_xy)- botleft_xcir_x(i_xxhold))^2 +...
        (botleft_ycir_y(i_xy)- botleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botleft_xnodefromy(i_xy)) - botleft_ycir_x(i_xy))/2 * abs( y(botleft_ynodefromx(i_xxhold))...
                - botleft_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(botleft_xnodefromy(i_xy),ynode(i_xy)) = area/h^2;
    isdoubletri = false;
     
    end   

end

% bottom right, yet to be validated
isdoubletri = false;
for i_xy=1:length(botright_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
   
    for i_xx=1:length(botright_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  botright_xcir_x(i_xx) > botright_ycir_x(i_xy) &&... %botright_ycir_x steps from small to large
              botright_xcir_x(i_xx) < botright_ycir_x(i_xy+1) && trap ==false%botright_xcir_x steps from small to large
        
           if i_xx ~= length(botright_xcir_x) && (botright_ycir_x(i_xy) < botright_xcir_x(i_xx+1) && ...
                botright_ycir_x(i_xy+1) > botright_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (botright_ycir_x(i_xy) < botright_xcir_x(i_xx-1) && ...
                botright_ycir_x(i_xy+1) > botright_xcir_x(i_xx-1))
            trap = true;
           end
           
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end          
          
        end
         
    end    
    if isdoubletri == true
        % small tri, on 'right'
    linear_distance = ((botright_ycir_x(i_xy+1)- botright_xcir_x(i_xxhold))^2 +...
        (botright_ycir_y(i_xy+1)- botright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botright_xnodefromy(i_xy)+1) - botright_ycir_x(i_xy+1))/2 * abs( y(botright_ynodefromx(i_xxhold)+1)...
                - botright_xcir_y(i_xxhold));
    area = area_tri + area_sliver;
    C(botright_xnodefromy(i_xy)+1,ynode(i_xy)) = area/h^2; %+1 makes sense here for x but idk about others, ynode good for this but for others need other half

        % cut rect, one the 'left'
    linear_distance = ((botright_ycir_x(i_xy)- botright_xcir_x(i_xxhold))^2 +...
        (botright_ycir_y(i_xy)- botright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botright_xnodefromy(i_xy)+1) - botright_ycir_x(i_xy))/2 * abs( y(botright_ynodefromx(i_xxhold))...
                - botright_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(botright_xnodefromy(i_xy),ynode(i_xy)) = area/h^2;
    isdoubletri = false;
     
    end   

end

% top left, reasonably validated
isdoubletri = false;
for i_xy=1:length(topleft_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
   
    for i_xx=1:length(topleft_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  topleft_xcir_x(i_xx) > topleft_ycir_x(i_xy) &&... %topleft_ycir_x steps from small to small
              topleft_xcir_x(i_xx) < topleft_ycir_x(i_xy+1) && trap ==false%topleft_xcir_x steps from small to large
        
           if i_xx ~= length(topleft_xcir_x) && (topleft_ycir_x(i_xy) < topleft_xcir_x(i_xx+1) && ...
                topleft_ycir_x(i_xy+1) > topleft_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (topleft_ycir_x(i_xy) < topleft_xcir_x(i_xx-1) && ...
                topleft_ycir_x(i_xy+1) > topleft_xcir_x(i_xx-1))
            trap = true;
           end
           
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end          
          
        end
         
    end    
    if isdoubletri == true
        % small tri, on 'right'
    linear_distance = ((topleft_ycir_x(i_xy+1)- topleft_xcir_x(i_xxhold+1))^2 +...
        (topleft_ycir_y(i_xy+1)- topleft_xcir_y(i_xxhold+1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topleft_xnodefromy(i_xy+1)+1) - topleft_ycir_x(i_xy+1))/2 * abs( y(topleft_ynodefromx(i_xxhold)+1)...
                - topleft_xcir_y(i_xxhold+1));
    area = area_tri + area_sliver;
    C(topleft_xnodefromy(i_xy+1),ynode(topcir_max+i_xy)) = area/h^2;

        % cut rect, one the 'left'
    linear_distance = ((topleft_ycir_x(i_xy+1)- topleft_xcir_x(i_xxhold))^2 +...
        (topleft_ycir_y(i_xy+1)- topleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topleft_xnodefromy(i_xy+1)) - topleft_ycir_x(i_xy+1))/2 * abs( y(topleft_ynodefromx(i_xxhold)+1)...
                - topleft_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(topleft_xnodefromy(i_xy+1),ynode(topcir_max+i_xy-1)) = area/h^2;
    isdoubletri = false;
     
    end   

end


% top right, yet to be validated
isdoubletri = false;
for i_xy=1:length(topright_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
      
    for i_xx=1:length(topright_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  topright_xcir_x(i_xx) < topright_ycir_x(i_xy) &&... %topright_ycir_x steps from large to small
              topright_xcir_x(i_xx) > topright_ycir_x(i_xy+1) && trap ==false%topright_xcir_x steps from small to large
        
           if i_xx ~= length(topright_xcir_x) && (topright_ycir_x(i_xy) > topright_xcir_x(i_xx+1) && ...
                topright_ycir_x(i_xy+1) < topright_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (topright_ycir_x(i_xy) > topright_xcir_x(i_xx-1) && ...
                topright_ycir_x(i_xy+1) < topright_xcir_x(i_xx-1))
            trap = true;
           end
           
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end          
          
        end
         
    end    
    if isdoubletri == true
        % small tri, on 'left'
    linear_distance = ((topright_ycir_x(i_xy+1)- topright_xcir_x(i_xxhold-1))^2 +...
        (topright_ycir_y(i_xy+1)- topright_xcir_y(i_xxhold-1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topright_xnodefromy(i_xy+1)) - topright_ycir_x(i_xy+1))/2 * abs( y(topright_ynodefromx(i_xxhold-1))...
                - topright_xcir_y(i_xxhold-1));
    area = area_tri + area_sliver;
    C(topright_xnodefromy(i_xy+1),ynode(topcir_max+i_xy)) = area/h^2;

        % cut rect, one the 'right'
    linear_distance = ((topright_ycir_x(i_xy+1)- topright_xcir_x(i_xxhold))^2 +...
        (topright_ycir_y(i_xy+1)- topright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topright_xnodefromy(i_xy+1)+1) - topright_ycir_x(i_xy+1))/2 * abs( y(topright_ynodefromx(i_xxhold)+1)...
                - topright_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(topright_xnodefromy(i_xy+1),ynode(topcir_max+i_xy-1)) = area/h^2;
    isdoubletri = false;
     
    end   

end


cir_xloc_x = [cir_xloc_x,cir_xloc_x];
cir_yloc_y = [cir_yloc_y,cir_yloc_y];
plot(cir_xloc_x,cir_xloc_y,'o')
plot(cir_yloc_x,cir_yloc_y,'o')


T = 2;
t = T/2; %this is for book example, deliverable 2 has t = T/pi
PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;

u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

% figure
% quiver(X,Y,u,v)
% C = (u.^2 + v.^2).^(1/2);




