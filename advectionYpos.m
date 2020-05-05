function [Cy,num_shift] =advectionYpos(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C)

xverticies = [0,0,0]; % inserted bc some alpha isnt coming out okay
yverticies = [0,0,0];

if i ==13 && j == 5
    g = 0;
end



dy = dt*v;
slope = -1/(my/mx);
% function that determines what cell the new geometry is on
% y + dt*v  <- floor to nearest y grid
% the value will be called new_y
new_y_r = yright + dy; %new_y_right
new_y_l = yleft + dy; %new_y_left

if (mx <= 0 && my>=0)  %2
    new_y =  h*floor((new_y_r)/h);
    
elseif (mx>0 && my>=0) %1
    new_y =  h*floor((new_y_l)/h);
    
elseif (mx >= 0 && my<0) || (mx<=0 && my<=0) %4 and 3
    new_y =  h*floor((y+h+dy)/h); 
end

% if C(i,j) == 1
%     new_y =  h*floor((y+h+dy)/h);   
% end


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
    
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, xright, xright, xleft];
       yverticies = [new_y_l, new_y, new_y, y+h+dy, y+h+dy]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y %changed y+h+dy to new_y_l
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
%        xverticies = [xright - (new_y_r - new_y)/slope, x+h, x+h, xright];
%        yverticies = [new_y, new_y, new_y_r, new_y_r];  
            %old one, not sure what im missing
       xverticies = [x,xright - (new_y_r - new_y)/slope, xright,x];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
%         xverticies = [x, x+h, x+h, xright, x];
%         yverticies = [new_y, new_y, y+h+dy, new_y_r, new_y_l];
        xverticies = [x, xright, x];
        yverticies = [new_y_l,new_y_r,new_y_r];
    end
end
if alpha/mx < 0 && (h - alpha/my)*(1/slope) > h
% (+,-) v is positive (1,3)
    if new_y_l < new_y && new_y_r > new_y
%        xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
%        yverticies = [new_y, new_y, new_y_r]; 
       xverticies = [xleft,xright - (new_y_r - new_y)/slope,xright,xright,xleft];
       yverticies = [new_y,new_y,new_y_r,y+h+dy,y+h+dy];
       
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, xright, xright, x];
%       yverticies = [new_y, new_y, new_y_r, new_y_l];
        yverticies = [new_y_l, new_y_r, y+h+dy, y+h+dy];
    end
    
    if new_y_l < new_y && new_y_r <= new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y,new_y,y+h+dy, y+h+dy];
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
    
    if new_y_l > new_y && y+dy<= new_y         %new_y_r > new_y  
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l];
    end
    
    if new_y_l >= new_y && y+dy > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [y+dy, y+dy, new_y_r, new_y_l];
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
if alpha/mx > h && alpha/my > h
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

if alpha/mx <= h && alpha/my >= h
% (+,+) v is positive (2,4)
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [x, xleft + (new_y - new_y_l)/slope, xleft, x];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
end

if alpha/mx <= h && alpha/my <= h
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
    

if alpha/mx >= h && alpha/my <= h
% (+,+) v is positive (1,3)
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, xleft];
       yverticies = [new_y, new_y, new_y_l]; 
    end
    
    if new_y_r >= new_y && y+dy < new_y
       xverticies = [xleft, xright, xright, xleft];
       yverticies = [new_y, new_y, new_y_r, new_y_l]; 
    end
    
    if new_y_r > new_y && y+dy > new_y
       xverticies = [xleft, xright, xright, xleft];
       yverticies = [y+dy, y+dy, new_y_r, new_y_l]; 
    end
end

end

if C(i,j) == 0
    xverticies = [0,0,0]; 
    yverticies = [0,0,0];
end
    
if C(i,j) >= 1
    new_y =  h*floor((y+h+dy)/h); 
    xverticies = [x,x+h,x+h,x];
    yverticies = [new_y,new_y,y+h+dy,y+h+dy];
end


area = polyarea(xverticies,yverticies)/h^2; %fraction!!
Cy = zeros(size(C));
num_shift = (new_y - y)/h;%this means h is in meters
if C(i,j) >= 1.01
    area = area*C(i,j);
end
if j + num_shift-1 >= 1
Cy(i,j+num_shift) = area;
Cy(i,j+num_shift-1) = C(i,j) - area;
else
Cy(i,j+num_shift) = area;
end

if max(max(Cy)) > 1
    g = 0;
end




end
