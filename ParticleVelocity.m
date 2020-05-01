function [xPos, yPos] = ParticleVelocity(n,t,dt,xPos,yPos,initVelx,initVely)
    %{
      This function Updates particle velocity based on the method described
      in the Subramaniam LE review.  Most equations can be found on page
      232.
    %}

    %Particle Properties
    stokes = 0.2;%input('Input Stokes $ (0.2 or 0.8)');
    tau_p = stokes;
    mu_f = 0.01;   %From project statement
    nu_f = mu_f;
    D_p = 0.001;   %From project statement
    rho_f = 1;     %From project statement
    L_ref = 1;
    U_ref = 1;
    Re = (L_ref*U_ref)/nu_f;      %Reynolds Number from project statement
    rho_p = (18*tau_p*mu_f)/(D_p^2);
    
    %Drag
    %Calculate particle Reynolds number (Subramaniam Eqn 52)
    %relVelx = velX - uVel;
    %relVely = velY - vVel;
    velX = initVelx;
    velY = initVely;
    %Initialize Carrier Fluid Velocity
    [uVel,vVel] = CarrierVelocity(xPos,yPos);
    Re_px = (2*rho_f*abs(velX - uVel)*D_p)./mu_f;
    Re_py = (2*rho_f*abs(velY - vVel)*D_p)./mu_f;
    Re_p = sqrt(Re_px.^2 + Re_py.^2);
    %Calculate Drag Coefficient based on particle Reynolds number (Subramaniam Eqn 51)
    if Re_p <= 1000
        C_D = (24./Re_p).*(1+(Re_p.^(2/3))/6);
    elseif Re_p > 1000
        C_D = 0.424;
    else
        fprintf('*******************************')
        fprintf('Particle Reynolds Number is NaN')
        fprintf('*******************************')
    end
    %Find instantaneous particle response frequency (Subramaniam Eqn 53)
    %omegaStarX = (3/8)*(rho_f/rho_d)*(relVelx/R_p)*C_D;
    %omegaStarY = (3/8)*(rho_f/rho_d)*(relVely/R_p)*C_D;
    %Calculate Acceleration (dv/dt) (Subramaniam Eqn 50)
    %gVec = zeros(n);  %Gravity in the z direction
%     disp(velX)
%     disp(velY)
%     disp('===========================================================================================')
    dudt = @(velX,uVel) ((3/8).*(rho_f./rho_p).*((velX - uVel)./(D_p./2))).*C_D.*(velX - uVel);%+gVec;
    dvdt = @(velY,vVel) ((3/8).*(rho_f./rho_p).*((velY - vVel)./(D_p./2))).*C_D.*(velY - vVel);%+gVec;
    
    %for i = 1:length(initVelx)
        %Update Parcel Positions
%     disp(velX)
%     disp(velY)
%     disp(dt)
%     disp(xPos)
%     disp(yPos)
    xPos = xPos + dudt(velX,uVel).*dt.*dt;
    yPos = yPos + dvdt(velY,vVel).*dt.*dt;
        %Update Carrier Fluid Velocity
    [uVel,vVel] = CarrierVelocity(xPos,yPos);
    %end
end