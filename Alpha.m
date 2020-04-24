function A = Alpha(mx,my,h,alpha_guess,C) 
    %Determine f2x for area calc
delX = h;
delY = h;
    if (alpha_guess-mx*delX) > 0
        f2x = (alpha_guess-mx*delX)^2;
    else
        f2x = 0;
    end
    
    %Determine f2y for area calc
    if (alpha_guess-my*delY) > 0
        f2y = (alpha_guess-mx*delY)^2;
    else
        f2y = 0;
    end
    
    %Find Area of ABFGD
    %Tryggvason Eq 5.22
    A = (1/(2*mx*my))*((alpha_guess^2)-f2x-f2y);
    
    %Calculate alpha using root finding
%     g = @(a) A-delX*delY*C;
%     alpha = fzero(g,0.5);


end
