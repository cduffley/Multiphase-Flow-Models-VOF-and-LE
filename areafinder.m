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






















end