function [area,xleft,xright,yleft,yright] = areafinder(x,y,mx,my,h,alpha)

% This function calculated the area based on the alpha and the normal
% vector. It does this for the four possible line intersections for
% positive and negative slope. All calculate the area to the left 
% of the intercepting line, so we have a condition that flips the area
% if needed. 

% if cells counted clockwise sides (starting on left) 1, 2, 3, 4

% initializing base values
slope = -1/(my/mx);
area = 0;
xleft = x;
yleft = y;
xright = x;
yright = y;


%fudge factors for exactly horizontal and vertical lines
if mx == 0 && my == 0
    area = 0;
    return
elseif my == 0 && mx ~= 0 
    my = 1e-10;
elseif my ~= 0 && mx == 0
    mx = 1e-10;
end
if slope < 0

if alpha/mx > h && alpha/my > h
% line passes through 2,3
%counter clockwise
%origin, right corner, right triangle, left triangle, left corner
    xindicies = [x,x+h, x+h,x+(alpha/my - h)/-slope, x]; 
    yindicies = [y,y,y+(alpha/mx - h) * -slope,y+h,y+h]; 

area = polyarea(xindicies,yindicies);
xright = x+h;
xleft =x+(alpha/my - h)/-slope; 
yleft = y+h;
yright = y+(alpha/mx - h) * -slope; 

end

if alpha/mx > h && alpha/my < h
% line passes through 1,3
%counter clockwise
%origin, right corner, right up, left up
    xindicies = [x,x+h,x+h,x];
    yindicies = [y,y,y+(alpha/mx - h) * -slope, y + alpha/my]; 

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+h;
yleft = y + (alpha/my); 
yright = y+(alpha/mx - h) * -slope; 
end

if alpha/mx < h && alpha/my > h
%line passes through 2,4
%counter clockwise
%origin, right, left up, left corner
    xindicies = [x,x+alpha/mx,x+(alpha/my - h)/-slope ,x]; 
    yindicies = [y,y,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x+(alpha/my - h)/-slope; 
xright = x+alpha/mx; 
yleft = y + h;
yright = y;
end

if alpha/mx < h && alpha/my < h
%line passes through 1,4
%counter clockwise
%origin, right, left up
    xindicies = [x,x+(alpha/mx),x];
    yindicies = [y,y,y+(alpha/my)]; 

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+(alpha/mx); 
yleft = y+(alpha/my); 
yright = y;
end
end

if slope > 0


if alpha/mx > 0 && (h-(alpha/mx))*slope > h  
% line passes through 4,2
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+(alpha/mx),x+(h/slope)+(alpha/mx), x];
    yindicies = [y,y,y+h,y+h];
area = polyarea(xindicies,yindicies);
xleft =x+(alpha/mx);
xright = x+(h/slope)+(alpha/mx);
yleft = y;
yright = y+h;
end

if alpha/mx < 0 && slope*(h) + alpha/my < h 
% line passes through 1,3
%counter clockwise:
%bottom, right, topr corner, topleft corner
    xindicies = [x,x+h, x+h,x];
    yindicies = [y+alpha/my,y+ slope*(h) + alpha/my,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+h;
yleft = y+alpha/my;
yright = y+ slope*(h) + alpha/my;
end

if alpha/mx < 0 && slope*(h) + alpha/my > h  
% line passes through 1,2
%counter clockwise:
%bottom, right, topleft corner
    xindicies = [x,x+ (h-(alpha/my))/slope,x]; 
    yindicies = [y+alpha/my,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+ (h-(alpha/my))/slope; 
yleft = y+alpha/my;
yright = y+ h;
end

if alpha/mx > 0 &&  (h-(alpha/mx))*slope < h  
% line passes through 4,3
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+(alpha/mx), x+h,x+h, x]; %abs here
    yindicies = [y,y,y+(h-alpha/mx)*slope,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x+(alpha/mx); %abs here
xright = x+h;
yleft = y;
yright = y+(h-alpha/mx)*slope;
end
end

%flips the area if need be
if (mx < 0 && my > 0) || (mx < 0 && my < 0)  
area = h^2 - area;
end
 
end