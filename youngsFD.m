function [mx,my] = youngsFD(h,x,y,C)

mxsum = zeros(1,length(x));
mysum = zeros(1,length(y));
magnitude = zeros(1,length(y));

for i = 1:length(x)
    for j = 1:length(y)
        if i==1 && j==1
            % Top left corner of matrix (lower-left corner of geometry)
             mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
             my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
             mx2 = -1/(2*h) .*( C(i+1,j) + 0 - C(i,j) - 0 );
             my2 = -1/(2*h) .*( C(i+1,j) - 0 + C(i,j) - 0 );
             mx3 = -1/(2*h) .*( C(i,j) + 0 - 0 - 0 );
             my3 = -1/(2*h) .*( C(i,j) - 0 + 0 - 0 );
             mx4 = -1/(2*h) .*( C(i,j+1) + C(i,j) - 0 - 0 );
             my4 = -1/(2*h) .*( C(i,j+1) - C(i,j) + 0 - 0 );
        elseif i==1 && j==length(y)
            % Top right corner of matrix (upper-left corner of geometry)
             mx1 = -1/(2*h) .*( 0 + C(i+1,j) - 0 - C(i,j) );
             my1 = -1/(2*h) .*( 0 - C(i+1,j) + 0 - C(i,j) );
             mx2 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
             my2 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
             mx3 = -1/(2*h) .*( C(i,j) + C(i,j-1) - 0 - 0 );
             my3 = -1/(2*h) .*( C(i,j) - C(i,j-1) + 0 - 0 );
             mx4 = -1/(2*h) .*( 0 + C(i,j) - 0 - 0 );
             my4 = -1/(2*h) .*( 0 - C(i,j) + 0 - 0 );
        elseif i==length(x) && j==1
            % Bottom left corner of martix (lower-right corner of geometry)
             mx1 = -1/(2*h) .*( 0 + 0 - C(i,j+1) - C(i,j) );
             my1 = -1/(2*h) .*( 0 - 0 + C(i,j+1) - C(i,j) );
             mx2 = -1/(2*h) .*( 0 + 0 - C(i,j) - 0 );
             my2 = -1/(2*h) .*( 0 - 0 + C(i,j) - 0 );
             mx3 = -1/(2*h) .*( C(i,j) + 0 - C(i-1,j) - 0 );
             my3 = -1/(2*h) .*( C(i,j) - 0 + C(i-1,j) - 0 );
             mx4 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
             my4 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
        elseif i==length(x) && j==length(y)
            % Bottom right corner of matrix (upper-right corner of geometry)
             mx1 = -1/(2*h) .*( 0 + 0 - 0 - C(i,j) );
             my1 = -1/(2*h) .*( 0 - 0 + 0 - C(i,j) );
             mx2 = -1/(2*h) .*( 0 + 0 - C(i,j) - C(i,j-1) );
             my2 = -1/(2*h) .*( 0 - 0 + C(i,j) - C(i,j-1) );
             mx3 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
             my3 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
             mx4 = -1/(2*h) .*( 0 + C(i,j) - 0 - C(i-1,j) );
             my4 = -1/(2*h) .*( 0 - C(i,j) + 0 - C(i-1,j) );
            
        elseif i==1
            % Top side of matrix (leftmost boundary of geometry)
             mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
             my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
             mx2 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
             my2 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
             mx3 = -1/(2*h) .*( C(i,j) + C(i,j-1) - 0 - 0 );
             my3 = -1/(2*h) .*( C(i,j) - C(i,j-1) + 0 - 0 );
             mx4 = -1/(2*h) .*( C(i,j+1) + C(i,j) - 0 - 0 );
             my4 = -1/(2*h) .*( C(i,j+1) - C(i,j) + 0 - 0 );
        elseif i==length(x)
            % Bottom side of matrix (rightmost boundary of geometry)
             mx1 = -1/(2*h) .*( 0 + 0 - C(i,j+1) - C(i,j) );
             my1 = -1/(2*h) .*( 0 - 0 + C(i,j+1) - C(i,j) );
             mx2 = -1/(2*h) .*( 0 + 0 - C(i,j) - C(i,j-1) );
             my2 = -1/(2*h) .*( 0 - 0 + C(i,j) - C(i,j-1) );
             mx3 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
             my3 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
             mx4 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
             my4 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
        elseif j==1
            % Left side of matrix (bottommost boundary of geometry)
             mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
             my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
             mx2 = -1/(2*h) .*( C(i+1,j) + 0 - C(i,j) - 0 );
             my2 = -1/(2*h) .*( C(i+1,j) - 0 + C(i,j) - 0 );
             mx3 = -1/(2*h) .*( C(i,j) + 0 - C(i-1,j) - 0 );
             my3 = -1/(2*h) .*( C(i,j) - 0 + C(i-1,j) - 0 );
             mx4 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
             my4 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
        elseif j==length(y)
            % Right side of matrix (topmost boundary of geometry)
             mx1 = -1/(2*h) .*( 0 + C(i+1,j) - 0 - C(i,j) );
             my1 = -1/(2*h) .*( 0 - C(i+1,j) + 0 - C(i,j) );
             mx2 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
             my2 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
             mx3 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
             my3 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
             mx4 = -1/(2*h) .*( 0 + C(i,j) - 0 - C(i-1,j) );
             my4 = -1/(2*h) .*( 0 - C(i,j) + 0 - C(i-1,j) );
        else
            % Points in between the outermost boundaries
             mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
             my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
             mx2 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
             my2 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
             mx3 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
             my3 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
             mx4 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
             my4 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
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

