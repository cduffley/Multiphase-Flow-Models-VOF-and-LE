function [xPos, yPos, uVel, vVel] = ParticleVelocity(n,t,dt,xPos,yPos,initVelx,initVely, Re, stokes,Nx,Ny)
    %{
      This function Updates particle velocity based on the method described
      in the Subramaniam LE review.  Most equations can be found on page
      232.
    %}

    %Particle Properties developed from project statement and definitions
    tau_p = stokes;
    D_p = 0.001;   %From project statement
    rho_f = 1;     %From project statement
    
    %Setting of initial velocity vector
    uVel = initVelx;
    vVel = initVely;
    
    %Discretization of Carrier Fluid Velocity 
    x = linspace(0,1,Nx);
    y = linspace(0,1,Ny);
    [X,Y] = meshgrid(x,y);
    
    %Initialization of carrier fluid velocity profile for interpolation
    u_vel_profile = 2*(sin(pi*X).^2).*(sin(pi*Y).*cos(pi*Y));
    v_vel_profile = -2*(sin(pi*X).*cos(pi*X)).*(sin(pi*Y).^2);
    
    %Interpolation of carrier fluid velocities that were solved at mesh
    %points
    uVelC = interp2(X,Y,u_vel_profile,xPos,yPos);
    vVelC = interp2(X,Y,v_vel_profile,xPos,yPos);
    
    
    %Using carrier velocity to calc magnitude for carrier Reynolds number
    VelCMag = (uVelC.^2 + vVelC.^2).^(1/2); 
    
    %Using carrier Reynolds Number to calculate fluid viscosities
    nu_f = VelCMag.^2/Re; 
    
    %Determining dynamic viscosity by rho_f=1
    mu_f = nu_f;
    
    %Calculating particle density from tau_p and mu_f
    rho_p = (18*tau_p*mu_f)/(D_p^2);
    
    %Determines relative velocity between carrier and particle velocity
    u_rel = uVelC - uVel; 
    v_rel = vVelC - vVel; 
    %Determines the magnitude of the relative velocity vector 
    rel_vel_mag = (u_rel.^2 + v_rel.^2).^(1/2);
    
    %Calculate particle Reynolds number (Subramaniam Eqn 52)
    Re_p = (rho_f.*rel_vel_mag*D_p)./mu_f;
    %disp(Re_px)
    %disp('********************')
    %disp(Re_py)
    %disp('********************')
    
    %Calculate Drag Coefficient based on particle Reynolds number (Subramaniam Eqn 51)
    %Calculate over whole Reynolds Number vector
    C_D = linspace(0,0,length(Re_p)); 
    for i=1:length(Re_p)
        if Re_p(i) < 1000
            C_D(i) = (24./Re_p(i)).*(1+(Re_p(i).^(2/3))/6);
        elseif Re_p(i) >= 1000
            C_D(i) = 0.424;
        else
            fprintf('*******************************\n')
            fprintf('Particle Reynolds Number is NaN\n')
            disp(Re_p)
            fprintf('*******************************\n')
        end
    end             %End of for-loop
    %Find instantaneous particle response frequency (Subramaniam Eqn 53)
    %omegaStarX = (3/8)*(rho_f/rho_d)*(relVelx/R_p)*C_D;
    %omegaStarY = (3/8)*(rho_f/rho_d)*(relVely/R_p)*C_D;
    %Calculate Acceleration (dv/dt) (Subramaniam Eqn 50)
    %gVec = zeros(n);  %Gravity in the z direction
    %disp('CD')
    %disp(C_D)
    %disp('CD')
    dudt = @(rel_vel_mag,u_rel) ((3/8).*(rho_f./rho_p).*((rel_vel_mag)./(D_p./2))).*C_D.*(u_rel);%+gVec;
    dvdt = @(rel_vel_mag,v_rel) ((3/8).*(rho_f./rho_p).*((rel_vel_mag)./(D_p./2))).*C_D.*(v_rel);%+gVec;
%     fprintf('du/dt:  %6.3f\n', dudt(uVelC,uVel))
%     fprintf('dv/dt:  %6.3f\n', dvdt(vVelC,vVel))
    
    %disp('************************************************')
    %disp(xPos)
    %disp(yPos)
    %disp(uVel)
    %disp(vVel)
%     disp(uVelC)
%     disp(vVelC)
%     disp('      -------------------------------')
     xPos = xPos + dudt(rel_vel_mag,u_rel).*dt.*dt;
     yPos = yPos + dvdt(rel_vel_mag,v_rel).*dt.*dt;
     
%      for i=1:length(xPos)
%          if xPos(i) > 1
%              xPos(i) = 1;
%          elseif xPos(i) < 0
%              xPos(i) = 0;
%          end
%          
%          if yPos(i) > 1
%              yPos(i) = 1;
%          elseif yPos(i) < 0
%              yPos(i) = 0;
%          end
%          
%      end
     
%     disp(xPos)
%     disp(yPos)
%     %disp(uVel)
%     %disp(vVel)
%     disp(uVelC)
%     disp(vVelC)
end