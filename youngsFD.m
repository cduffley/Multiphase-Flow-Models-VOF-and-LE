function [mx,my] = youngsFD(h,x,y,C)

mx = zeros(length(x));
my = zeros(length(y));

for i = 1:length(x)
    for j = 1:length(y)
        if i==1 & j==1
            % Bottom left corner of boundaries
                mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
                my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
                mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - 0 - 0 );
                my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + 0 - 0 );
                mx3 = -1/(2*h) .*( C(i+1,j) + 0 - C(i,j) - 0 );
                my3 = -1/(2*h) .*( C(i+1,j) - 0 + C(i,j) - 0 );
                mx4 = -1/(2*h) .*( C(i,j) + 0 - 0 - 0 );
                my4 = -1/(2*h) .*( C(i,j) - 0 + 0 - 0 );
        elseif i==1 & j==length(y)
            % Top left corner of boundaries
                mx1 = -1/(2*h) .*( 0 + C(i+1,j) - 0 - C(i,j) );
                my1 = -1/(2*h) .*( 0 - C(i+1,j) + 0 - C(i,j) );
                mx2 = -1/(2*h) .*( 0 + C(i,j) - 0 - 0 );
                my2 = -1/(2*h) .*( 0 - C(i,j) + 0 - 0 );
                mx3 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
                my3 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
                mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - 0 - 0 );
                my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + 0 - 0 );
        elseif i==length(x) & j==1
            % Bottom right corner of boundaries
            mx1 = -1/(2*h) .*( 0 + 0 - C(i,j+1) - C(i,j) );
            my1 = -1/(2*h) .*( 0 - 0 + C(i,j+1) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
            my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
            mx3 = -1/(2*h) .*( 0 + 0 - C(i,j) - 0 );
            my3 = -1/(2*h) .*( 0 - 0 + C(i,j) - 0 );
            mx4 = -1/(2*h) .*( C(i,j) + 0 - C(i-1,j) - 0 );
            my4 = -1/(2*h) .*( C(i,j) - 0 + C(i-1,j) - 0 );
        elseif i==length(x) & j==length(y)
            % Top right corner of boundaries
            mx1 = -1/(2*h) .*( 0 + 0 - 0 - C(i,j) );
            my1 = -1/(2*h) .*( 0 - 0 + 0 - C(i,j) );
            mx2 = -1/(2*h) .*( 0 + C(i,j) - 0 - C(i-1,j) );
            my2 = -1/(2*h) .*( 0 - C(i,j) + 0 - C(i-1,j) );
            mx3 = -1/(2*h) .*( 0 + 0 - C(i,j) - C(i,j-1) );
            my3 = -1/(2*h) .*( 0 - 0 + C(i,j) - C(i,j-1) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
            
        elseif i==1
            % Left hand side of boundaries
                mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
                my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
                mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - 0 - 0 );
                my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + 0 - 0 );
                mx3 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
                my3 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
                mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - 0 - 0 );
                my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + 0 - 0 );
                
        elseif i==length(x)
            % Right hand side of boundaries
            mx1 = -1/(2*h) .*( 0 + 0 - C(i,j+1) - C(i,j) );
            my1 = -1/(2*h) .*( 0 - 0 + C(i,j+1) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
            my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
            mx3 = -1/(2*h) .*( 0 + 0 - C(i,j) - C(i,j-1) );
            my3 = -1/(2*h) .*( 0 - 0 + C(i,j) - C(i,j-1) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );

        elseif j==1
            % Bottom side of boundaries
                mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
                my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
                mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
                my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
                mx3 = -1/(2*h) .*( C(i+1,j) + 0 - C(i,j) - 0 );
                my3 = -1/(2*h) .*( C(i+1,j) - 0 + C(i,j) - 0 );
                mx4 = -1/(2*h) .*( C(i,j) + 0 - C(i-1,j) - 0 );
                my4 = -1/(2*h) .*( C(i,j) - 0 + C(i-1,j) - 0 );
   
        elseif j==length(y)
            % Top side of boundaries
                mx1 = -1/(2*h) .*( 0 + C(i+1,j) - 0 - C(i,j) );
                my1 = -1/(2*h) .*( 0 - C(i+1,j) + 0 - C(i,j) );
                mx2 = -1/(2*h) .*( 0 + C(i,j) - 0 - C(i-1,j) );
                my2 = -1/(2*h) .*( 0 - C(i,j) + 0 - C(i-1,j) );
                mx3 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
                my3 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
                mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
                my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
        else
            % Points in between the outermost boundaries
            mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
            my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
            mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
            my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
            mx3 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
            my3 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
            mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
            my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
        end
    mx(i,j) = (mx1+mx2+mx3+mx4)/4;
    my(i,j) = (my1+my2+my3+my4)/4;
    end
end

