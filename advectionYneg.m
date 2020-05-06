function [Cy,num_shift] =advectionYneg(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C)

% For reference, see advectionYpos

% This function advects the area in the negative Y direction. It runs for
% the four m-vector types and their respective 4 different line possibities
% Once it check for the m-vector type, it determines what the new advection
% geometry is.

% To do this, we refect the given geometry over the x-axis. Then, we
% perform the advection like we did in advectionYpos.m. The corresponding
% geometries are:
% #2: area calculation copied from #3, and implemented #2 conditions
% #1: area calculation copied from #4, and implemented #1 conditions
% #3: area calculation copied from #2, and implemented #3 conditions
% #4: area calculation copied from #1, and implemented #4 conditions
% here, the implemted conditions are the ones based on mx, my and alpha
% (since we do not change those), and the geometetric conditions (ie. the
% ones based on yright,new_y ect) stay the same as the one that is copied.


xverticies = [0,0,0]; 
yverticies = [0,0,0];


dy = dt*-v; % distance traveled by area (reflected)

%unlike the Xpos/Xneg reflection, we do not switch yleft and yright, just
%reflect:
yleft = y+h/2 - yleft + y+h/2; 
yright = y+h/2 - yright + y+h/2;

new_y_r = yright + dy; %new_x_right
new_y_l = yleft + dy; %new_x_left
slopeold = -1/(my/mx); %for condition statements
slope = -slopeold; %for geometric calculation

% Determines what cell the new geometry is on
% the new_x value is the xgrid point that the area advects past

if (mx <= 0 && my<=0)  %2
    new_y =  h*floor((new_y_r)/h);
    
elseif (mx>0 && my<=0) %1
    new_y =  h*floor((new_y_l)/h);
    
elseif (mx <= 0 && my>0) || (mx>=0 && my>=0) %4 and 3
    new_y =  h*floor((y+h+dy)/h); 
end


%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%
%-------------------------------------------------------------%

%% 2 from 3 
% (-,-) v is positive (2,3) old
% m(-,+) Down -> m(-,-) Up
% (2,3) to 2(4,3) conditions
% copying 2s conditions, calculating from 3 pos
if mx<0 && my>0
  if alpha/mx > 0 && slopeold*(h-alpha/mx) < h
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
% (2,4) to 2(4,2) conditions
 if alpha/mx > 0 && slopeold*(h-alpha/mx) > h
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [xleft + (new_y - new_y_l)/slope, x+h, x+h, xleft];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
 end
% (-,-) v is positive (1,4)
% (1,4) to 2(1,2)
 if alpha/mx < 0 && slopeold*h + alpha/my > h
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
% (1,3) to 2(1,3)
 if alpha/mx < 0 && slopeold*h + alpha/my < h
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

%% 1 from 4
% m(+,+) Down -> m(+,-) Up
% copying conditions from(+,+)
% copying 1s conditions, calculating from 4 pos
if mx > 0 && my > 0
    
if alpha/mx <= h && alpha/my <= h
% (+,-) v is positive (1,2) to 1(1,4)
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [x,xright - (new_y_r - new_y)/slope, xright,x];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, xright, x];
        yverticies = [new_y_l,new_y_r,new_y_r];
    end
end
if alpha/mx >= h && alpha/my <= h
% (+,-) v is positive (1,3) To 1(1,3)
    if new_y_l < new_y && new_y_r > new_y 
       xverticies = [xleft,xright - (new_y_r - new_y)/slope,xright,xright,xleft];
       yverticies = [new_y,new_y,new_y_r,y+h+dy,y+h+dy];
       
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y_l, new_y_r, y+h+dy, y+h+dy];
    end
    
    if new_y_l < new_y && new_y_r <= new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y,new_y,y+h+dy, y+h+dy];
    end
end

if alpha/mx > h && alpha/my > h
% (+,-) v is positive (3,4) to 1(2,3)

    if new_y_l < new_y && new_y_r < new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, y+h+dy, y+h+dy];
    end
    
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [x, xright - (new_y_r - new_y)/slope, xright, xright, x];
       yverticies = [new_y, new_y, new_y_r, y+h+dy, y+h+dy]; 
    end
end
    

if alpha/mx <= h && alpha/my >= h
% (+,-) v is positive (4,2) to 1(2,4)

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

%% 3 from 2
if mx < 0 && my < 0
% (-,+) v is positive (1,2) to 3(1,4)
% m(-,-) Down -> m(-,+) Up
% using conditions from 3
if alpha/mx < h && alpha/my < h
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, x+h, x+h, xright];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, x+h, x+h, xright, x];
        yverticies = [new_y, new_y, y+h+dy, new_y_r, new_y_l];
    end
end
if alpha/mx > h && alpha/my < h
% (-,+) v is positive (1,3) to  3(1,3)
    if new_y_l < new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
       yverticies = [new_y, new_y, new_y_r]; 
    end
    
    if new_y_l > new_y &&  y+dy<= new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l];
    end
    
    if new_y_l >= new_y && y+dy > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [y+dy, y+dy, new_y_r, new_y_l];
    end
end

if alpha/mx > h && alpha/my > h
% (-,+) v is positive (3,4) to 3(2,3)

    if new_y_l < new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
       yverticies = [new_y, new_y, new_y_r]; 
    end
    
    if new_y_l >= new_y && new_y_r > new_y
        xverticies = [xleft, xright, xright];
        yverticies = [new_y_l, new_y_l, new_y_r];
    end
end

if alpha/mx < h && alpha/my > h
% (-,+) v is positive (4,2) to 3(2,4)

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

%4 from 1
%m(+,-) Down is m(+,+) Up 
% mx > 0 && my > 0
%copying 4 conditions using 1 to calc
if mx > 0 && my < 0 
if alpha/mx > 0 && (h - alpha/mx)*(slopeold) < h
% (+,+) v is positive (2,3) to 4(4,3)
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [x, xleft + (new_y - new_y_l)/slope, xleft, x];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
        xverticies = [x, xright, xright, xleft, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l, new_y_l];
    end
end

if alpha/mx > 0 && (h - alpha/mx)*(slopeold) > h
% (+,+) v is positive (2,4) to 4(4,2)
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [x, xleft + (new_y - new_y_l)/slope, xleft, x];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
end

if alpha/mx < 0 && (h - alpha/my)*(1/slopeold) < h
% (+,+) v is positive (1,4) to 4(1,2)

    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, xleft];
       yverticies = [new_y, new_y, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
       xverticies = [xleft, xright, xleft];
       yverticies = [new_y_r, new_y_r, new_y_l]; 
    end
end
    

if alpha/mx < 0 && (h - alpha/my)*(1/slopeold) > h
% (+,+) v is positive (1,3) to 4(1,3)
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

% ====================================================================%
% ====================================================================%
% ====================================================================%
% Square areas, C is equal to 1 or 0. Includes bounds given the apparent
% errors

if C(i,j) <= 0.0002 && C(i,j) >= -0.0002
    xverticies = [0,0,0]; 
    yverticies = [0,0,0];
end
    
if C(i,j) >= 0.99990
    new_y =  h*floor((y+h+dy)/h); 
    xverticies = [x,x+h,x+h,x];
    yverticies = [new_y,new_y,y+h+dy,y+h+dy];
end

% ====================================================================%
% ====================================================================%
% ====================================================================%

%calculating area and placing it into the proper cell

area = polyarea(xverticies,yverticies)/h^2;
Cy = zeros(size(C));
num_shift = round(-(new_y - y)/h);
if C(i,j) >= 1.0
    area = area*C(i,j);
end

if j + num_shift-1 >= 1
Cy(i,j+num_shift) = area;
Cy(i,j+num_shift+1) = C(i,j) - area;
else
Cy(i,1) = area;
end


end

