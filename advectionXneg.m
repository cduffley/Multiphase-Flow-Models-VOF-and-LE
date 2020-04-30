function [Cx,num_shift] =advectionXneg(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold)

% done #2, copied from #1, and implemented #2 conditions
% done #1, copied from #2, and implemented #1 conditions
% done #3, copied from #4, and implemented #3 conditions
% done #4, copied from #3, and implemented #4 conditions

xverticies = [0,0,0]; % inserted bc some alpha isnt coming out okay
yverticies = [0,0,0];


%% ====================================================================%
%% ====================================================================%
%% ====================================================================%
% negative
% new_x is still to the left of the cell
% dx is a negative value
dx = dt*-u;
% function that determines what cell the new geometry is on
% x + dt*u  <- floor to nearest x grid (new x right)
%the value will be called new_x
xleft = x+h/2 - xleft + x+h/2;
xright = x+h/2 - xright + x+h/2;
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left
new_x = x + floor((dt*-u)/h) * h;
slope = my/mx; %switching to opposite
slopeold = -1/(my/mx); %for condition statements


% ====================================================================%
% ====================================================================%
% ====================================================================%
%% 1 -----------------------------------------------------------------
%need to update line naming like done in the ones below (3 and 4)
%copied from +2
% (+,+), (2,3)
% copied from (-,+) u is positive (1,2)
if mx > 0 && my > 0
if mx/alpha > h && my/alpha > h
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
if mx/alpha >= h && my/alpha <= h 
    if new_x_l <= new_x && new_x_r > new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [y, y, yright, yright - (new_x_r - new_x)*slope]; 
    end
end   
% (-,+) u is positive (3,4)
if mx/alpha <= h && my/alpha <= h
    if new_x_l < new_x && new_x_r > new_x
        xverticies = [new_x, new_x_r, new_x_r, new_x];
        yverticies = [y, y, yright, yright - (new_x_r - (new_x+h))*slope];
    end
    
    if new_x_l >= new_x
        xverticies = [new_x_l, new_x_r, new_x_r];
        yverticies = [y, y, yright];
    end
end

if mx/alpha <= h && my/alpha >= h
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

%% 3
% ====================================================================%
% ====================================================================%
% ====================================================================%

% copied from pos u 4
%(1,2)
% (+,-) pos u, pos slope 
if mx < 0 && my < 0
  if alpha/mx > h && alpha/my > h
      %(1,2) now (2,3)
    if new_x_l >= new_x %same thing
        xverticies = [new_x_l, new_x_r, new_x_l];
        yverticies = [yleft,yright,yright];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,yright];
    end
  end


%(1,3) now (1,3)
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


%(4,3) now (1,4) condish
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

%(4,2) now (2,4)
if alpha/mx < h && alpha/my > h
    
    if new_x_l >= new_x && x+dx < new_x 
        xverticies = [new_x, new_x_l, new_x_r,new_x];
        yverticies = [yleft,yleft,yright,y+h,y+h];
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

%% 2 (-,+)
% ====================================================================%
% ====================================================================%
% ====================================================================%
%need to update line naming like done in the one below (4)
% copied from (+,+) u is positive
%(+,+) u is positive (2,3)
if mx < 0 && my > 0

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

% (2,4)
if alpha/mx > 0 && slopeold*(h-alpha/mx) > h
    
    if new_x_l >= new_x && x+dx < new_x
        xverticies = [x+dx +(new_x-(x+dx)) new_x, new_x_r,new_x_l,new_x];
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

% (1,3)
if alpha/mx < 0 && slopeold*h + alpha/my < h
    if new_x_l >= new_x %same thing
        xverticies = [xleft,xright,xright,xleft];
        yverticies = [y,y,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,yright+(new_x-new_x_l)*-slope]; 
    end
end
end

%% 4 copied from +3 
% ====================================================================%
% ====================================================================%
% ====================================================================%
 % (+,-) u is positive
if mx < 0 && my < 0
 if alpha/mx > 0 && (h - alpha/mx)*(slopeold) < h
    %(1,4) now (4,3)
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
     %(2,4) now (4,2)
    if new_x_l > new_x && new_x_r > new_x %%same thing
       xverticies = [xright, x+h, x+h, xleft];
       yverticies = [y,y,y+h,y+h];
    end
    
    if new_x_l < new_x && new_x_r  > new_x
       xverticies = [new_x, new_x_r, x+h+dx, x+h+dx,new_x];
       yverticies = [(new_x_l-new_x)*-slope + y,y,y,y+h,y+h]; 
    end
    
    if new_x_l < new_x && new_x_r < new_x
       xverticies = [new_x, x+h+dx, x+h+dx, new_x];
       yverticies = [y,y,y+h,y+h];
    end
 end  
 
 if alpha/mx < 0 && (h - alpha/my)*(1/slopeold) > h
    %(1,3) now (1,3)
    if new_x_l > new_x 
       xverticies = [new_x_l, new_x_r, new_x_r, new_x_l];
       yverticies = [yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [(new_x_l-new_x)*-slope + yright,yright,y+h,y+h]; 
    end
 end   
 
 if alpha/mx < 0 && (h - alpha/my)*(1/slopeold) < h
    %(2,3) now (1,2)
    if new_x_l > new_x 
       xverticies = [new_x_l, new_x_r, new_x_r];
       yverticies = [yleft,yright,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [(new_x_l-new_x)*-slope + yright,yright,y+h,y+h]; 
    end
 end
end
area = polyarea(xverticies,yverticies)/h^2; %fraction!!
Cx = zeros(size(C));
num_shift = floor((dt*u)/h); %this means h is in meters
Cx(i+num_shift-1,j) = area;
Cx(i+num_shift,j) = C(i,j) - area;


end