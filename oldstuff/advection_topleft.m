
function Cnew = advection_topleft[x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold];

% mx < 0 && my > 0
dx = dt*u;
% function that determines what cell the new geometry is on
% x + dt*u  <- floor to nearest x grid
% the value will be called new_x
new_x = 2;
new_x_r = xright + dx; %new_x_right
new_x_l = xleft + dx; %new_x_left

% (-,+) u is positive (1,2)
    if new_x_l < new_x && new_x_r < new_x
       xverticies = [new_x, x+h+dx, x+h+dx, new_x];
       yverticies = [y, y, yright, yright]; 
    end
    
    if new_x_l <= new_x && new_x_r > new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x_r, new_x];
        yverticies = [y, y, yright, yright, yright - (new_x_r - new_x)*slope];
    end

% (-,+) u is positive (1,3)
   
    if new_x_l <= new_x && new_x_r > new_x
       xverticies = [new_x, new_x_r, new_x_r, new_x];
       yverticies = [y, y, yright, yright - (new_x_r - new_x)*slope]; 
    end
    
% (-,+) u is positive (3,4)

    if new_x_l < new_x && new_x_r > new_x
        xverticies = [new_x, new_x_r, new_x_r, new_x];
        yverticies = [y, y, yright, yright - (new_x_r - (new_x+h))*slope];
    end
    
    if new_x_l >= new_x
        xverticies = [new_x_l, new_x_r, new_x_r];
        yverticies = [y, y, yright];
    end
% (-,+) u is positive (4,2)

    if new_x_l < new_x && new_x_r < new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x];
        yverticies = [y, y, yright, yright];
    end 
        
    if new_x_l < new_x && new_x_r > new_x
        xverticies = [new_x, x+h+dx, x+h+dx, new_x_r, new_x];
        yverticies = [y, y, yright, yright, yright - (new_x_r - (new_x))*slope];
    end
    
    if new_x_l >= new_x && new_x_r < new_x
        xverticies = [new_x_l, new_x+h, new_x+h, new_x_r];
        yverticies = [y, y, yright, yright];
    end

end
