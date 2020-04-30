function [area,xleft,xright,yleft,yright] = areafinder(x,y,mx,my,h,alpha)
% if cells counted clockwise sides (starting on left) 1, 2, 3, 4
slope = -1/(my/mx);
% area = 1*h^2;
area = 1.1;

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
    xindicies = [x,x+h, x+h,x+abs(alpha/my - h)/-slope, x]; %abs here
    yindicies = [y,y,y+abs(alpha/mx - x) * -slope,y+h,y+h]; %abs here

area = polyarea(xindicies,yindicies);
xright = x+h;
xleft =x+abs(alpha/my - h)/-slope; %abs here
yleft = y+h;
yright = y+abs(alpha/mx - x) * -slope; %abs here

end

if alpha/mx > h && alpha/my < h
% line passes through 1,3
%counter clockwise
%origin, right corner, right up, left up
    xindicies = [x,x+h,x+h,x];
    yindicies = [y,y,y+(alpha/mx - x) * -slope, y + alpha/my]; %abs here x4

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+h;
yleft = y + abs(alpha/my); %abs here
yright = y+abs(alpha/mx - x) * -slope; %abs here
end

if alpha/mx < h && alpha/my > h
%line passes through 2,4
%counter clockwise
%origin, right, left up, left corner
    xindicies = [x,x+alpha/mx,x+(alpha/my - h)/-slope ,x]; %abs herex3
    yindicies = [y,y,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x+(alpha/my - h)/-slope; %abs herex2
xright = x+alpha/mx; %abs here
yleft = y + h;
yright = y;
end

if alpha/mx < h && alpha/my < h
%line passes through 1,4
%counter clockwise
%origin, right, left up
    xindicies = [x,x+(alpha/mx),x]; %abs here
    yindicies = [y,y,y+(alpha/my)]; %abs here

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+(alpha/mx); %abs here
yleft = y+(alpha/my); %abs here
yright = y;
end
end

if slope > 0


if alpha/mx > 0 && (h-(alpha/mx))*slope > h  %abs here
% line passes through 4,2
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+(alpha/mx),x+(h/slope)+(alpha/mx), x];%abs here x2
    yindicies = [y,y,y+h,y+h];
area = polyarea(xindicies,yindicies);
xleft =x+(alpha/mx); %abs here
xright = x+(h/slope)+(alpha/mx); %abs here
yleft = y;
yright = y+h;
end

if alpha/mx < 0 && slope*(h) + alpha/my < h  %slope*(x+h)? no cause alpha/my isnt intercept of whole thing
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

if alpha/mx < 0 && slope*(h) + alpha/my > h  %slope*(x+h)? no cause alpha/my isnt intercept of whole thing
% line passes through 1,2
%counter clockwise:
%bottom, right, topleft corner
    xindicies = [x,x+ h-(alpha/my)/slope,x]; %abs here
    yindicies = [y+alpha/my,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+ h-(alpha/my)/slope; %abs here
yleft = y+alpha/my;
yright = y+ h;
end

if alpha/mx > 0 &&  (h-(alpha/mx))*slope < h  %this gets a x value %abs here
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

%%% all these values for positive slope calculate the area to the left 
% of the intercepting line. 
%%% all the values for the negative slope also calculate the area to the
 % left of the line.
%flips the area if need be
end

if (mx < 0 && my > 0) || (mx < 0 && my < 0)  
area = h^2 - area;
end
 
% area = area/h^2;


end