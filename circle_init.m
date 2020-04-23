function [C,cir_xloc_x,cir_yloc_y,cir_xloc_y,cir_yloc_x] = circle_init(x,y,h,x_pos,y_pos,r)
%% 
% this function does

%% calculating x,y values,corresponding cells

% determining x values that cross the circle
j=1;
for i = 1:length(x)
    if x(i) > x_pos-r && x(i) < x_pos+r
        cir_xloc_x(j) = x(i);
        xnode(j) = i;
        j=j+1;
    end
end
% 1 is bottom of circle, 2 is top of circle
cir_xloc_y1 = -(-((cir_xloc_x-x_pos).^2 - r^2)).^(1/2) + y_pos;
cir_xloc_y2 = (-((cir_xloc_x-x_pos).^2 - r^2)).^(1/2) + y_pos;
cir_xloc_y = [cir_xloc_y1,cir_xloc_y2];

%determining the y nodes for the corresponding y values calculated from x
for i=1:length(xnode)
    for j=1:length(y)-1 %changed from x to y
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


%repeat for y
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
    for j=1:length(x)-1 %changed y to x
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

%%
C =CFDsemiTrapzoid(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y);

C = CFDtri1(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y,C);

C = CFDtri2(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y,C);



