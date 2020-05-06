# Computational Fluid Dynamics Project 3: Implementation of Multiphase Flow Models into a Flow Solver
Team members: 
1. Collin Duffley
2. Joel Strandburg
3. Danny Ouk

These files contain the 2D implementation of the following two multiphase flow models: 
* Volume of Fluid (VOF) interface capturing scheme
* Point-particle Lagrangian-Eulerian method

Both models were implemented in MATLAB. These models considered only the 1-way coupling from the effects of the background flow to the main fluid. 
### Volume of Fluid (VOF) interface capturing scheme
Development of VOF was based on the PLIC method for interface reconstruction using the Youngs' Finite Difference to determine the interface normal vector. Alpha, relating the size of the cell occupied by the fluid, was determined using an iterative solver. Interface advection was performed using the out-of-cell explicit linear mapping method. This method was tested through the Vortex-in-a-box interface tracking test using a stream function defined in a unit-square box.
### Point-particle Lagrangian-Eulerian method
The standard drag model mentioned by Subramaniam was used for the Lagrangian particles. This method was tested using through a Lagrangian particle tracking test utilizing a steady version of the same stream function defined in a unit-square box. 

# Getting Started
Users should already have MATLAB installed onto their computer. This code base should be installed from GitHub and be brought into the user's preferred folder to be accessed by MATLAB.
## Suggested parameters for running Volume of Fluid method interface tracking 
The iterative alpha solver wtitten had problems due to the alpha limits, and was replaced with a slower method. That, and other slow portions of the code (written to be 'safe') slow the run time down significantly

The input asks for 7 parameters, the suggested values are discussed below for more optimal running:

1\) The grid selections this code has been tested for is 33 and 333, and currently is not designed for uneven grids (although, with a minor adjustments could become viable for it). If you are running 333, be prepared for the code to take at least 25 min depending on the time parameters chosen. The 33 should only take a few min

2,3,4) The suggested circle parameters are from the problem statement. The box is 1x1, so the circle should fit inside this. Also, circles that will eventually interact with the wall will not provide proper results, since we do not account for interactions with the wall

5,6) Based on the final time, the number of time steps should be chosen to not create large velocities that 'push' the circle out of the box in one step. If you see an error at Cnew = Cnew + CnewX, this means the number of time steps is too small. For N = 33^2, The minimum suggested time step for the time going to t=1 is around 20, and double the number to around 40 for t=2. Higher number of time steps is suggested for N=33^2, since it can be afforded. For N = 333^2, 10 and 20 are suggested number of time steps for t=1 and t=2, respectively. There are values lower in which it will run with okay results. These suggested parameters should keep alow enough CFL number. There are maximum CFL values in the workspace of the mainIT function. 

7\) Grid lines are nice for N=33^2, but horrible for larger ones (333)

# Interface Tracking Notation
The interface tracking functions use the notations below to label the geometry and line types:
The geometries are definied based on the origin, which is the bottom left corner of the cell. Alpha/mx and alpha/my are definied as distances away from the origin in the x and y direction, respectively. 
The signs of the normal vector (mx,my) define the interface.
  #### 1 is m(+,+), which has a negative slope and an inside area (towards the origin)
  #### 2 is m(-,+), which has a positive slope and an outide area (away from the origin)
  #### 3 is m(-,-), which has a negative slope and an outide area (away from the origin)
  #### 4 is m(+,-), which has a positive slope and an inside area (towards the origin)

The Extras folder has rough drawings of these types of areas.

The line intersections are defined such that:

                      Side 2
         ----------------------------------
        |                                  |
        |                                  |
        | Side 1                           | Side 3
        |                                  |
        |                                  |
        |                                  |
        -----------------------------------
                      Side 4
Where a line through sides 1 and 3 is labed as (1,3)

# Main Contents
1. **main.m - Main MATLAB file for choosing which multiphase model to run.**
2. **mainIT.m - Main MATLAB file for running the volume of fluid interface capturing scheme.**
3. **mainLE.m - Main MATLAB file for running the point-particle Lagrangian-Eulerian method.**
4. advectionTot.m - (VOF) Function that performs process interface advection - Calls all other advection files and outputs a new color function
5. advectionXneg.m - (VOF) Advection function - Used for advecting color function in the negative x-direction 
6. advectionXpos.m - (VOF) Advection function - Used for advecting color function in the positive x-direction 
7. advectionYneg.m - (VOF) Advection function - Used for advecting color function in the negative y-direction 
8. advectionYpos.m - (VOF) Advection function - Used for advecting color function in the positive y-direction 
9. areafinder.m - (VOF) Function that calculates the area occupied by the main fluid given the normal vector and alpha. Determines the geometry of the cell occupied by the fluid. 
10. CarrierVelocity.m - (LE) Function that determines the carrier fluid velocity at parcel locations.
11. CFDsemiTrapzoid.m - (VOF) Function that determines the area of a trapezoid-like shape. Used to initialize the initial color function for the vortex-in-a-box test. 
12. CFDtri1.m - (VOF) Function that determines the areas of triangle and polygonalshape. Used to initialize the initial color function for the vortex-in-a-box test. 
13. CFDtri2.m - (VOF) Function that determines the areas of triangle and polygonalshape. Used to initialize the initial color function for the vortex-in-a-box test. Intended to be more rigorous. 
14. circle_init.m - (VOF) Function that initializes the initial color function for the vortex-in-a-box test. 
15. InitPosition.m - (LE) Function used during initialization of particles in LE. Determines the coordinates for each particle.
16. ParticleVelocity - (LE) Function that updates particle velocity based on the method described in the Subramaniam's Lagrangian-Eulerian review.
17. reconstruction_test.m - (VOF) Function that reconstructs the interface using the normal vector and the initial color function to calculate alpha and determine the cell geometry type. Uses areafinder to calculate the area and match the initial color function. 
18. youngsFD.m - (VOF) Function that calculates the normal vector of the interface given the color function of nearby cells. 

# File Pathway
## Volume of Fluid Method
* mainIT
* circle_init
    * CFDsemiTrapzoid
    * CFDtri1
    * CFDtri2
* returns inital circle color function
    
* youngsFD
* reconstruct
   * areafinder 
* returns inital reconstruction of color fucntion
     
* For number of time steps:
  * advectionTot
    * advectionXpos or advectionXneg - 
    * Returns new color function based on X movement
    * youngsFD
    * reconstruct 
        * areafinder
    * returns reconstruction based on X movement
  
    * advectionYpos or advectionYneg
    * returns new color function based on Y movement
    * youngsFD
    * reconstruct 
        * areafinder
    * Returns reconstruction based on Y movement
  * returns new color function from advection at current time step
  * reconstuct interface and continue to next time step
  * repeat advection until completed

## Lagrangian Eulerian Method
* mainLE
  * InitPosition - call initial positions for particles
  * ParticleVelocity
     * CarrierVelocity
