function Cnew = advection_bottomright_y[x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold];

% mx < 0 && my > 0
dy = dt*v;
slope = -1/(my/mx);
% function that determines what cell the new geometry is on
% y + dt*v  <- floor to nearest y grid
% the value will be called new_y
new_y = 2;
new_y_r = yright + dy; %new_y_right
new_y_l = yleft + dy; %new_y_left

% (+,-) v is positive (1,2)
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, x+h, x+h, xright];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, x+h, x+h, xright, x];
        yverticies = [new_y, new_y, y+h+dy, new_y_r, new_y_l];
    end

% (+,-) v is positive (1,3)
    if new_y_l < new_y && new_y_r > new_y
       xverticies = [xright - (new_y_r - new_y)/slope, xright, xright];
       yverticies = [new_y, new_y, new_y_r]; 
    end
    
    if new_y_l > new_y && new_y_r > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, new_y_r, new_y_l];
    end
    
    if new_y_l >= new_y && y+dy > new_y
        xverticies = [x, xright, xright, x];
        yverticies = [y+h+dy, y+h+dy, new_y_r, new_y_l];
    end
% (+,-) v is positive (3,4)

    if new_y_l < new_y && new_y_r < new_y
        xverticies = [x, xright, xright, x];
        yverticies = [new_y, new_y, y+h+dy, y+h+dy];
    end
    
    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [x, xright - (new_y_r - new_y)/slope, xright, xright, x];
       yverticies = [new_y, new_y, new_y_r, y+h+dy, y+h+dy]; 
    end
    

% (+,-) v is positive (4,2)

    if new_y_l <= new_y && new_y_r > new_y
       xverticies = [x, xright - (new_y_r - new_y)/slope, xright, x];
       yverticies = [new_y, new_y, new_y_r, new_y_r]; 
    end

end