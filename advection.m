function Cnew = advection(x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold)

% x, y, h,xleft, xright, yleft, yright alpha, calc'd color, u, v

% maybe mx, my, alpha
% x,y, xleft, yleft, xright, yright,
%

% 
dx = dt*u;
% function that determines what cell the new geometry is on
% x + dt*u  <- floor to nearest x grid (new x right)
%the value will be called new_x

new_x = x + floor((dt*u)/h) * h; %% only for u is positive
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left

%% ====================================================================%
%% ====================================================================%
%% ====================================================================%
%positive
if u>=0
new_x = x + floor((dt*u)/h) * h;

%% 1 -----------------------------------------------------------------
%(+,+) u is positive (2,3)
if mx > 0 && my > 0
    
    if new_x_l >= new_x 
        xverticies = [x_new, new_x_r, new_x_r, new_x_l,new_x];
        yverticies = [y,y,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,(new_x_r-new_x)*-slope + yright]; 
    end
end

% (2,4)
if mx > 0 && my > 0
    
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
       yverticies = [y,y,(new_x_right-new_x)*-slope + y]; 
    end
    
end

% (1,4)
if mx > 0 && my > 0
    
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
if mx > 0 && my > 0
    
    if new_x_l >= new_x %same thing
        xverticies = [xleft,xright,xright,xleft];
        yverticies = [y,y,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,yright+(new_x-new_x_l)*-slope]; 
    end
end
%% -----------------------------------------------------------------------

%% 2 dan -----------------------------------------------------------------

%% 3 joel -----------------------------------------------------------------


%% 4 -----------------------------------------------------------------
% (+,-) pos u, pos slope 
%(1,2)
if mx > 0 && my < 0
    
    if new_x_l >= new_x %same thing
        xverticies = [x_new_l, new_x_r, new_x_l];
        yverticies = [yleft,yright,yright];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,yright];
    end
end

%(1,3)
if mx > 0 && my < 0
    
    if new_x_l >= new_x %same thing, again
        xverticies = [x_new_l, new_x_r, new_x_r,x_new_l];
        yverticies = [yleft,yright,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end

%(4,3)
if mx > 0 && my < 0
    
    if new_x_l >= new_x %
        xverticies = [x_new, new_x_l, new_x_r,x_new_r,new_x];
        yverticies = [yleft,yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end

%(4,2)
if mx > 0 && my < 0
    
    if new_x_l >= new_x && x+dx < new_x 
        xverticies = [x_new, new_x_l, new_x_r,new_x];
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


%% ====================================================================%
%% ====================================================================%
%% ====================================================================%
% negative
% x_new is still to the left of the cell
% dx is a negative value
elseif u<0
new_x = x + floor((dt*-u)/h) * h;
    
%% 1

%% 2
% copied from pos u 4
%(1,2)
if mx < 0 && my > 0
    
    if new_x_l >= new_x %same thing
        xverticies = [x_new_l, new_x_r, new_x_l];
        yverticies = [yleft,yright,yright];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,yright];
    end
end

%(1,3)
if mx < 0 && my > 0
    
    if new_x_l >= new_x %same thing, again
        xverticies = [x_new_l, new_x_r, new_x_r,x_new_l];
        yverticies = [yleft,yright,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end

%(4,3)
if mx < 0 && my > 0
    
    if new_x_l >= new_x %
        xverticies = [x_new, new_x_l, new_x_r,x_new_r,new_x];
        yverticies = [yleft,yleft,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [yright - (new_x_r - new_x)*slope,yright,y+h,y+h];
    end
end

%(4,2)
if mx < 0 && my > 0
    
    if new_x_l >= new_x && x+dx < new_x 
        xverticies = [x_new, new_x_l, new_x_r,new_x];
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

%% 3 (-,-)
% copied from (+,+) u is positive
%(1,4) from 1(2,3)
if mx < 0 && my < 0
    
    if new_x_l >= new_x 
        xverticies = [x_new, new_x_r, new_x_r, new_x_l,new_x];
        yverticies = [y,y,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,(new_x_r-new_x)*-slope + yright]; 
    end
end

% (2,4)
if mx < 0 && my < 0
    
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
       yverticies = [y,y,(new_x_right-new_x)*-slope + y]; 
    end
    
end

% (1,4)
if mx < 0 && my < 0
    
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
if mx < 0 && my < 0
    
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


end