function C = CFDtri1(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y,C)
% For analyzing the function line-by-line, refer to CFDtri2, since it does
% a very similar process but the variable names are more intuitive. Since
% it was written later, it is also more robust and can likely perform for
% uneven meshes. This function *should* do fine with uneven meshes, but it
% has not been tested for many different scenarios.

% The two triangle functions determine the areas of triangle and polygonal
% shape created by the intersection of two sides of the grid. The pattern
% that this fucntion checks is the alternating x-grid and y-grid
% intersections. This function checks for the pattern:
% "y-grid intersection, x-grid intersection, y-grid intersection"
% |ooooooooo\\ooooo|oooooooooooooooo|oooooooooooooooo|
% |oooooooooo\\oooo|oooooooooooooooo|oooooooooooooooo|
% |-----------X----|----------------|----------------| <-- this point A
% |oooooooooooo\\oo|oooooooooooooooo|oooooooooooooooo|
% |oooooooooooooo\\|oooooooooooooooo|oooooooooooooooo|
% |ooooooooooooooo\X\ooooooooooooooo|oooooooooooooooo|<-- this point B
% |oooooooooooooooo|o\\ooooooooooooo|oooooooooooooooo|
% |oooooooooooooooo|ooo\\ooooooooooo|oooooooooooooooo|
% |----------------|-----X----------|----------------|<-- this point C
% |oooooooooooooooo|ooooo\\ooooooooo|oooooooooooooooo|
% |oooooooooooooooo|oooooooo\\\ooooo|oooooooooooooooo|
% |oooooooooooooooo|oooooooooo\\oooo|oooooooooooooooo|
% |oooooooooooooooo|oooooooooooo\\oo|oooooooooooooooo|
% once it does this, it determins the area of the small triangle to the
% left of the middle point (between A and B) and also the polygon to to the
% right of the middle point 


[m,leftcir_min] = min(cir_yloc_x1); %xvales on left
[m,rightcir_max] = max(cir_yloc_x2); %xvalues on right

%%bottom left
isdoubletri = false;

for i_xy=1:leftcir_min %through the left x values, first half is the bottom
    
    for i_xx=1:length(cir_xloc_y1) %runs through the bottom y values
        trap = false;              % determining if calculated y values 
                                   % (from x-grid) surround it
        if cir_yloc_x1(i_xy) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy) <= cir_xloc_x(i_xx+1) && trap ==false
   
           if i_xy ~=leftcir_min && (cir_yloc_x1(i_xy+1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy+1) <= cir_xloc_x(i_xx+1))
                %making sure it is not a trapezoid
             trap = true;
           end
           
           if i_xy ~= 1 && (cir_yloc_x1(i_xy-1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy-1) <= cir_xloc_x(i_xx+1))
              %making sure it is not a trapezoid
            trap = true;
           end
           
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end

        end 
    end
    if isdoubletri == true
        % small tri, on 'right'
    linear_distance = ((cir_yloc_x1(i_xy)- cir_xloc_x(i_xxhold+1))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y1(i_xxhold+1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy1(i_xy)+1) - cir_yloc_x1(i_xy))/2 * abs( y(ynodefromx1(i_xxhold))...
                - cir_xloc_y1(i_xxhold+1));
    area = area_tri + area_sliver;
    C(xnodefromy1(i_xy),ynode(i_xy)-1) = area/h^2;

        % cut rect, one the 'left'
    linear_distance = ((cir_yloc_x1(i_xy)- cir_xloc_x(i_xxhold))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y1(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy1(i_xy)) - cir_yloc_x1(i_xy))/2 * abs( y(ynodefromx1(i_xxhold))...
                - cir_xloc_y1(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(xnodefromy1(i_xy),ynode(i_xy)) = area/h^2;
    isdoubletri = false;
     
    end   
end

%% top left
% repeat process
isdoubletri = false;
for i_xy=leftcir_min:length(cir_yloc_x1) 
    for i_xx=1:length(cir_xloc_y2) 
    trap = false;
         
           if cir_yloc_x1(i_xy) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy) <= cir_xloc_x(i_xx+1) && trap ==false
           
           if i_xy ~=length(cir_yloc_x1) && (cir_yloc_x1(i_xy+1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy+1) <= cir_xloc_x(i_xx+1))
             trap = true;
           end
           
           if i_xy ~= 1 && (cir_yloc_x1(i_xy-1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy-1) <= cir_xloc_x(i_xx+1))
            trap = true;
           end 
            
            
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end
        end 
    end
    if isdoubletri == true
        % small tri, on 'right'
    linear_distance = ((cir_yloc_x1(i_xy)- cir_xloc_x(i_xxhold+1))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y2(i_xxhold+1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy1(i_xy)+1) - cir_yloc_x1(i_xy))/2 * abs( y(ynodefromx2(i_xxhold)+1)...
                - cir_xloc_y2(i_xxhold+1));
    area = area_tri + area_sliver;
    C(xnodefromy1(i_xy),ynode(i_xy)) = area/h^2;
    
    
        % cut rect, on the 'left'
    linear_distance = ((cir_yloc_x1(i_xy)- cir_xloc_x(i_xxhold))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y2(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy1(i_xy)) - cir_yloc_x1(i_xy))/2 * abs( y(ynodefromx2(i_xxhold)+1)...
                - cir_xloc_y2(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(xnodefromy1(i_xy),ynode(i_xy)-1) = area/h^2;
    isdoubletri = false;
    
      
    end   
end

%% 3rd one, bottom right
% repeat process 
isdoubletri = false;
for i_xy=1:rightcir_max
    
    for   i_xx=1:length(cir_xloc_y2)-1 
    trap = false;
        
       if cir_yloc_x2(i_xy) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy) <= cir_xloc_x(i_xx+1) && trap ==false
           
            if i_xy ~=rightcir_max && (cir_yloc_x2(i_xy+1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy+1) <= cir_xloc_x(i_xx+1))
             trap = true;
           end
           
           if i_xy ~= 1 && (cir_yloc_x2(i_xy-1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy-1) <= cir_xloc_x(i_xx+1))
            trap = true;
           end  
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end
        end 
    end
    if isdoubletri == true
        % small tri, on 'left'
    linear_distance = ((cir_yloc_x2(i_xy)- cir_xloc_x(i_xxhold))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y1(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy2(i_xy)) - cir_yloc_x2(i_xy))/2 * abs( y(ynodefromx1(i_xxhold)+1)...
                - cir_xloc_y1(i_xxhold));
    area = area_tri + area_sliver;
    C(xnodefromy2(i_xy),ynode(i_xy)-1) = area/h^2;
    
    
        % cut rect, one the 'right'
    linear_distance = ((cir_yloc_x2(i_xy)- cir_xloc_x(i_xxhold+1))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y1(i_xxhold+1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy2(i_xy) +1) - cir_yloc_x2(i_xy))/2 * abs( y(ynodefromx1(i_xxhold)+1)...
                - cir_xloc_y1(i_xxhold +1));
    area = h^2 - area_tri + area_sliver;
    C(xnodefromy2(i_xy),ynode(i_xy)) = area/h^2;
    isdoubletri = false;  
    end   
end

%% 4th one, top right
% repeat process
isdoubletri = false;

for i_xy=rightcir_max:length(cir_yloc_x2)
    
     for i_xx=rightcir_max:length(cir_xloc_x)-1

       trap = false;
        if cir_yloc_x2(i_xy) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy) <= cir_xloc_x(i_xx+1) && trap ==false
        
            if i_xy ~=length(cir_yloc_x2) && (cir_yloc_x2(i_xy+1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy+1) <= cir_xloc_x(i_xx+1))
             trap = true;
           end
           
           if i_xy ~= 1 && (cir_yloc_x2(i_xy-1) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy-1) <= cir_xloc_x(i_xx+1))
            trap = true;
           end 
           
          if trap == false
          isdoubletri = true;
          i_xxhold = i_xx;
          end
        end 
    end
    if isdoubletri == true
        % small tri, on 'left'
    linear_distance = ((cir_yloc_x2(i_xy)- cir_xloc_x(i_xxhold))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y2(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy2(i_xy)) - cir_yloc_x2(i_xy))/2 * abs( y(ynodefromx2(i_xxhold))...
                - cir_xloc_y2(i_xxhold));
    area = area_tri + area_sliver;
    C(xnodefromy2(i_xy),ynode(i_xy)) = area/h^2;
    
    
        % cut rect, one the 'right'
    linear_distance = ((cir_yloc_x2(i_xy)- cir_xloc_x(i_xxhold+1))^2 +...
        (cir_yloc_y(i_xy)- cir_xloc_y2(i_xxhold+1))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(xnodefromy2(i_xy) +1) - cir_yloc_x2(i_xy))/2 * abs( y(ynodefromx2(i_xxhold))...
                - cir_xloc_y2(i_xxhold +1));
    area = h^2 - area_tri + area_sliver;
    C(xnodefromy2(i_xy),ynode(i_xy)-1) = area/h^2;
    isdoubletri = false;  
    end   
end
end