function area = areafinder(x,y,mx,my,alpha)
% if cells counted clockwise sides (starting on left) 1, 2, 3, 4
slope = -1/(my/mx);
h = x(3)-x(2);

if slope < 0

if alpha/mx > h && alpha/my > h
% line passes through 2,3
%counter clockwise
%origin, right corner, right triangle, left triangle, left corner
    xindicies = [x,x+h, x+h,x+abs(alpha/abs(my) - h)/-slope, x];
    yindicies = [y,y,y+abs(alpha/abs(mx) - x) * -slope,y+h,y+h];

area = polyarea(xindicies,yindicies);
end

if alpha/mx > h && alpha/my < h
% line passes through 1,3
%counter clockwise
%origin, right corner, right up, left up
    xindicies = [x,x+h,x+h,x];
    yindicies = [y,y,y+abs(alpha/abs(mx) - x) * -slope, y + abs(alpha/abs(my))];

area = polyarea(xindicies,yindicies);
end

if alpha/mx < h && alpha/my > h
%line passes through 2,4
%counter clockwise
%origin, right, left up, left corner
    xindicies = [x,abs(alpha/mx),x+abs(alpha/abs(my) - h)/-slope ,x];
    yindicies = [y,y,y+h,y+h];

area = polyarea(xindicies,yindicies);
end

if alpha/mx < h && alpha/my < h
%line passes through 1,4
%counter clockwise
%origin, right, left up
    xindicies = [x,abs(alpha/mx),x];
    yindicies = [y,y,abs(alpha/my)];

area = polyarea(xindicies,yindicies);
end
end

if slope > 0


if alpha/mx > 0 && alpha/my > h
% line passes through 2,3
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+abs(alpha/my)/slope, x+h,x+h, x];
    yindicies = [y,y,y+h-(abs(alpha/mx)-h)*slope,y+h,y+h];

area = polyarea(xindicies,yindicies);
end

if alpha/mx < 0 && slope*(h) + alpha/my < h  %slope*(x+h)? no cause alpha/my isnt intercept of whole thing
% line passes through 1,3
%counter clockwise:
%bottom, right, topr corner, topleft corner
    xindicies = [x,x+h, x+h,x];
    yindicies = [y+alpha/my,y+ slope*(h) + alpha/my,y+h,y+h];

area = polyarea(xindicies,yindicies);
end

if alpha/mx < 0 && slope*(h) + alpha/my > h  %slope*(x+h)? no cause alpha/my isnt intercept of whole thing
% line passes through 1,2
%counter clockwise:
%bottom, right, topleft corner
    xindicies = [x,x+ h-abs(alpha/my)/slope,x];
    yindicies = [y+alpha/my,y+h,y+h];

area = polyarea(xindicies,yindicies);
end

if alpha/mx > 0 && -1/slope*(-h) + abs(alpha/mx) < h %this gets a x value
% line passes through 4,3
%counter clockwise
%origin, right, right up, top right corner, left corner
    xindicies = [x,x+abs(alpha/mx),x+h ,x+h, x];
    yindicies = [y,y,y+h-(-1/slope*(-h) + abs(alpha/mx) - h)/slope,y+h,y+h];
area = polyarea(xindicies,yindicies);
end

%%% all these values for positive slope calculate the area to the left 
% of the intercepting line. 
%%% all the values for the negative slope also calculate the area to the
 % left of the line.



end