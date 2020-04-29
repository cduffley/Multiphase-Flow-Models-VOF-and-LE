function [Cr,xleft,xright,yleft,yright] = reconstruct(x,y,C)
%Cr - C reconstructed (actual Colorfuntion area based on new lines,
% should this be the case, or should we use original Colorfuction when 
% advecting in the next step? If we use original, it could lead to some
% errors, possibly negative areas. If we use new, the actual mass
% essentially disappears. Assume difference is negligable and use new,
% since there will hopefully be less errors

%% Iterative solver for area finding method for whole mesh when ready for use
AlphaActual = zeros(length(x),length(y));
AreaActual = zeros(length(x),length(y));
xright = zeros(length(x),length(y));
xleft = zeros(length(x),length(y));
yright = zeros(length(x),length(y));
yleft = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        
        % Listing necessary parameters for area finding method
        xval = X(i,j);      yval = Y(i,j);
        mxval = mx(i,j);    myval = my(i,j);
        if  mxval == 0 && myval == 0 && C(i,j) == 0
            % Check if mx and my are both 0 for C of 0 (not filled), 
            % which yields area of 0
            AlphaActual(i,j) = 0;
            AreaActual(i,j) = 0;
            break
        elseif  mxval == 0 && myval == 0 && C(i,j) == 1
            % Check if mx and my are both 0 for C of 1 (filled), 
            % which yields area of 1
            AlphaActual(i,j) = 1;
            AreaActual(i,j) = 1;
            break
        else
        % Parameters to perform iterative method, including first iteration
        % and tolerance of error for root finding
        tol = 1e-8; 
        err = 1e10;   Count = 1;   MaxCount = 25; 
        
        % Ensuring that intial guess for alpha is within constraints of geometric cell
        if mxval > 0 && myval > 0
            % mx and my are positive
            alpha(Count) = (-h/slope(i,j)+h)*mxval*0.1;
        end
        
        if mxval < 0 && myval < 0
            % mx and my are negative
            alpha(Count) = (-h/slope(i,j)+h)*mxval*1.1;
        end
        
        if mxval < 0 && myval > 0
            % mx is negative and my is positive
            % hmx < alpha < hmy
            alpha(Count) = h*myval*0.1;
        end
        
        if mxval > 0 && myval < 0
            % hmy < alpha < hmx
            % mx is positive and my is negative
            alpha(Count) = h*mxval*0.1;
        end
        
        % While loop to perform iteration calculation
        while abs(err(Count)) > tol  &&  Count <= MaxCount
            
            % Calculation of area using areafinder function
            Area(Count) = areafinder(xval,yval,mxval,myval,h,alpha(Count));
            
            % Evaluate error in area by comparing result to color function C
            e1 =  Area(Count) - C(i,j);  
            err(Count) = e1;
            % Use perturbation for alpha if error is too large
            if abs(e1) > tol
                alphapert = 1.0001*alpha(Count);
                Areapert = areafinder(xval,yval,mxval,myval,h,alphapert);
                e2 =  Areapert - C(i,j);
                % Calculate a new alpha guess based on error analysis
                alphanew = alpha(Count)-e1*(0.0001*alpha(Count))/(e2-e1);
                Count = Count+1;   
                alpha(Count) = alphanew;
                err(Count) = err(Count-1);
            end   % End of iteration loop for perturbation
            if Count >= MaxCount
                fprintf(1,'Iteration Failed -- Hit maximum iteration limit \n');
            end   % End of overall iteration process
        end % End of while loop
        AlphaActual(i,j) = alpha(end);
        AreaActual(i,j) = Area(end);
        % want to pull out xright,xleft,yright,yleft for (i,j) as well
        xright(i,j) = ?
        xleft(i,j) = ?
        yright(i,j) = ?
        yleft(i,j) = ?
        end % End of overall if statement

    end
end
% should include?? or is area already fraction
Cr = AreaActual/h^2; 


end
