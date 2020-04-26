function [mx,my] = youngsFD(h,x,y,C)

mxsum = zeros(length(x));
mysum = zeros(length(y));
magnitude = zeros(length(y));

for i = 1:length(x)
    for j = 1:length(y)
        if i==1 && j==1
            % Top left corner of boundaries
            mx1 = -1/(2*h) .*( 0 + C(i,j+1) - 0 - C(i,j) );
            my1 = -1/(2*h) .*( 0 - C(i,j+1) + 0 - C(i,j) );
            mx2 = -1/(2*h) .*( 0 + C(i,j) - 0 - 0 );
            my2 = -1/(2*h) .*( 0 - C(i,j) + 0 - 0 );
            mx3 = -1/(2*h) .*( C(i,j+1) + C(i+1,j+1) - C(i,j) - C(i+1,j) );
            my3 = -1/(2*h) .*( C(i,j+1) - C(i+1,j+1) + C(i,j) - C(i+1,j) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i+1,j) - 0 - 0 );
            my4 = -1/(2*h) .*( C(i,j) - C(i+1,j) + 0 - 0 );
        elseif i==1 && j==length(y)
            % Top right corner of boundaries
            mx1 = -1/(2*h) .*( 0 + 0 - 0 - C(i,j) );
            my1 = -1/(2*h) .*( 0 - 0 + 0 - C(i,j) );
            mx2 = -1/(2*h) .*( 0 + C(i,j) - 0 - C(i,j-1) );
            my2 = -1/(2*h) .*( 0 - C(i,j) + 0 - C(i,j-1) );
            mx3 = -1/(2*h) .*( 0 + 0 - C(i,j) - C(i+1,j) );
            my3 = -1/(2*h) .*( 0 - 0 + C(i,j) - C(i+1,j) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i+1,j) - C(i,j-1) - C(i+1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i+1,j) + C(i,j-1) - C(i+1,j-1) );
        elseif i==length(x) && j==1
            % Bottom left corner of boundaries
            mx1 = -1/(2*h) .*( C(i-1,j+1) + C(i,j+1) - C(i-1,j) - C(i,j) );
            my1 = -1/(2*h) .*( C(i-1,j+1) - C(i,j+1) + C(i-1,j) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i-1,j) + C(i,j) - 0 - 0 );
            my2 = -1/(2*h) .*( C(i-1,j) - C(i,j) + 0 - 0 );
            mx3 = -1/(2*h) .*( C(i,j+1) + 0 - C(i,j) - 0 );
            my3 = -1/(2*h) .*( C(i,j+1) - 0 + C(i,j) - 0 );
            mx4 = -1/(2*h) .*( C(i,j) + 0 - 0 - 0 );
            my4 = -1/(2*h) .*( C(i,j) - 0 + 0 - 0 );
        elseif i==length(x) && j==length(y)
            % Bottom right corner of boundaries
            mx1 = -1/(2*h) .*( 0 + 0 - C(i-1,j) - C(i,j) );
            my1 = -1/(2*h) .*( 0 - 0 + C(i-1,j) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i-1,j) + C(i,j) - C(i-1,j-1) - C(i,j-1) );
            my2 = -1/(2*h) .*( C(i-1,j) - C(i,j) + C(i-1,j-1) - C(i,j-1) );
            mx3 = -1/(2*h) .*( 0 + 0 - C(i,j) - 0 );
            my3 = -1/(2*h) .*( 0 - 0 + C(i,j) - 0 );
            mx4 = -1/(2*h) .*( C(i,j) + 0 - C(i,j-1) - 0 );
            my4 = -1/(2*h) .*( C(i,j) - 0 + C(i,j-1) - 0 );
            
        elseif i==1
            % Top side of boundaries
            mx1 = -1/(2*h) .*( 0 + C(i,j+1) - 0 - C(i,j) );
            my1 = -1/(2*h) .*( 0 - C(i,j+1) + 0 - C(i,j) );
            mx2 = -1/(2*h) .*( 0 + C(i,j) - 0 - C(i,j-1) );
            my2 = -1/(2*h) .*( 0 - C(i,j) + 0 - C(i,j-1) );
            mx3 = -1/(2*h) .*( C(i,j+1) + C(i+1,j+1) - C(i,j) - C(i+1,j) );
            my3 = -1/(2*h) .*( C(i,j+1) - C(i+1,j+1) + C(i,j) - C(i+1,j) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i+1,j) - C(i,j-1) - C(i+1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i+1,j) + C(i,j-1) - C(i+1,j-1) );
        elseif i==length(x)
            % Bottom side of boundaries
            mx1 = -1/(2*h) .*( C(i-1,j+1) + C(i,j+1) - C(i-1,j) - C(i,j) );
            my1 = -1/(2*h) .*( C(i-1,j+1) - C(i,j+1) + C(i-1,j) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i-1,j) + C(i,j) - C(i-1,j-1) - C(i,j-1) );
            my2 = -1/(2*h) .*( C(i-1,j) - C(i,j) + C(i-1,j-1) - C(i,j-1) );
            mx3 = -1/(2*h) .*( C(i,j+1) + 0 - C(i,j) - 0 );
            my3 = -1/(2*h) .*( C(i,j+1) - 0 + C(i,j) - 0 );
            mx4 = -1/(2*h) .*( C(i,j) + 0 - C(i,j-1) - 0 );
            my4 = -1/(2*h) .*( C(i,j) - 0 + C(i,j-1) - 0 );

        elseif j==1
            % Left side of boundaries
            mx1 = -1/(2*h) .*( C(i-1,j+1) + C(i,j+1) - C(i-1,j) - C(i,j) );
            my1 = -1/(2*h) .*( C(i-1,j+1) - C(i,j+1) + C(i-1,j) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i-1,j) + C(i,j) - 0 - 0 );
            my2 = -1/(2*h) .*( C(i-1,j) - C(i,j) + 0 - 0 );
            mx3 = -1/(2*h) .*( C(i,j+1) + C(i+1,j+1) - C(i,j) - C(i+1,j) );
            my3 = -1/(2*h) .*( C(i,j+1) - C(i+1,j+1) + C(i,j) - C(i+1,j) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i+1,j) - 0 - 0 );
            my4 = -1/(2*h) .*( C(i,j) - C(i+1,j) + 0 - 0 );
        elseif j==length(y)
            % Right side of boundaries
            mx1 = -1/(2*h) .*( 0 + 0 - C(i-1,j) - C(i,j) );
            my1 = -1/(2*h) .*( 0 - 0 + C(i-1,j) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i-1,j) + C(i,j) - C(i-1,j-1) - C(i,j-1) );
            my2 = -1/(2*h) .*( C(i-1,j) - C(i,j) + C(i-1,j-1) - C(i,j-1) );
            mx3 = -1/(2*h) .*( 0 + 0 - C(i,j) - C(i+1,j) );
            my3 = -1/(2*h) .*( 0 - 0 + C(i,j) - C(i+1,j) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i+1,j) - C(i,j-1) - C(i+1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i+1,j) + C(i,j-1) - C(i+1,j-1) );
        else
            % Points in between the outermost boundaries
            mx1 = -1/(2*h) .*( C(i-1,j+1) + C(i,j+1) - C(i-1,j) - C(i,j) );
            my1 = -1/(2*h) .*( C(i-1,j+1) - C(i,j+1) + C(i-1,j) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i-1,j) + C(i,j) - C(i-1,j-1) - C(i,j-1) );
            my2 = -1/(2*h) .*( C(i-1,j) - C(i,j) + C(i-1,j-1) - C(i,j-1) );
            mx3 = -1/(2*h) .*( C(i,j+1) + C(i+1,j+1) - C(i,j) - C(i+1,j) );
            my3 = -1/(2*h) .*( C(i,j+1) - C(i+1,j+1) + C(i,j) - C(i+1,j) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i+1,j) - C(i,j-1) - C(i+1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i+1,j) + C(i,j-1) - C(i+1,j-1) );
        end
        
        % Summing of mx and my components for normal vector
        mxsum(i,j) = (mx1+mx2+mx3+mx4)/4;
        mysum(i,j) = (my1+my2+my3+my4)/4;
        
        % Normalizing the normal vector into unit vectors
        if mxsum(i,j)==0 && mysum(i,j)==0 
            mx(i,j) = mxsum(i,j);
            my(i,j) = mysum(i,j);
        else
            magnitude(i,j) = sqrt(mxsum(i,j)^2+mysum(i,j)^2); 
            mx(i,j) = mxsum(i,j)/ magnitude(i,j);
            my(i,j) = mysum(i,j)/ magnitude(i,j);
        end
    end
end

