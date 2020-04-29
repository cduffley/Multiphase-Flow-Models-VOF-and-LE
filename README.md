# CFDproj3

% file path
% 
%% main
%%     circle_init
%         CFDsemiTrapzoid
%         CFDtri1
%         CFDtri2
%     returns inital circle color function
      
%      youngsFD
%%     reconstruct
%         areafinder
%     returns inital reconstruction of color fucntion
     
%%     For number of time steps:
%%     advectionTot
%         advectionXpos or advectionXneg
%         returns new color function based on X movement
%         
%         youngsFD
%         reconstruct
%             areafinder
%         returns reconstruction based on X movement
%         
%         advectionXpos or advectionXneg
%         returns new color function based on Y movement (uses X's new ClrFun)
%
%         youngsFD        
%         reconstruct
%             areafinder
%         returns reconstruction based on Y movement (uses X's new ClrFun)
%     returns new CF and reconstuction at new time t
 
%     graphs
