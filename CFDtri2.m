function C = CFDtri2(cir_xloc_x,cir_yloc_y,cir_yloc_x, ...
    cir_xloc_y,cir_xloc_y1, cir_xloc_y2, cir_yloc_x1,cir_yloc_x2,...
    ynodefromx1, ynodefromx2, xnodefromy1, xnodefromy2, xnode, ynode,...
    h,r,x,y,C,leftcir_min,rightcir_max)


[m,leftcir_min] = min(cir_xloc_y1);
[m,rightcir_max] = max(cir_xloc_y2);
[m,botcir_min] = min(cir_yloc_x1);
[m,topcir_max] = max(cir_yloc_x2);

bot_ycir_x = [cir_yloc_x1(1:botcir_min),cir_yloc_x2(1:topcir_max)];
top_ycir_x = [cir_yloc_x1(botcir_min:end),cir_yloc_x2(topcir_max:end)];
left_xcir_y = [cir_xloc_y1(1:leftcir_min),cir_xloc_y2(1:rightcir_max)];
right_xcir_y = [cir_xloc_y1(leftcir_min:end),cir_xloc_y2(rightcir_max:end)];

%%bottom left
isdoubletri = false;
% for i_xy=1:leftcir_min %from 1 to half the bottom (left half)
for i_xy=1:leftcir_min %through the left x values, first half is the bottom
    

