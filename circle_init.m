function [C,cir_xloc_x,cir_yloc_y,cir_xloc_y,cir_yloc_x] = circle_init(x,y,h,x_pos,y_pos,r)
 
% This function determines the area fraction of the inital circle given it
% does this by determining the points along the grid where the circle
% intersects. Then, based on the pattern of the interactions(x-grid
% intersection or y-grid intersection), it determines the geometry of the
% circle within the cell and calculates the area

% The variable names are as follows:
% cir_xloc_y1
% "circle y-values from x-location interaction at section 1 of circle
% (section changes depending on if x or y, see below).


%% Determining x values that cross the inital circle
% based on radius and inital position
j=1;
for i = 1:length(x)
    if x(i) > x_pos-r && x(i) < x_pos+r
        cir_xloc_x(j) = x(i);
        xnode(j) = i;
        j=j+1;
    end
end

% calculating the corresponding y values based on circle equation
% 1 is bottom of circle, 2 is top of circle
cir_xloc_y1 = -(-((cir_xloc_x-x_pos).^2 - r^2)).^(1/2) + y_pos;
cir_xloc_y2 = (-((cir_xloc_x-x_pos).^2 - r^2)).^(1/2) + y_pos;
cir_xloc_y = [cir_xloc_y1,cir_xloc_y2];

%determining the y nodes for the corresponding y values calculated from x
for i=1:length(xnode)
   for j=1:length(y)-1 
   if y(j) < cir_xloc_y1(i) && y(j+1) > cir_xloc_y1(i)
   ynodefromx1(i) = j; %from the given xvalues, the nodes of y, 1 for bottom
   end
   if y(j) < cir_xloc_y2(i) && y(j+1) > cir_xloc_y2(i)
   ynodefromx2(i) = j; %from the given xvalues, the nodes of y, 2 for top
   end
   end
end
ynodefromx1(ynodefromx1<1) = 1; % correction for wall node (0)
ynodefromx2(ynodefromx2<1) = 1;


%% Repeating process for y
j=1;
for i = 1:length(y)
    if y(i) > y_pos-r && y(i) < y_pos+r
        cir_yloc_y(j) = y(i);
        ynode(j) = i;
        j=j+1;
    end
end

% 1 is the left side of the circle, 2 is right
cir_yloc_x2 = (-((cir_yloc_y-y_pos).^2 - r^2)).^(1/2) + x_pos;
cir_yloc_x1 = -(-((cir_yloc_y-y_pos).^2 - r^2)).^(1/2) + x_pos;
cir_yloc_x = [cir_yloc_x1,cir_yloc_x2];


for i=1:length(ynode)
    for j=1:length(x)-1 
    if x(j) < cir_yloc_x1(i) && x(j+1) > cir_yloc_x1(i)
    xnodefromy1(i) = j; 
    end
    if x(j) < cir_yloc_x2(i) && x(j+1) > cir_yloc_x2(i)
    xnodefromy2(i) = j;
    end
    end
end
xnodefromy1(xnodefromy1<1) = 1;
xnodefromy2(xnodefromy2<1) = 1;

%% Area calculation functions
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

%% Setting the rest of the values 0 or 1 to complete the color function
% Essentially scans for values greater than 1, and then places a zero or 1
% for the color function outside or inside the circle
jhit = 0;
jend = 0;
for i=1:length(x)
hit = false;
ended = false;
    for j=1:length(y)-1
        jb = length(y) - j+1;
        if C(i,jb) == 0 && C(i,jb-1) > 0 %counting backwards, last hit inside left

           jhit = jb;
           hit = true;

        elseif C(i,j) ==0 && C(i,j+1) > 0

           jend = j;
            ended = true;
        end
    end
    if hit && ended 
    C(i,jhit:jend) = 1;
    end
end

end