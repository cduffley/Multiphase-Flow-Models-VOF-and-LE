%-------------------------------------------------------------------------
% Computational Fluid Dynamics Project 3: Implementation of Multiphase Flow
% Models into a Flow Solver. Collin Duffley, Joel Strandburg and Danny Ouk
%
% This main file provides an interface to select between the VOF interface
% tracking and the Lagrangian-Eulerian particle tracking codess
%-------------------------------------------------------------------------

% READ BEFORE RUNNING VOF IT
% ***Suggested parameters for running the interface tracking:***
% 
% The iterative alpha solver wtitten had problems due to the alpha limits,
% and was replaced with a slower method. That, and other slow portions of
% the code (written to be 'safe') slow the run time down significantly
%
% 1) The grid selections this code has been tested for is 33 and 333, and
% currently is not designed for uneven grids (although, with a minor
% adjustments could become viable of it) If you are running 333, be
% prepared for the code to take at least 25 min depending on the time
% parameters chosen. The 33 should only take a few min
%
% 2,3,4) The suggested circle parameters are from the problem statement. The
% box is 1x1, so the circle should fit inside this. Also, circles that will
% eventually interact with the wall will not provide proper results, since
% we do not account for interactions with the wall
%
% 5,6) Based on the final time, the number of time steps should be chosen
% to not create large velocities that 'push' the circle out of the box in 
% one step. If you see an error at Cnew = Cnew + CnewX, this means the
% number of time steps is too small. The minimum suggested time step for
% the time going to t=1 is around 20, and double the number to 40 for t=2.
% Higher number of time steps is suggested for N=33^2, since it can be
% afforded. For 333, 10 and 20 are suggested. There are values lower in
% which it will run with okay results. These parameters should keep a
% low enough CFL number. There are maximum CFL values in the workspace of
% the mainIT function. The book discusses the r/h value being greater than
% 4 as well.
%
% 7) Grid lines are nice for N=33^2, but horrible for larger ones (333)




list = {'Interface Tracking', 'Lagrangian-Eulerian Particle Tracking'};
[mode,tf] = listdlg('PromptString',{'Select run mode',''}, 'SelectionMode',...
    'single','ListString',list);

switch mode
    case 1
        mainIT()
    case 2
        mainLE()
end
