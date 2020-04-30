function Cnew = advection_bottomleft_y[x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold];

% mx < 0 && my < 0
dy = dt*v;
slope = -1/(my/mx);
% function that determines what cell the new geometry is on
% y + dt*v  <- floor to nearest y grid
% the value will be called new_y
new_y = 2;
new_y_r = yright + dy; %new_y_right
new_y_l = yleft + dy; %new_y_left

% (-,-) v is positive (2,3)
    if new_y_r < new_y && new_y_l > new_y
       xverticies = [xleft + (new_y - new_y_l)/slope, xright, xright, xleft];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
    
    if new_y_r >= new_y && new_y_l > new_y
        xverticies = [xright, xright, xleft];
        yverticies = [new_y_r, new_y_l, new_y_l];
    end

% (-,-) v is positive (2,4)
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [xleft + (new_y - new_y_l)/slope, x+h, x+h, xleft];
       yverticies = [new_y, new_y, new_y_l, new_y_l]; 
    end
% (-,-) v is positive (1,4)

    if new_y_r < new_y && new_y_l < new_y
       xverticies = [xleft, x+h, x+h, xleft];
       yverticies = [new_y, new_y, y+h+dy, y+h+dy]; 
    end
    
    if new_y_r <= new_y && new_y_l > new_y
       xverticies = [xleft, xleft + (new_y - new_y_l)/slope, x+h, x+h,  xleft];
       yverticies = [new_y_l, new_y, new_y, y+h+dy, y+h+dy]; 
    end
    
% (-,-) v is positive (1,3)

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
