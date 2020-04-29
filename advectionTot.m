function [Cr,xleft,xright,yleft,yright,mx,my] = advectionTot(x,y,h,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,Cr)
%Cnew is initialized as zeros, then added to 
%initial mx,my,xr,xl,yr,yl
%C is inital CF
Cnew = zeros(size(Cr));

for i=1:length(x)
    
    for j=1:length(y)
        
        if mx(i,j) == 0 && my(i,j) ==0
         return
        end
        if u(i,j) > 0
            [CnewX,shift_x] = advectionXpos(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif u(i,j) < 0
            [CnewX,shift_x] = advectionXneg(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif u(i,j)==0
            CnewX = zeros(size(Cr));
            shift_x = 0;
        end
%     Cnew(i+shift_x,j) = Cnew(i+shift_x,j) + CnewX(i+shift_x,j);
%     Cnew(i+shift_x-1,j) = Cnew(i+shift_x-1,j) + CnewX(i+shift_x-1,j);
      Cnew = Cnew + CnewX;
      % this works becuase CnewX is all zeros except the two split values
      % and Cnew is only an accumulation of multiple CnewXs. aka, Cnew does
      % not contain old Colorfunction values
    end
end

    
% some reconstruction funtion  
[mx,my] = youngsFD;
[Cr,xleft,xright,yleft,yright] = reconstruct(x,y,h,mx,my,Cnew);
Cnew = zeros(size(Cr));

for i=1:length(x)
    
    for j=1:length(y)
        
        if mx(i,j) == 0 && my(i,j) ==0
         return
        end
        if u(i,j) > 0
            [CnewY,shift_y] = advectionYpos(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif u(i,j) < 0
            [CnewY,shift_y] = advectionYneg(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);;
        elseif u(i,j)==0
            CnewY = zeros(size(Cr));
            shift_y = 0;
        end
%     Cnew(i,j+shift_y) = Cnew(i,j+shift_y) + CnewX(i,j+shift_y);
%     Cnew(i,j+shift_y-1) = Cnew(i,j+shift_y-1) + CnewX(i,j+shift_y-1);
      Cnew = Cnew + CnewY;
    end
end

% some reconstruction funtion again
[mx,my] = youngsFD;
[Cr,xleft,xright,yleft,yright] = reconstruct(x,y,h,mx,my,Cnew);

%final C is set as Cr

end




