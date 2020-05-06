function [xPos, yPos, uVel, vVel] = ParticleVelocity(n,t,dt,xPos,yPos,initVelx,initVely, Re, stokes)
    %{
      This function Updates particle velocity based on the method described
      in the Subramaniam LE review.  Most equations can be found on page
      232.
    %}

    %Particle Properties
    %stokes = 0.2;%input('Input Stokes $ (0.2 or 0.8)');
    tau_p = stokes;
    mu_f = 0.01;   %From project statement
    nu_f = mu_f;
    D_p = 0.001;   %From project statement
    rho_f = 1;     %From project statement
    L_ref = 1;
    U_ref = 1;
    Re = (L_ref*U_ref)/nu_f;      %Reynolds Number from project statement
    rho_p = (18*tau_p*mu_f)/(D_p^2);
    
    uVel = initVelx;
    vVel = initVely;
    
    %Drag Force Calculations
    %Initialize Carrier Fluid Velocity
    [uVelC,vVelC] = CarrierVelocity(xPos,yPos);
    %Calculate particle Reynolds number (Subramaniam Eqn 52)
    Re_px = (2*rho_f.*abs(uVelC - uVel)*D_p)./mu_f;
    Re_py = (2*rho_f.*abs(vVelC - vVel)*D_p)./mu_f;
    Re_p = sqrt(Re_px.^2 + Re_py.^2);
    
    %Calculate Drag Coefficient based on particle Reynolds number (Subramaniam Eqn 51)
    if Re_p <= 1000
        C_D = (24./Re_p).*(1+(Re_p.^(2/3))/6);
    elseif Re_p > 1000
        C_D = 0.424;
    else
        fprintf('*******************************\n')
        fprintf('Particle Reynolds Number is NaN\n')
        disp(Re_p)
        fprintf('*******************************\n')
    end
    
    %Calculate Acceleration (dv/dt) (Subramaniam Eqn 50)
    dudt = @(uVelC,uVel) ((3/8).*(rho_f./rho_p).*((uVelC - uVel)./(D_p./2))).*C_D.*(uVelC - uVel);
    dvdt = @(vVelC,vVel) ((3/8).*(rho_f./rho_p).*((vVelC - vVel)./(D_p./2))).*C_D.*(vVelC - vVel);
    
     xPos = xPos + dudt(uVelC,uVel).*dt.*dt;
     yPos = yPos + dvdt(vVelC,vVel).*dt.*dt;
end