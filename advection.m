
% x, y, h,xleft, xright, yleft, yright alpha, calc'd color, u, v

% maybe mx, my, alpha
% x,y, xleft, yleft, xright, yright,
% 

function Cnew = [x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold];

dx = dt*u;
% function that determines what cell the new geometry is on
% x + dt*u  <- floor to nearest x grid (new x right)
%the value will be called new_x

new_x = x + floor((dt*u)/h) * h; %% only for u is positive
new_x = x + ceil((dt*u)/h) * h;
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left

if u>=0
new_x = x + floor((dt*u)/h) * h;
%% 1 
%(+,+) u is positive (2,3)
if mx > 0 && my > 0
    
    if new_x_l >= new_x 
        xverticies = [x_new, new_x_r, new_x_r, new_x_l,new_x];
        yverticies = [y,y,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,(new_x_right-new_x)*-slope + yright]; 
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
        xverticies = [xleft,xright,xleft,xright];
        yverticies = [y,y,yright,yleft];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,yright+(new_x-new_x_l)*-slope]; 
    end
end

elseif u<0
    
end


end