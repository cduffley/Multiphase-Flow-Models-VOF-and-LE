function Cnew = advectionTot(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C,Cnew)
%Cnew is initialized as zeros, then added to 
for m=1:length(x)
    
    for n=1:length(y)
        
        
        if u > 0
            [CnewX,shift_x] = advectionXpos(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C);
        elseif u < 0
            [CnewX,shift_x] = advectionXneg(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C);
        elseif u==0
            CnewX = zeros(size(C));
            shift_x = 0;
        end
    Cnew(i+shift_x,j) = Cnew(i+shift_x,j) + CnewX(i+shift_x,j);
    Cnew(i+shift_x-1,j) = Cnew(i+shift_x-1,j) + CnewX(i+shift_x-1,j);
    end
end

    
% some reconstruction funtion    
[C,alpha,yleft,ect] = reconstruct(x,y,ect)

for m=1:length(x)
    
    for n=1:length(y)
        
        
        if v > 0
            [CnewY,shift_y] = advectionYpos(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C);
        elseif v < 0
            [CnewY,shift_y] = advectionYneg(x,y,h,i,j,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,C);
        elseif v==0
            CnewY = zeros(size(C));
            shift_y = 0;
        end
    Cnew(i,j+shift_y) = Cnew(i,j+shift_y) + CnewX(i,j+shift_y);
    Cnew(i,j+shift_y-1) = Cnew(i,j+shift_y-1) + CnewX(i,j+shift_y-1);
    end
end

% some reconstruction funtion again    
[C,alpha,yleft,ect] = reconstruct(x,y,ect)

end




