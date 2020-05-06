function [Cr,xleft,xright,yleft,yright,mx,my,alpha] =...
    advectionTot(x,y,h,mx,my,xleft,xright,yleft,yright,alpha,u,v,dt,Cr)

% This function runs the The out-of-cell explicit linear mapping advection,
% shown by section 5.4.1.2 pg(109-112) of Tryggvason et.
% al, Direct Numerical Simulations of Gas-Liquid Multiphase Flows

% The general outline is:
% Takes in inital colorfunction and m
% Performs advection in the x direction
% Reconstucts
% Performs advection in the y direction

% Since our velocities are already definied at the ends of the cells, we do
% not need to iterpolate to get u_{i+1/2} like the book does. There was an
% attempt to 'spill over' values into the next cell if the C was greater
% than 1, however, this seemingly made things worse. 

Cnew = zeros(size(Cr));

for i=2:length(x)-1
    
    for j=2:length(y)-1
        
        if mx(i,j) == 0 && my(i,j) ==0 && Cr(i,j) == 0
         continue
        end
        if u(i,j) > 0
            [CnewX,~] = advectionXpos(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif u(i,j) < 0
            [CnewX,~] = advectionXneg(x(i),y(j),h,i,j,...
                mx(i,j),my(i,j),xleft(i,j),xright(i,j),...
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif u(i,j)==0
            CnewX = zeros(size(Cr));
            CnewX(i,j) = Cr(i,j);
        end
        
      Cnew = Cnew + CnewX; %accumulating new color fucntion
    
    end
end

    
% reconstruction 
[mx,my] = youngsFD(h,x,y,Cnew);
[Cr,xleft,xright,yleft,yright,alpha] =...
        reconstruction_test(x,y,h,mx,my,Cnew);
    
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
                yleft(i,j),yright(i,j),alpha(i,j),u(i,j),v(i,j),dt,Cr);
        elseif v(i,j)==0
            CnewY = zeros(size(Cr));
            shift_y = 0;
            CnewY(i,j) =Cr(i,j);
        end
        if i == 15 && j == 27
            d = 0;
        end
        
      Cnew = Cnew + CnewY;

    end
end

% reconstruction funtion again
[mx,my] = youngsFD(h,x,y,Cnew);
[Cr,xleft,xright,yleft,yright,alpha] = reconstruction_test(x,y,h,mx,my,Cnew);

%final C is set as Cr

end




