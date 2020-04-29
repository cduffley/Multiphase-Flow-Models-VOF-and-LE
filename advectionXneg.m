function [Cx,num_shift] =advectionXneg(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C,Cold)



%% ====================================================================%
%% ====================================================================%
%% ====================================================================%
% negative
% x_new is still to the left of the cell
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



%% 1 -----------------------------------------------------------------
%copied from +2
% (+,+), (2,3)
% copied from (-,+) u is positive (1,2)
if mx > 0 && my > 0
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
        yverticies = [y, y, yright, yright - (new_x_r - (new_x+h))*slope];
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
    
    if new_x_l >= new_x && new_x_r < new_x
        xverticies = [new_x_l, new_x+h, new_x+h, new_x_r];
        yverticies = [y, y, yright, yright];
    end
end
end

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

%% 4 copied from +3   
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
       yverticies = [(new_x_l-new_x)*-slope + y,y,y,y+h,y+h]; 
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
       yverticies = [(new_x_l-new_x)*-slope + yright,yright,y+h,y+h]; 
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
       yverticies = [(new_x_l-new_x)*-slope + yright,yright,y+h,y+h]; 
    end
 end
end



end