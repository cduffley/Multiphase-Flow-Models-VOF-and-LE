function alpha = Alpha(mx,my,C) 
    %Determine f2x for area calc
    if (alpha-mx*delX) > 0
        f2x = (alpha-mx*delX)^2;
    else
        f2x = 0;
    end
    
    %Determine f2y for area calc
    if (alpha-my*delY) > 0
        f2y = (alpha-mx*delY)^2;
    else
        f2y = 0;
    end
    
    %Find Area of ABFGD
    %Tryggvason Eq 5.22
    A = (1/(2*mx*my))*((alpha^2)-f2x-f2y);
    
    %Calculate alpha using root finding
    g = @(a) A-delX*delY*C;
    alpha = fzero(g,0.5);
end
