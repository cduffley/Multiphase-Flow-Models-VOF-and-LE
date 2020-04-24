clear 
clc

% -------------------------------------------------------------------------
% Interface tracking test
% -------------------------------------------------------------------------


% currently the algorthim fails if the circle falls exactly on the 
% line or corner (try Nx=Ny=11). also for uneven meshes.
Nx =333;
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
C = [0,0.02,.1;...
   0.2, 0.8,1;...
   0.7, 1,1];

% C = [.1,0.02,0;...
%    1, 0.8,0.2;...
%    1, 1,0.7];

% corresponding test x , y and h values
x = linspace(0,1,3);
y = x;
h = x(2)-x(1);
% Calculation of x and y components of normal vector
[mx,my] = youngsFD(h,x,y,C);

tol = 1e-5;
max_it = 100000; 
err = 1;
num_it=0;
alpha_guess=1;
mx = mx(2,2);
my=my(2,2);
C = C(2,2);
while abs(err) > tol && num_it <= max_it

Area = Alpha(mx,my,h,alpha_guess,C);

err1 = abs(Area - C*h^2);
alpha_guess1 = alpha_guess;
area1 = Area;
alpha_guess = alpha_guess *1.01;
if abs(err1) < tol
alpha_guess = alpha_guess/1.0100000001; %lmao

end

Area = Alpha(mx,my,h,alpha_guess,C);

err2 = abs(Area - C*h^2);
area2 = Area;
alpha_guess2 = alpha_guess;

alpha_new = alpha_guess1 - err1/((err1-err2)/(alpha_guess1-alpha_guess2));
alpha_guess = alpha_new;
num_it = num_it+1;
err = err1;
alpha = alpha_new;

end
areaC = C*h^2;
figure
hold on
for i = 1:length(x)
    plot(ones(1,length(x))*x(i),y,'k','Linewidth',0.25)
    plot(x,ones(1,length(y))*y(i),'k','Linewidth',0.25)
end


Ax = mx/(2*my);
alp = sqrt(2*mx*my*Area);

delx = alpha/mx;
dely = alpha/my;
% slope= -1/(delx/dely);
slope = -1/(my/mx);


mbold = (mx^2 + my^2)^(1/2);
%slope = -1/(mx^2 + my^2)^(1/2);
delx = alpha/mx;
dely = alpha/my;
% delx = mx;
% dely = my;
% dely = 0.5;

b = (dely)-(delx)*slope;  %from both x and y
b = (delx+0.5)*slope + 0.5; %at (delx,0);

linex = linspace(x(2), x(3),10);
liney = slope*linex + b;
plot(linex,liney)
cch = ((0.802 - 0.5)/2 * (0.852-0.5))/(0.5^2);

for i = 1:length(x)
    for j = 1:length(y)
        
        % Listing necessary parameters for area finding method
        xval = X(i,j);      yval = Y(i,j);
        mxval = mx(i,j);    myval = my(i,j);
        
        % Parameters to perform iterative method, including first iteration
        % and tolerance of error for root finding
        tol = 1e-8; 
        err = 1e10;   Count = 1;   MaxCount = 25; alpha(Count) = 1; 
        
        % While loop to perform iteration calculation
        while abs(err(Count)) > tol  &&  Count <= MaxCount
            
            % Calculation of area using areafinder function
            Area(Count) = areafinder(xval,yval,mxval,myval,alpha(Count));
            
            % Evaluate error in area by comparing result to color function C
            e1 =  Area(Count) - h^2*C(i,j);  
            err(Count) = e1;
            % Use perturbation for alpha if error is too large
            if abs(e1) > tol
                alphapert = 1.0001*alpha(Count);
                Areapert = areafinder(xval,yval,mxval,myval,alphapert);
                e2 =  Areapert - h^2*C(i,j);
                alphanew = alpha(Count)-e1*(0.0001*alpha(Count))/(e2-e1);
                Count = Count+1;   
                alpha(Count) = alphanew;
                err(Count) = err(Count-1);
            end   % End of iteration loop for perturbation
            if Count >= MaxCount
                fprintf(1,'Iteration Failed -- Hit maximum iteration limit \n');
            end   % End of overall iteration process
        end
        AlphaActual(i,j) = alpha(end)
        AreaActual(i,j) = Area(end)
    end
end

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




