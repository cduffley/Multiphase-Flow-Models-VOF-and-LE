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
    xindicies = [x,x+h, x+h,x+abs(alpha/abs(my) - h)/-slope, x];
    yindicies = [y,y,y+abs(alpha/abs(mx) - x) * -slope,y+h,y+h];

area = polyarea(xindicies,yindicies);
xright = x+h;
xleft =x+abs(alpha/abs(my) - h)/-slope;
yleft = y+h;
yright = y+abs(alpha/abs(mx) - x) * -slope;

end

if alpha/mx > h && alpha/my < h
% line passes through 1,3
%counter clockwise
%origin, right corner, right up, left up
    xindicies = [x,x+h,x+h,x];
    yindicies = [y,y,y+abs(alpha/abs(mx) - x) * -slope, y + abs(alpha/abs(my))];

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+h;
yleft = y + abs(alpha/abs(my));
yright = y+abs(alpha/abs(mx) - x) * -slope;
end

if alpha/mx < h && alpha/my > h
%line passes through 2,4
%counter clockwise
%origin, right, left up, left corner
    xindicies = [x,x+abs(alpha/mx),x+abs(alpha/abs(my) - h)/-slope ,x];
    yindicies = [y,y,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x+abs(alpha/abs(my) - h)/-slope;
xright = x+abs(alpha/mx);
yleft = y + h;
yright = y;
end

if alpha/mx < h && alpha/my < h
%line passes through 1,4
%counter clockwise
%origin, right, left up
    xindicies = [x,x+abs(alpha/mx),x];
    yindicies = [y,y,y+abs(alpha/my)];

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+abs(alpha/mx);
yleft = y+abs(alpha/my);
yright = y;
end
end

if slope > 0


if alpha/mx > 0 && (h-abs(alpha/mx))*slope > h
% line passes through 4,2
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+abs(alpha/mx),x+(h/slope)+abs(alpha/mx), x];
    yindicies = [y,y,y+h,y+h];
area = polyarea(xindicies,yindicies);
xleft =x+abs(alpha/mx);
xright = x+(h/slope)+abs(alpha/mx);
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
    xindicies = [x,x+ h-abs(alpha/my)/slope,x];
    yindicies = [y+alpha/my,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x;
xright = x+ h-abs(alpha/my)/slope;
yleft = y+alpha/my;
yright = y+ h;
end

if alpha/mx > 0 &&  (h-abs(alpha/mx))*slope < h  %this gets a x value
% line passes through 4,3
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+abs(alpha/mx), x+h,x+h, x];
    yindicies = [y,y,y+(h-alpha/mx)*slope,y+h,y+h];

area = polyarea(xindicies,yindicies);
xleft =x+abs(alpha/mx);
xright = x+h;
yleft = y;
yright = y+(h-alpha/mx)*slope;
end

%%% all these values for positive slope calculate the area to the left 
% of the intercepting line. 
%%% all the values for the negative slope also calculate the area to the
 % left of the line.
%flips the area if need be
if (mx < 0 && my > 0) || (mx < 0 && my < 0)  
area = h^2 - area;
end
 
% area = area/h^2;


end