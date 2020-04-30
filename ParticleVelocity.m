function [particleVel] = ParticleVelocity()
    %{
      This function Updates particle velocity based on the method described
      in the Subramaniam LE review.  Most equations can be found on page
      232.
    %}

    %Drag
    %Calculate particle Reynolds number (Subramaniam Eqn 52)
    relVel = initialParticleVel - carrierVel;
    Re_p = (2*rho_f*abs(relVel)*R_p)/mu_f;
    %Calculate Drag Coefficient based on particle Reynolds number (Subramaniam Eqn 51)
    if Re_p <= 1000
        C_D = (24/Re_p).*(1+(Re_p.^(2/3))./6);
    elseif Re_p > 1000
        C_D = 0.424;
    else
        fprintf('*******************************')
        fprintf('Particle Reynolds Number is NaN')
        fprintf('*******************************')
    end
    %Find instantaneous particle response frequency (Subramaniam Eqn 53)
    omegaStar = (3/8)*(rho_f/rho_d)*(relVel/R_p)*C_D;
    %Calculate Acceleration (dv/dt) (Subramaniam Eqn 50)
    dvdt = @(relVel) omegaStar*relVel+gVec;
    %Initial Condition
    velInit = 0;
    particleVel = ode45(dvdt,[0,t],velInit);
end