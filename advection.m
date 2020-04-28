
% x, y, h,xleft, xright, yleft, yright alpha, calc'd color, u, v

% maybe mx, my, alpha
% x,y, xleft, yleft, xright, yright,
%

function Cnew = [x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold];

dx = dt*u;
% function that determines what cell the new geometry is on
% x + dt*u  <- floor to nearest x grid
%the value will be called new_x
new_x = 2;
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left


% #1 (+,+) u is positive (2,3)
if mx > 0 && my > 0
    
    if new_x_l > new_x 
        xverticies = [new_x, new_x_r, new_x_r, new_x_l,new_x];
        yverticies = [y,y,yright,y+h,y+h];
    end
    
    if new_x_l < new_x
       xverticies = [new_x,new_x_r,new_x_r,new_x];
       yverticies = [y,y,yright,(new_x_right-new_x)*-slope + yright]; 
    end
end