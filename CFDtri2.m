function C = CFDtri2(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y,C)


[m,leftcir_min] = min(cir_xloc_y1); %takes the min of the bottom (y1(x)), 
                                    %tells us how many xvalues used on left
[m,rightcir_max] = max(cir_xloc_y2); %how many x values used on right
[m,botcir_min] = min(cir_yloc_x1); %takes the min of the left side (x1(y)) 
                                   %tells us how many yvalues used on bottom
[m,topcir_max] = max(cir_yloc_x2); %how many y values used on the top

botleft_ycir_x = cir_yloc_x1(1:botcir_min); % 1 for left
botleft_xcir_x = cir_xloc_x(1:leftcir_min); 
botleft_ycir_y = cir_yloc_y(1:botcir_min);
botleft_xcir_y = cir_xloc_y1(1:leftcir_min); % 1 for bot
botleft_xnodefromy = xnodefromy1(1:botcir_min); %1 for left
botleft_ynodefromx = ynodefromx1(1:leftcir_min); %1 for bot

botright_ycir_x = cir_yloc_x2(1:botcir_min); %here 2 is right
botright_xcir_x = cir_xloc_x(rightcir_max:end); 
botright_ycir_y = cir_yloc_y(1:botcir_min);
botright_xcir_y = cir_xloc_y1(rightcir_max:end); %here 1 is bottom
botright_xnodefromy = xnodefromy2(1:botcir_min);  %2 for right
botright_ynodefromx = ynodefromx1(rightcir_max:end); %1 for bot

topleft_ycir_x = cir_yloc_x1(topcir_max:end); % 1 is left, end is top
topleft_xcir_x = cir_xloc_x(1:leftcir_min); %left
topleft_ycir_y = cir_yloc_y(topcir_max:end); %end for top
topleft_xcir_y = cir_xloc_y2(1:leftcir_min); %2 for top
topleft_xnodefromy = xnodefromy1(topcir_max:end); %1 for left, end for top
topleft_ynodefromx = ynodefromx2(1:leftcir_min); %2 for top,

topright_ycir_x = cir_yloc_x2(topcir_max:end); % 1 is left, end is top
topright_xcir_x = cir_xloc_x(rightcir_max:end); %right
topright_ycir_y = cir_yloc_y(topcir_max:end); %end for top
topright_xcir_y = cir_xloc_y2(rightcir_max:end); %2 for top
topright_xnodefromy = xnodefromy2(topcir_max:end); %1 for left, end for top
topright_ynodefromx = ynodefromx2(rightcir_max:end); %2 for top,

% bottom left
isdoubletri = false;
for i_xy=1:length(botleft_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
   
    for i_xx=1:length(botleft_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  botleft_xcir_x(i_xx) < botleft_ycir_x(i_xy) &&... %botleft_ycir_x steps from large to small
              botleft_xcir_x(i_xx) > botleft_ycir_x(i_xy+1) && trap ==false%botleft_xcir_x steps from small to large
        
           if i_xx ~= length(botleft_xcir_x) && (botleft_ycir_x(i_xy) > botleft_xcir_x(i_xx+1) && ...
                botleft_ycir_x(i_xy+1) < botleft_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (botleft_ycir_x(i_xy) > botleft_xcir_x(i_xx-1) && ...
                botleft_ycir_x(i_xy+1) < botleft_xcir_x(i_xx-1))
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
    linear_distance = ((botleft_ycir_x(i_xy+1)- botleft_xcir_x(i_xxhold))^2 +...
        (botleft_ycir_y(i_xy+1)- botleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botleft_xnodefromy(i_xy)) - botleft_ycir_x(i_xy+1))/2 * abs( y(botleft_ynodefromx(i_xxhold)+1)...
                - botleft_xcir_y(i_xxhold));
    area = area_tri + area_sliver;
    C(botleft_xnodefromy(i_xy)-1,ynode(i_xy)) = area/h^2;

        % cut rect, one the 'right'
    linear_distance = ((botleft_ycir_x(i_xy)- botleft_xcir_x(i_xxhold))^2 +...
        (botleft_ycir_y(i_xy)- botleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botleft_xnodefromy(i_xy)) - botleft_ycir_x(i_xy))/2 * abs( y(botleft_ynodefromx(i_xxhold))...
                - botleft_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(botleft_xnodefromy(i_xy),ynode(i_xy)) = area/h^2;
    isdoubletri = false;
     
    end   

end

% bottom right, yet to be validated
isdoubletri = false;
for i_xy=1:length(botright_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
   
    for i_xx=1:length(botright_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  botright_xcir_x(i_xx) > botright_ycir_x(i_xy) &&... %botright_ycir_x steps from small to large
              botright_xcir_x(i_xx) < botright_ycir_x(i_xy+1) && trap ==false%botright_xcir_x steps from small to large
        
           if i_xx ~= length(botright_xcir_x) && (botright_ycir_x(i_xy) < botright_xcir_x(i_xx+1) && ...
                botright_ycir_x(i_xy+1) > botright_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (botright_ycir_x(i_xy) < botright_xcir_x(i_xx-1) && ...
                botright_ycir_x(i_xy+1) > botright_xcir_x(i_xx-1))
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
    linear_distance = ((botright_ycir_x(i_xy+1)- botright_xcir_x(i_xxhold))^2 +...
        (botright_ycir_y(i_xy+1)- botright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botright_xnodefromy(i_xy)+1) - botright_ycir_x(i_xy+1))/2 * abs( y(botright_ynodefromx(i_xxhold)+1)...
                - botright_xcir_y(i_xxhold));
    area = area_tri + area_sliver;
    C(botright_xnodefromy(i_xy)+1,ynode(i_xy)) = area/h^2; %+1 makes sense here for x but idk about others, ynode good for this but for others need other half

        % cut rect, one the 'left'
    linear_distance = ((botright_ycir_x(i_xy)- botright_xcir_x(i_xxhold))^2 +...
        (botright_ycir_y(i_xy)- botright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(botright_xnodefromy(i_xy)+1) - botright_ycir_x(i_xy))/2 * abs( y(botright_ynodefromx(i_xxhold))...
                - botright_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(botright_xnodefromy(i_xy),ynode(i_xy)) = area/h^2;
    isdoubletri = false;
     
    end   

end

% top left, reasonably validated
isdoubletri = false;
for i_xy=1:length(topleft_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
   
    for i_xx=1:length(topleft_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;

        if  topleft_xcir_x(i_xx) > topleft_ycir_x(i_xy) &&... %topleft_ycir_x steps from small to small
              topleft_xcir_x(i_xx) < topleft_ycir_x(i_xy+1) && trap ==false%topleft_xcir_x steps from small to large
        
           if i_xx ~= length(topleft_xcir_x) && (topleft_ycir_x(i_xy) < topleft_xcir_x(i_xx+1) && ...
                topleft_ycir_x(i_xy+1) > topleft_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (topleft_ycir_x(i_xy) < topleft_xcir_x(i_xx-1) && ...
                topleft_ycir_x(i_xy+1) > topleft_xcir_x(i_xx-1))
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
    linear_distance = ((topleft_ycir_x(i_xy)- topleft_xcir_x(i_xxhold))^2 +...
        (topleft_ycir_y(i_xy)- topleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topleft_xnodefromy(i_xy)+1) - topleft_ycir_x(i_xy))/2 * abs( y(topleft_ynodefromx(i_xxhold))...
                - topleft_xcir_y(i_xxhold));
    area = area_tri + area_sliver;
    C(topleft_xnodefromy(i_xy),ynode(topcir_max+i_xy-1)) = area/h^2;

        % cut rect, one the 'right'
    linear_distance = ((topleft_ycir_x(i_xy+1)- topleft_xcir_x(i_xxhold))^2 +...
        (topleft_ycir_y(i_xy+1)- topleft_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topleft_xnodefromy(i_xy+1)) - topleft_ycir_x(i_xy+1))/2 * abs( y(topleft_ynodefromx(i_xxhold)+1)...
                - topleft_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(topleft_xnodefromy(i_xy+1),ynode(topcir_max+i_xy-1)) = area/h^2;
    isdoubletri = false;
     
    end   

end


% top right, yet to be validated
isdoubletri = false;
for i_xy=1:length(topright_ycir_x)-1 %half of the grid xvales, determined by min of y1(x)
      
    for i_xx=1:length(topright_xcir_x) %cycling through x_x values to see if inbeteen y_x ones
      trap = false;
        if  topright_xcir_x(i_xx) < topright_ycir_x(i_xy) &&... %topright_ycir_x steps from large to small
              topright_xcir_x(i_xx) > topright_ycir_x(i_xy+1) && trap ==false%topright_xcir_x steps from small to large
        
           if i_xx ~= length(topright_xcir_x) && (topright_ycir_x(i_xy) > topright_xcir_x(i_xx+1) && ...
                topright_ycir_x(i_xy+1) < topright_xcir_x(i_xx+1))
             trap = true;
           end
           
           if i_xx ~= 1 && (topright_ycir_x(i_xy) > topright_xcir_x(i_xx-1) && ...
                topright_ycir_x(i_xy+1) < topright_xcir_x(i_xx-1))
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
    linear_distance = ((topright_ycir_x(i_xy)- topright_xcir_x(i_xxhold))^2 +...
        (topright_ycir_y(i_xy)- topright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topright_xnodefromy(i_xy)) - topright_ycir_x(i_xy))/2 * abs( y(topright_ynodefromx(i_xxhold))...
                - topright_xcir_y(i_xxhold));
    area = area_tri + area_sliver;
    C(topright_xnodefromy(i_xy),ynode(topcir_max+i_xy-1)) = area/h^2;

        % cut rect, one the 'left'
    linear_distance = ((topright_ycir_x(i_xy+1)- topright_xcir_x(i_xxhold))^2 +...
        (topright_ycir_y(i_xy+1)- topright_xcir_y(i_xxhold))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_tri = abs( x(topright_xnodefromy(i_xy+1)+1) - topright_ycir_x(i_xy+1))/2 * abs( y(topright_ynodefromx(i_xxhold)+1)...
                - topright_xcir_y(i_xxhold));
    area = h^2 - area_tri + area_sliver;
    C(topright_xnodefromy(i_xy)-1,ynode(topcir_max+i_xy-1)) = area/h^2;
    isdoubletri = false;
     
    end   

end
