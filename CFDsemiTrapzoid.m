function C = CFDsemiTrapzoid(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y)

[m,leftcir_min] = min(cir_xloc_y1);
[m,rightcir_max] = max(cir_xloc_y2);
[m,botcir_min] = min(cir_yloc_x1);
[m,topcir_max] = max(cir_yloc_x2);

bot_ycir_x = [cir_yloc_x1(1:botcir_min),cir_yloc_x2(1:topcir_max)];
top_ycir_x = [cir_yloc_x1(botcir_min:end),cir_yloc_x2(topcir_max:end)];
left_xcir_y = [cir_xloc_y1(1:leftcir_min),cir_xloc_y2(1:rightcir_max)];
right_xcir_y = [cir_xloc_y1(leftcir_min:end),cir_xloc_y2(rightcir_max:end)];



C=zeros(length(x),length(y));
%first area, bottom (x) semi trapizoid
% xvalues, from y, from the bottom of the circle
istrap = true;
for i_xx=1:length(cir_xloc_y1) -1
    
%     for i_yx=1:length(cir_yloc_x)
    for i_yx=1:length(bot_ycir_x)
    
        if bot_ycir_x(i_yx) >= cir_xloc_x(i_xx) && ... %was cir_yloc_x
                bot_ycir_x(i_yx) <= cir_xloc_x(i_xx+1)
            
             istrap = false;
        end 
    end
    if istrap == true
    linear_distance = ((cir_xloc_x(i_xx+1)- cir_xloc_x(i_xx))^2 +...
        (cir_xloc_y1(i_xx+1)- cir_xloc_y1(i_xx))^2)^(1/2);
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    area_sliver = area_sector-area_triangle;
    area_trap = (abs( y(ynodefromx1(i_xx)+1) - cir_xloc_y1(i_xx)) +abs( y(ynodefromx1(i_xx)+1)...
                - cir_xloc_y1(i_xx+1)))/2 * h;
    area = area_trap + area_sliver;
    C(xnode(i_xx),ynodefromx1(i_xx)) = area/h^2;
    else
       istrap = true;   
    end   
end
 
% top (x) semi trapizoid
istrap = true;
for i_xx=1:length(cir_xloc_y2) -1
    
    for i_yx=1:length(top_ycir_x)
    
        if top_ycir_x(i_yx) > cir_xloc_x(i_xx) && ... %was cir_yloc_x
                top_ycir_x(i_yx) < cir_xloc_x(i_xx+1)
            
             istrap = false;
        end 
    end
    if istrap == true
    linear_distance = ((cir_xloc_x(i_xx+1)- cir_xloc_x(i_xx))^2 +...
        (cir_xloc_y2(i_xx+1)- cir_xloc_y2(i_xx))^2)^(1/2);
   
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    
    area_sliver = area_sector-area_triangle;
    area_trap = (abs( y(ynodefromx2(i_xx)) - cir_xloc_y2(i_xx)) +abs( y(ynodefromx2(i_xx))...
                - cir_xloc_y2(i_xx+1)))/2 * h;
    area = area_trap + area_sliver;
    C(xnode(i_xx),ynodefromx2(i_xx)) = area/h^2;
    else
       istrap = true;   
    end   
end
 
istrap = true;
% left (y) semi trapizoid
% gonna try to just switch every x/y
for i_yy=1:length(cir_yloc_x1) -1
    
    for i_xy=1:length(left_xcir_y)
    
        if left_xcir_y(i_xy) > cir_yloc_y(i_yy) && ...
                left_xcir_y(i_xy) < cir_yloc_y(i_yy+1)
            
             istrap = false;
        end 
    end
    if istrap == true
    linear_distance = ((cir_yloc_y(i_yy+1)- cir_yloc_y(i_yy))^2 +...
        (cir_yloc_x1(i_yy+1)- cir_yloc_x1(i_yy))^2)^(1/2);
   
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    
    area_sliver = area_sector-area_triangle;
    area_trap = (abs( x(xnodefromy1(i_yy)+1) - cir_yloc_x1(i_yy)) +abs( x(xnodefromy1(i_yy)+1)...
                - cir_yloc_x1(i_yy+1)))/2 * h;
    area = area_trap + area_sliver;
    C(xnodefromy1(i_yy),ynode(i_yy)) = area/h^2;
    else
       istrap = true;   
    end   
end
 
istrap = true;
% right (y) semi trapizoid
% gonna try to just switch every x/y
for i_yy=1:length(cir_yloc_x2) -1
    
    for i_xy=1:length(right_xcir_y)
    
        if right_xcir_y(i_xy) > cir_yloc_y(i_yy) && ...
                right_xcir_y(i_xy) < cir_yloc_y(i_yy+1)
            
             istrap = false;
        end 
    end
    if istrap == true
    linear_distance = ((cir_yloc_y(i_yy+1)- cir_yloc_y(i_yy))^2 +...
        (cir_yloc_x2(i_yy+1)- cir_yloc_x2(i_yy))^2)^(1/2);
   
    angle = 2 * asin(linear_distance/2 / r);
    area_sector = angle/(2*pi) * pi*r^2;
    area_triangle = linear_distance/2 * r*cos(angle/2);
    
    area_sliver = area_sector-area_triangle;
    area_trap = (abs( x(xnodefromy2(i_yy)) - cir_yloc_x2(i_yy)) +abs( x(xnodefromy2(i_yy))...
                - cir_yloc_x2(i_yy+1)))/2 * h;
    area = area_trap + area_sliver;
    C(xnodefromy2(i_yy),ynode(i_yy)) = area/h^2;
    else
       istrap = true;   
    end   
end
