function [Cr,xleft,xright,yleft,yright,mx,my,alpha] = advectionTot(x,y,h,mx,my,...
    xleft,xright,yleft,yright,alpha,u,v,dt,Cr)
%Cnew is initialized as zeros, then added to 
%initial mx,my,xr,xl,yr,yl
%C is inital CF
Cnew = zeros(size(Cr));

for i=2:length(x)-1
    
    for j=2:length(y)-1
        
        if mx(i,j) == 0 && my(i,j) ==0 && Cr(i,j) == 0
         continue
        end
        if i == 19 && j == 29
            d = 0;
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
            CnewX(i,j) = Cr(i,j);
            shift_x = 0;
        end
%     Cnew(i+shift_x,j) = Cnew(i+shift_x,j) + CnewX(i+shift_x,j);
%     Cnew(i+shift_x-1,j) = Cnew(i+shift_x-1,j) + CnewX(i+shift_x-1,j);
      if min(min(CnewX)) < 0
         g = 4;
      end
      Cnew = Cnew + CnewX;
      if j==24
          g = 3;
      end
      % this works becuase CnewX is all zeros except the two split values
      % and Cnew is only an accumulation of multiple CnewXs. aka, Cnew does
      % not contain old Colorfunction values
    end
end

    
% some reconstruction funtion  
[mx,my] = youngsFD(h,x,y,Cnew);
[Cr,xleft,xright,yleft,yright,alpha] = reconstruction_test(x,y,h,mx,my,Cnew);
Cnew = zeros(size(Cr));

for i=2:length(x)-1
    
    for j=2:length(y)-1
        
        if mx(i,j) == 0 && my(i,j) ==0 && Cr(i,j) == 0
         continue
        end
        if v(i,j) > 0
            [CnewY,shift_y] = advectionYpos(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif v(i,j) < 0
            [CnewY,shift_y] = advectionYneg(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);;
        elseif v(i,j)==0
            CnewY = zeros(size(Cr));
            shift_y = 0;
            CnewY(i,j) =Cr(i,j);
        end
        if i == 15 && j == 27
            d = 0;
        end
%     Cnew(i,j+shift_y) = Cnew(i,j+shift_y) + CnewX(i,j+shift_y);
%     Cnew(i,j+shift_y-1) = Cnew(i,j+shift_y-1) + CnewX(i,j+shift_y-1);
      Cnew = Cnew + CnewY;
       if max(max(Cnew)) > 1.01
            d = 0;
       end
    end
end

% some reconstruction funtion again
[mx,my] = youngsFD(h,x,y,Cnew);
[Cr,xleft,xright,yleft,yright,alpha] = reconstruction_test(x,y,h,mx,my,Cnew);

%final C is set as Cr

end




