function [Cr,xleft,xright,yleft,yright,alpha_actual] = reconstruction_test(x,y,h,mx,my,C)
%Cr - C reconstructed (actual Colorfuntion area based on new lines,
% should this be the case, or should we use original Colorfuction when 
% advecting in the next step? If we use original, it could lead to some
% errors, possibly negative areas. If we use new, the actual mass
% essentially disappears. Assume difference is negligable and use new,
% since there will hopefully be less errors
%% Iterative solver for area finding method for whole mesh when ready for use
alpha_actual = zeros(length(x),length(y));
area_actual = zeros(length(x),length(y));
xright = zeros(length(x),length(y));
xleft = zeros(length(x),length(y));
yright = zeros(length(x),length(y));
yleft = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        % Listing necessary parameters for area finding method
        xval = x(i);    yval = y(j);
        mxval = mx(i,j);    myval = my(i,j);

        %testing specific values
        if C(i,j) > 1.2
            adfs = 1;
        end
        
        if  mxval == 0 && myval == 0 && C(i,j) == 0
            % Check if mx and my are both 0 for C of 0 (not filled), 
            % which yields area of 0
            alpha_actual(i,j) = 0;
            area_actual(i,j) = 0;
            xright(i,j) = xval;
            xleft(i,j) = xval;
            yright(i,j) = yval;
            yleft(i,j) = yval;
            continue
        elseif  mxval == 0 && myval == 0 && C(i,j) == 1
            % Check if mx and my are both 0 for C of 1 (filled), 
            % which yields area of 1
            alpha_actual(i,j) = 0; %changed from 1 to 0
            area_actual(i,j) = 1*h^2;
            xright(i,j) = xval;
            xleft(i,j) = xval;
            yright(i,j) = yval;
            yleft(i,j) = yval;
            continue
        elseif C(i,j) == 0
            alpha_actual(i,j) = 0;
             area_actual(i,j) = 0;
            xright(i,j) = xval;
            xleft(i,j) = xval;
            yright(i,j) = yval;
            yleft(i,j) = yval;
            continue
        elseif C(i,j) >= 0.99990
            alpha_actual(i,j) = 0;
             area_actual(i,j) = C(i,j)*h^2;
            xright(i,j) = xval;
            xleft(i,j) = xval;
            yright(i,j) = yval;
            yleft(i,j) = yval;
            continue
        else
        % Perform for loop with many alpha values and choosing the value
        % for alpha that produces the least error
        slope = -1/(myval/mxval);
        % Producing alpha vector that is within constraints of geometric cell
        %added >=
        if mxval >= 0 && myval >= 0
            % mx and my are positive
            lowlim = 0; 
            highlim = (-h/slope+h)*mxval; 
        end
        
        if mxval <= 0 && myval <= 0
            % mx and my are negative
            lowlim = (-h/slope+h)*mxval; 
            highlim = 0; 
        end
        
        if mxval <= 0 && myval >= 0
            % mx is negative and my is positive
            % hmx < alpha < hmy
            lowlim = h*mxval;
            highlim = h*myval;
        end
        
        if mxval >= 0 && myval <= 0
            % hmy < alpha < hmx
            % mx is positive and my is negative
           lowlim = h*myval;
           highlim = h*mxval;
        end
        
        alpha_calc = linspace(lowlim, highlim, 1000);
        % While loop to perform iteration calculation
        for k = 1:length(alpha_calc)
            % Calculation of area using areafinder function
            Area(k) = ...
                areafinder(xval,yval,mxval,myval,h,alpha_calc(k));
            % Evaluate error in area by comparing result to color function C
            error(k) =  Area(k) - C(i,j)*h^2;  
        end
            [M,I] = min(abs(error)); 

            alpha_actual(i,j) = alpha_calc(I);
        % want to pull out xright,xleft,yright,yleft for (i,j) as well
        [area,xl,xr,yl,yr] = ...
            areafinder(xval,yval,mxval,myval,h,alpha_actual(i,j));
        xright(i,j) = xr;
        xleft(i,j) = xl;
        yright(i,j) = yr;
        yleft(i,j) = yl;
        area_actual(i,j) = area;
        if (abs(area - C(i,j)*h^2))/(C(i,j)*h^2) > 0.05 %5 percent error
        area_actual(i,j) = C(i,j) *h^2;
        alpha_actual(i,j) = 0; %might mess with us, since alpha can =1,... 
        %...originally meant for values of 1, not ones really close to 0
        end
        end % End of overall if statement

    end
end
Cr = area_actual/h^2; 


end
