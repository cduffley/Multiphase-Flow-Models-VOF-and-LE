function [Cx,num_shift] =advectionXneg(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold)

% For reference, see advectionXpos

% This function advects the area in the negative X direction. It runs for
% the four m-vector types and their respective 4 different line possibities
% Once it check for the m-vector type, it determines what the new advection
% geometry is.

% To do this, we refect the given geometry over the y-axis. Then, we
% perform the advection like we did in advectionXpos.m. The corresponding
% geometries are:
% #2: area calculation copied from #1, and implemented #2 conditions
% #1: area calculation copied from #2, and implemented #1 conditions
% #3: area calculation copied from #4, and implemented #3 conditions
% #4: area calculation copied from #3, and implemented #4 conditions
% here, the implemted conditions are the ones based on mx, my and alpha
% (since we do not change those), and the geometetric conditions (ie. the
% ones based on xright,new_x ect) stay the same as the one that is copied.

% initializing verticies (formally spelled vertices)
xverticies = [0,0,0]; 
yverticies = [0,0,0];

dx = dt*-u;
xlefthold = xleft;
xleft = x+h/2 - xright + x+h/2; %switches xleft and xright
xright = x+h/2 - xlefthold + x+h/2;
ylefthold = yleft; %also switching yleft and yright
yleft = yright;
yright = ylefthold;
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left
slopeold = -1/(my/mx);%for condition statements
slope = -slopeold; %for calculations

% Determines what cell the new geometry is on
% the new_x value is the xgrid point that the area advects past
% (these are also flipped from advectionXpos.m
if (mx <= 0 && my<=0) || (mx<0 && my>=0) %4 and 1 to %3 and 2
    new_x =  h*floor((new_x_r)/h);
end

if (mx >= 0 && my<0) || (mx>=0 && my>=0) %2 and 3 to %4 and 1
    new_x =  h*floor((x+h+dx)/h); 
end

% (-,+)(1,2) now (+,+)(2,3) - means its calculating (+,+)(2,3) based on the
% old copied (-,+)(1,2)
% ====================================================================%
% ====================================================================%
% ====================================================================%
%% -1, copied from +2
% (+,+) copied from (-,+)
% (-,+)(1,2) now (+,+)(2,3)
if mx > 0 && my > 0
if alpha/mx > h && alpha/my > h
    if new_x_l < new_x && new_x_r < new_x
       xverticies = [new_x, x+h+dx, x+h+dx, new_x];
       yverticies = [y, y, yright, yright]; 
    end
    
    if new_x_l <= new_x && new_x_r > new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x_r, new_x];
        yverticies = [y, y, yright, yright, yright - (new_x_r - new_x)*slope];
    end
end
% (-,+)(1,3) now (+,+)(1,3)
if alpha/mx >= h && alpha/my <= h 
    if new_x_l <= new_x && new_x_r > new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [y, y, yright, yright - (new_x_r - new_x)*slope]; 
    end
end   
% (-,+)(3,4) now (+,+)(1,4)
if alpha/mx <= h && alpha/my <= h
    if new_x_l < new_x && new_x_r > new_x
        xverticies = [new_x, new_x_r, new_x_r, new_x];
        yverticies = [y, y, yright, yright - (new_x_r - (new_x))*slope];
    end
    
    if new_x_l >= new_x
        xverticies = [new_x_l, new_x_r, new_x_r];
        yverticies = [y, y, yright];
    end
end

if alpha/mx <= h && alpha/my >= h
% (-,+) (4,2) now (+,+)(2,4)
    if new_x_l < new_x && new_x_r < new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x];
        yverticies = [y, y, yright, yright];
    end 
        
    if new_x_l < new_x && new_x_r > new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x_r, new_x];
        yverticies = [y, y, yright, yright, yright - (new_x_r - (new_x))*slope];
    end
    
    if new_x_l >= new_x && new_x_r > new_x
        xverticies = [new_x_l, x+h+dx, x+h+dx, new_x_r];
        yverticies = [y, y, yright, yright];
    end
end
end

%% -3 copied from +4
% (-,-) copied from (+,-)
% ====================================================================%
% ====================================================================%
% ====================================================================%
if mx < 0 && my < 0

%(+,-)(1,2) now (-,-)(2,3)
  if alpha/mx > h && alpha/my > h

    if new_x_l >= new_x %same thing
        xverticies = [new_x_l, new_x_r, new_x_l];
        yverticies = [yleft,yright,yright];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,yright];
    end
  end


%(+,-)(1,3) now (-,-)(1,3)
if alpha/mx > h && alpha/my < h
    
    if new_x_l >= new_x %same thing, again
        xverticies = [new_x_l, new_x_r, new_x_r,new_x_l];
        yverticies = [yleft,yright,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end


%(+,-)(4,3) now (-,-)(1,4) 
if alpha/mx < h && alpha/my < h
    
    if new_x_l >= new_x %
        xverticies = [new_x, new_x_l, new_x_r,new_x_r,new_x];
        yverticies = [yleft,yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end

%(+,-)(4,2) now (-,-)(2,4)
if alpha/mx < h && alpha/my > h
    
    if new_x_l >= new_x && x+dx < new_x 
        xverticies = [new_x, new_x_l, new_x_r,new_x];
        yverticies = [yleft,yleft,yright,y+h];
    end
    
    if new_x_l >= new_x && x+dx > new_x 
        xverticies = [x+dx, new_x_l, new_x_r,x+dx];
        yverticies = [yleft,yleft,yright,yright];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,yright];
    end
end
end

%% -2 copied from +1
% (-,+) copied from (+,+)
% ====================================================================%
% ====================================================================%
% ====================================================================%

if mx < 0 && my > 0
    
%(+,+) (2,3) now (-,+)(1,2)
if alpha/mx < 0 && slopeold*h + alpha/my > h
    if new_x_l >= new_x 
        xverticies = [new_x, new_x_r, new_x_r, new_x_l,new_x];
        yverticies = [y,y,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,(new_x_r-new_x)*-slope + yright]; 
    end
end

% (+,+)(2,4) now (-,+)(4,2)
if alpha/mx > 0 && slopeold*(h-alpha/mx) > h
    
    if new_x_l >= new_x && x+dx < new_x
        xverticies = [new_x, new_x_r,new_x_l,new_x];
        yverticies = [y,y,yleft,yleft];
    end
    
    if new_x_l > new_x && x+dx > new_x
       xverticies = [x+dx,new_x_r,new_x_l,x+dx];
       yverticies = [y,y,yleft,yleft]; 
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [y,y,(new_x_r-new_x)*-slope + y]; 
    end
    
end

% (+,+)(1,4) now (-,+)(4,3)
if alpha/mx > 0 && slopeold*(h-alpha/mx) < h
    
    if new_x_l >= new_x 
        xverticies = [new_x_l,new_x_r,new_x_l];
        yverticies = [y,y,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [y,y,(new_x_r-new_x)*-slope + y]; 
    end
end

% (+,+)(1,3) now (-,+)(1,3)
if alpha/mx < 0 && slopeold*h + alpha/my < h
    if new_x_l >= new_x %same thing
        xverticies = [xleft,xright,xright,xleft];
        yverticies = [y,y,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,yright+(new_x_r-new_x)*-slope]; 
    end
end
end

%% -4 copied from +3
% (+,-) copied from (-,-)
% ====================================================================%
% ====================================================================%
% ====================================================================%
if mx > 0 && my < 0
    
%(+,-)(1,4) now (+,-)(4,3)
 if alpha/mx > 0 && (h - alpha/mx)*(slopeold) < h
    if new_x_l <= new_x && new_x_r > new_x
       xverticies = [new_x, new_x_r, x+h+dx, x+h+dx,new_x];
       yverticies = [y+(new_x_r-new_x)*-slope,y,y,y+h,y+h];
    end
    
    if new_x_r < new_x
       xverticies = [new_x,x+h+dx, x+h+dx, new_x];
       yverticies = [y,y,y+h,y+h]; 
    end
 end   
 
 if alpha/mx > 0 && (h - alpha/mx)*(slopeold) > h
     %(+,-)(2,4) now (+,-)(4,2)
    if new_x_l > new_x && new_x_r > new_x %%same thing
       xverticies = [xright, x+h, x+h, xleft];
       yverticies = [y,y,y+h,y+h];
    end
    
    if new_x_l < new_x && new_x_r  > new_x
       xverticies = [new_x, new_x_r, x+h+dx, x+h+dx,new_x];
       yverticies = [(new_x_r-new_x)*-slope + y,y,y,y+h,y+h]; 
    end
    
    if new_x_l < new_x && new_x_r < new_x
       xverticies = [new_x, x+h+dx, x+h+dx, new_x];
       yverticies = [y,y,y+h,y+h];
    end
 end  
 
 if alpha/mx < 0 && (h - alpha/my)*(1/slopeold) > h
    %(+,-)(1,3) now (+,-)(1,3)
    if new_x_l > new_x 
       xverticies = [new_x_l, new_x_r, new_x_r, new_x_l];
       yverticies = [yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [(new_x_r-new_x)*-slope + yright,yright,y+h,y+h]; 
    end
 end   

 
 if alpha/mx < 0 && (h - alpha/my)*(1/slopeold) < h
    %(+,-)(2,3) now (+,-)(1,2)
    if new_x_l > new_x 
       xverticies = [new_x_l, new_x_r, new_x_r];
       yverticies = [yleft,yright,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [(new_x_r-new_x)*-slope + yright,yright,y+h,y+h]; 
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
    new_x =  h*floor((x+h+dx)/h); 
    xverticies = [new_x,x+h+dx,x+h+dx,new_x];
    yverticies = [y,y,y+h,y+h];
end

% ====================================================================%
% ====================================================================%
% ====================================================================%

%calculating area and placing it into the proper cell

num_shift = round(-(new_x - x)/h);
area = polyarea(xverticies,yverticies)/h^2;
Cx = zeros(size(C));
if C(i,j) >= 1.0
    area = area*C(i,j);
end
if i+num_shift-1 >=1  
Cx(i+num_shift,j) = area;
Cx(i+num_shift+1,j) = C(i,j) - area;
else % condition incase it hits a wall
Cx(i+num_shift,j) = area;
Cx(i+num_shift,j) = C(i,j) - area;
end
    
    
end