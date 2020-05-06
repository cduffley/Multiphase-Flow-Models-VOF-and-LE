function [Cx,num_shift] =advectionXpos(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C)

% This function advects the area in the positive X direction. It runs for
% the four m-vector types and their respective 4 different line possibities
% Once it check for the m-vector type, it determines what the new advection
% geometry is. For example:
% for a (+,+), if the right side of the intersected line is advected, while
% the left side is not, it forms a trapezoid shape being advected into the
% next cell.

% initializing verticies (formally spelled vertices)
xverticies = [0,0,0]; 
yverticies = [0,0,0];
% 
dx = dt*u; % distance traveled by area

% determining new xright and xleft values based on how far they move
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left
slope = -1/(my/mx);

% Determines what cell the new geometry is on
% the new_x value is the xgrid point that the area advects past

if (mx >= 0 && my<=0) || (mx>0 && my>=0) %4 and 1
    new_x =  h*floor((new_x_r)/h);
end

if (mx <= 0 && my>0) || (mx<=0 && my<=0) %2 and 3
    new_x =  h*floor((x+h+dx)/h);   
end


% ====================================================================%
% ====================================================================%
% ====================================================================%
%% 1 m(+,+)
%(+,+) u is positive (2,3)
if mx > 0 && my > 0

if alpha/mx > h && alpha/my > h
    if new_x_l >= new_x 
        xverticies = [new_x, new_x_r, new_x_r, new_x_l,new_x];
        yverticies = [y,y,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,(new_x_r - new_x)*-slope + yright]; 
    end
end

% (2,4)
if alpha/mx <= h && alpha/my >= h
    
    if new_x_l >= new_x && x+dx <= new_x
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

% (1,4)
if alpha/mx <= h && alpha/my <= h
    
    if new_x_l >= new_x 
        xverticies = [new_x_l,new_x_r,new_x_l];
        yverticies = [y,y,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [y,y,(new_x_r-new_x)*-slope + y]; 
    end
end

% (1,3)
if alpha/mx >= h && alpha/my <= h
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

% ====================================================================%
% ====================================================================%
% ====================================================================%
%% 2 (-,+)
% (-,+) u is positive (1,2)
if mx < 0 && my > 0
if alpha/mx < 0 && slope*h + alpha/my > h
    if new_x_l < new_x && new_x_r < new_x
       xverticies = [new_x, x+h+dx, x+h+dx, new_x];
       yverticies = [y, y, yright, yright]; 
    end
    
    if new_x_l <= new_x && new_x_r > new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x_r, new_x];
        yverticies = [y, y, yright, yright, yright - (new_x_r - new_x)*slope];
    end
end
% (-,+) u is positive (1,3)
if alpha/mx < 0 && slope*h + alpha/my < h 
    if new_x_l <= new_x && new_x_r > new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [y, y, yright, yright - (new_x_r - new_x)*slope]; 
    end
end   
% (-,+) u is positive (3,4)
if alpha/mx > 0 && slope*(h-alpha/mx) < h
    if new_x_l < new_x && new_x_r > new_x
        xverticies = [new_x, new_x_r, new_x_r, new_x];
        yverticies = [y, y, yright, yright - (new_x_r - (new_x))*slope];
    end
    
    if new_x_l >= new_x
        xverticies = [new_x_l, new_x_r, new_x_r];
        yverticies = [y, y, yright];
    end
end

if alpha/mx > 0 && slope*(h-alpha/mx) > h
% (-,+) u is positive (4,2)
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
% ====================================================================%
% ====================================================================%
% ====================================================================%
%% 3 (-,-) 
 % (-,-) u is positive
if mx < 0 && my < 0
 if alpha/mx < h && alpha/my < h
    %(1,4)
    if new_x_l <= new_x && new_x_r > new_x
       xverticies = [new_x, new_x_r, x+h+dx, x+h+dx,new_x];
       yverticies = [y+(new_x_r-new_x)*-slope,y,y,y+h,y+h];
    end
    
    if new_x_r < new_x
       xverticies = [new_x,x+h+dx, x+h+dx, new_x];
       yverticies = [y,y,y+h,y+h]; 
    end
 end   
 
 if alpha/mx < h && alpha/my > h
     %(2,4)
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
 
 if alpha/mx > h && alpha/my < h
    %(1,3)
    if new_x_l > new_x 
       xverticies = [new_x_l, new_x_r, new_x_r, new_x_l];
       yverticies = [yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [(new_x_r-new_x)*-slope + yright,yright,y+h,y+h]; 
    end
 end   
 
 if alpha/mx > h && alpha/my > h
    %(2,3)
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
%% 4 (+,-)
% (+,-) pos u, pos slope 

if mx > 0 && my < 0
  if alpha/mx < 0 && (h - alpha/my)*(1/slope) < h
      %(1,2)
    if new_x_l >= new_x %same thing
        xverticies = [new_x_l, new_x_r, new_x_l];
        yverticies = [yleft,yright,yright];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,yright];
    end
  end


%(1,3)
if alpha/mx < 0 && (h - alpha/my)*(1/slope) > h
    
    if new_x_l >= new_x %same thing, again
        xverticies = [new_x_l, new_x_r, new_x_r,new_x_l];
        yverticies = [yleft,yright,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end


%(4,3)
if alpha/mx > 0 && (h - alpha/mx)*(slope) < h
    
    if new_x_l >= new_x %
        xverticies = [new_x, new_x_l, new_x_r,new_x_r,new_x];
        yverticies = [yleft,yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end

%(4,2)
if alpha/mx > 0 && (h - alpha/mx)*(slope) > h
    
    if new_x_l >= new_x && x+dx < new_x 
        xverticies = [new_x, new_x_l, new_x_r,new_x]; %%
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

num_shift = round((new_x - x)/h);
area = polyarea(xverticies,yverticies)/h^2; 
Cx = zeros(size(C));

if C(i,j) >= 1.01
    area = area*C(i,j);
end

if i+num_shift-1 >=1  
  Cx(i+num_shift,j) = area;
  Cx(i+num_shift-1,j) = C(i,j) - area;
else % condition incase it hits a wall
  Cx(i+num_shift,j) = area;
  Cx(i+num_shift,j) = C(i,j) - area;
end


end
