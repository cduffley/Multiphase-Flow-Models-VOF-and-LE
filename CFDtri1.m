function C = CFDtri1(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y,C)
[m,leftcir_min] = min(cir_yloc_x1); %xvales on left
[m,rightcir_max] = max(cir_yloc_x2); %xvalues on right

%%bottom left
isdoubletri = false;
% for i_xy=1:leftcir_min %from 1 to half the bottom (left half)
for i_xy=1:leftcir_min %through the left x values, first half is the bottom
    
    for i_xx=1:length(cir_xloc_y1) %1 to the whole bottom half (also the whole lenght of x mesh values (no repeats)
        trap = false;
        if cir_yloc_x1(i_xy) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x1(i_xy) <= cir_xloc_x(i_xx+1) && trap ==false
   
           if i_xy ~=leftcir_min && (cir_yloc_x1(i_xy+1) >= cir_xloc_x(i_xx) && ...
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

%% top left, change node values, y1 to y2 to get tops
isdoubletri = false;
%for i_xy=rightcir_min:length(cir_yloc_x1) %right half top circle
for i_xy=leftcir_min:length(cir_yloc_x1) %values on left, second half is top
    for i_xx=1:length(cir_xloc_y2) % all mesh values given 
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
% x will be at second half of 1, y will be on 2 
isdoubletri = false;
for i_xy=1:rightcir_max %values on right, first half is bottom
    
    for   i_xx=1:length(cir_xloc_y2)-1 %skips last point, i believe others that start on left skip point inherently
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
isdoubletri = false;

% for i_xy=rightcir_max:length(cir_yloc_x2)
for i_xy=rightcir_max:length(cir_yloc_x2)
    
     for i_xx=rightcir_max:length(cir_xloc_x)-1

       trap = false;
        if cir_yloc_x2(i_xy) >= cir_xloc_x(i_xx) && ...
                cir_yloc_x2(i_xy) <= cir_xloc_x(i_xx+1) && trap ==false
            %changed cir_xloc_y2 to cir_yloc_x2
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