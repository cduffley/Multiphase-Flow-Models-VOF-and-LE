clear 
clc
close all
% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------


% currently the algorthim fails if the circle falls exactly on the 
% line or corner (try Nx=Ny=11). also for uneven meshes.
Nx =33;
Ny = Nx;
x_pos = 0.5;
y_pos = 0.75;
r = 0.15;
x = linspace(0,1,Nx);
y = linspace(0,1,Ny);
h = y(3) - y(2);
[X,Y] = meshgrid(x,y);

%% circle stuff
cir_dis = 0:pi/100:2*pi; %decrease step size for more exact circle plot
xcir = 0.15 * cos(cir_dis) + 0.5;
ycir = 0.15 * sin(cir_dis) + 0.75;
plot(xcir,ycir)
hold on
for i = 1:Nx
    plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
    plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
end

[C,cir_xloc_x,cir_yloc_y,cir_xloc_y,cir_yloc_x] = ...
        circle_init(x,y,h,x_pos,y_pos,r);
[mx,my] = youngsFD(h,x,y,C);
%% for the reconstruct function

% test C values (page 96)
% C = [0,0,0;...
%    0,0,0;...
%    0,1,1]';

% C = [0,0.02,.1;...
%    0.2, 0.8,1;...
%    0.7, 1,1];

% % corresponding test x , y and h values
% x = linspace(0,3,3);
% y = x;
% h = x(2)-x(1);
% % Calculation of x and y components of normal vector
% % [mx,my] = youngsFD(h,x,y,C);
% 
% tol = 1e-5;
% max_it = 100000; 
% err = 1;
% num_it=0;
% alpha_guess=1;
% mx = mx(2,2);
% my=my(2,2);
% C = C(2,2);
% while abs(err) > tol && num_it <= max_it
% 
% Area = Alpha(mx,my,h,alpha_guess,C);
% 
% err1 = abs(Area - C*h^2);
% alpha_guess1 = alpha_guess;
% area1 = Area;
% alpha_guess = alpha_guess *1.01;
% if abs(err1) < tol
% alpha_guess = alpha_guess/1.0100000001; %lmao
% 
% end
% 
% Area = Alpha(mx,my,h,alpha_guess,C);
% 
% err2 = abs(Area - C*h^2);
% area2 = Area;
% alpha_guess2 = alpha_guess;
% 
% alpha_new = alpha_guess1 - err1/((err1-err2)/(alpha_guess1-alpha_guess2));
% alpha_guess = alpha_new;
% num_it = num_it+1;
% err = err1;
% alpha = alpha_new;
% 
% end
% areaC = C*h^2;
% 
% 
% Ax = mx/(2*my);
% alp = sqrt(2*mx*my*Area);
% 
% delx = alpha/mx;
% dely = alpha/my;
% % slope= -1/(delx/dely);
% slope = -1/(my/mx);
% 
% 
% mbold = (mx^2 + my^2)^(1/2);
% %slope = -1/(mx^2 + my^2)^(1/2);
% delx = alpha/mx;
% dely = alpha/my;
% % delx = mx;
% % dely = my;
% % dely = 0.5;
% 
% b = (dely)-(delx)*slope;  %from both x and y
% b = (delx+0.5)*slope + 0.5; %at (delx,0);
xgrid = linspace(0,3,4);
ygrid = xgrid;
figure
hold on
for i = 1:length(xgrid)
    plot(ones(1,length(xgrid))*xgrid(i),ygrid,'k','Linewidth',0.25)
    plot(xgrid,ones(1,length(ygrid))*ygrid(i),'k','Linewidth',0.25)
end
linex = linspace(xgrid(2), xgrid(3),10);
% liney = slope*linex + b;
% % plot(linex,liney)
% cch = ((0.802 - 0.5)/2 * (0.852-0.5))/(0.5^2);


%% current graph stuff
cir_xloc_x = [cir_xloc_x,cir_xloc_x];
cir_yloc_y = [cir_yloc_y,cir_yloc_y];
% plot(cir_xloc_x,cir_xloc_y,'o')
% plot(cir_yloc_x,cir_yloc_y,'o')


T = 2;
t = T/2; %this is for book example, deliverable 2 has t = T/pi
PHI = 1/pi .* cos(pi*t/T).*sin(pi.*X).^2 .* sin(pi.*Y).^2;

u = -2.*cos(pi.*t./T).*sin(pi.*X).^2 .* sin(pi.*Y).*cos(pi.*Y);
v = 2.*cos(pi.*t./T).*sin(pi.*Y).^2 .* sin(pi.*X).*cos(pi.*X);

% figure
% quiver(X,Y,u,v)
% C = (u.^2 + v.^2).^(1/2);


%% trying areafinder 

mx = -.2;
my = .1;
h=1;
slope = -1/(my/mx);
alplim1 = (h*-slope + h)*my;
alplim = (h*(-1/slope)+h)*mx;
alplimc = (0.5/mx - h) * -slope;
x = 1;
y = 1;
alpha = linspace(mx+0.001,my-0.001,1000);
for i=1:length(alpha)
[area(i),xleft(i),xright(i),yleft(i),yright(i)]...
    = areafinder(x,y,mx,my,h,alpha(i));
end
%for this example (havent done yet)
error = abs(0.5*h^2 - area);
[m,i] = min(error);
alpha = alpha(i);
dx = alpha/mx;
b = y - (x+alpha/mx)*slope;
liney = slope*linex+b;
% liney(liney<y+h) = y;
% liney(liney>y+h) = y+h;
plot(linex,liney)

%% Iterative solver for area finding method for whole mesh when ready for use
AlphaActual = zeros(length(x),length(y));
AreaActual = zeros(length(x),length(y));
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
        
        end % End of overall if statement

    end
end

