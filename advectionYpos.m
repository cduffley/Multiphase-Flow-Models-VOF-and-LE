function [Cy,num_shift] =advectionYpos(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C)

xverticies = [0,0,0]; % inserted bc some alpha isnt coming out okay
yverticies = [0,0,0];

dy = dt*v;
slope = -1/(my/mx);
% function that determines what cell the new geometry is on
% y + dt*v  <- floor to nearest y grid
% the value will be called new_y
new_y = y + floor((dt*v)/h) * h;
new_y_r = yright + dy; %new_y_right
new_y_l = yleft + dy; %new_y_left

%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%

%3
% (-,-) v is positive (2,3)
if mx<0 && my<0
  if alpha/mx > h && alpha/my > h
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft + (new_y - new_y_l)/slope, xright, xright, xleft];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
        xverticies = [xright, xright, xleft];
        yverticies = [new_y_r, new_y_l, new_y_l];
    end
  end
% (-,-) v is positive (2,4)
 if alpha/mx < h && alpha/my > h
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [xleft + (new_y - new_y_l)/slope, x+h, x+h, xleft];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
 end
% (-,-) v is positive (1,4)
 if alpha/mx < h && alpha/my < h
    if new_y_r < new_y && new_y_l < new_y
       xverticies = [xleft, x+h, x+h, xleft];
       yverticies = [new_y, new_y, y+h+dy, y+h+dy]; 
    end
    
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, x+h, x+h,  xleft];
       yverticies = [new_y_l, new_y, new_y, y+h+dy, y+h+dy]; 
    end
 end
 
    
% (-,-) v is positive (1,3)
 if alpha/mx > h && alpha/my < h
    if new_y_r < new_y && new_y_l < new_y
       xverticies = [xleft, xright, xright, xleft];
       yverticies = [new_y, new_y, y+h+dy, y+h+dy]; 
    end
    
    if new_y_r > new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, xright, xright, xleft];
       yverticies = [new_y_l, new_y, new_y, y+h+dy, y+h+dy]; 
    end
    
    if new_y_r >= new_y && y+h+dy > new_y
       xverticies = [xleft, xright, xright, xleft];
       yverticies = [new_y_l, new_y_r, y+h+dy, y+h+dy]; 
    end
 end
end

%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%

%4
% mx > 0 && my < 0
if mx > 0 && my < 0
    
if alpha/mx < 0 && (h - alpha/my)*(1/slope) < h
% (+,-) v is positive (1,2)
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, x+h, x+h, xright];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, x+h, x+h, xright, x];
        yverticies = [new_y, new_y, y+h+dy, new_y_r, new_y_l];
    end
end
if alpha/mx < 0 && (h - alpha/my)*(1/slope) > h
% (+,-) v is positive (1,3)
    if new_y_l < new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
       yverticies = [new_y, new_y, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l];
    end
    
    if new_y_l >= new_y && y+dy > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [y+h+dy, y+h+dy, new_y_r, new_y_l];
    end
end

if alpha/mx > 0 && (h - alpha/mx)*(slope) < h
% (+,-) v is positive (3,4)

    if new_y_l < new_y && new_y_r < new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, y+h+dy, y+h+dy];
    end
    
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [x, xright - (new_y_r - new_y)/slope, xright, xright, x];
       yverticies = [new_y, new_y, new_y_r, y+h+dy, y+h+dy]; 
    end
end
    

if alpha/mx > 0 && (h - alpha/mx)*(slope) > h
% (+,-) v is positive (4,2)

    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [x, xright - (new_y_r - new_y)/slope, xright, x];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
end

end

%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%

%2
% mx < 0 && my > 0
if mx < 0 && my > 0
% (-,+) v is positive (1,2)
if alpha/mx < 0 && slope*h + alpha/my > h
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, x+h, x+h, xright];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, x+h, x+h, xright, x];
        yverticies = [new_y, new_y, y+h+dy, new_y_r, new_y_l];
    end
end
if alpha/mx < 0 && slope*h + alpha/my < h
% (-,+) v is positive (1,3)
    if new_y_l < new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
       yverticies = [new_y, new_y, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l];
    end
    
    if new_y_l >= new_y && y+dy > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [y+h+dy, y+h+dy, new_y_r, new_y_l];
    end
end

if alpha/mx > 0 && slope*(h-alpha/mx) < h
% (-,+) v is positive (3,4)

    if new_y_l < new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
       yverticies = [new_y, new_y, new_y_r]; 
    end
    
    if new_y_l >= new_y && new_y_r > new_y
        xverticies = [xleft, xright, xright];
        yverticies = [new_y_l, new_y_l, new_y_r];
    end
end

if alpha/mx > 0 && slope*(h-alpha/mx) > h
% (-,+) v is positive (4,2)

    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, x+h, x+h, xright];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
end

end

%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%

% mx > 0 && my > 0
if mx > 0 && my > 0 
if mx/alpha > h && my/alpha > h
% (+,+) v is positive (2,3)
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [x, xleft + (new_y - new_y_l)/slope, xleft, x];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
        xverticies = [x, xright, xright, xleft, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l, new_y_l];
    end
end

if mx/alpha <= h && my/alpha >= h
% (+,+) v is positive (2,4)
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [x, xleft + (new_y - new_y_l)/slope, xleft, x];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
end

if mx/alpha <= h && my/alpha <= h
% (+,+) v is positive (1,4)

    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, xleft];
       yverticies = [new_y, new_y, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
       xverticies = [xleft, xright, xleft];
       yverticies = [new_y_r, new_y_r, new_y_l]; 
    end
end
    

if mx/alpha >= h && my/alpha <= h
% (+,+) v is positive (1,3)
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, xleft];
       yverticies = [new_y, new_y, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
       xverticies = [xleft, xright, xright, xleft];
       yverticies = [new_y, new_y, new_y_r, new_y_l]; 
    end
    
    if new_y_r > new_y && y+h+dy > new_y
       xverticies = [xleft, xright, xright, xleft];
       yverticies = [y+dy, y+dy, new_y_r, new_y_l]; 
    end
end

end
if C(i,j) ~=0
area = polyarea(xverticies,yverticies)/h^2; %fraction!!
Cy = zeros(size(C));
num_shift = floor((dt*v)/h); %this means h is in meters
Cy(i,j+num_shift) = area;
Cy(i,j+num_shift-1) = C(i,j) - area;
else
    num_shift = 0;
    Cy = zeros(size(C));
end
end
