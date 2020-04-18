function M = youngsFD(C)
M = zeros(length(x) - 2);
for i = 2:length(x)-1
    for j = 2:length(x)-1
        
    mx1 = -1/(2*h) .*( C(i+1,j+1) + C(i+1,j) - C(i,j+1) - C(i,j) );
    my1 = -1/(2*h) .*( C(i+1,j+1) - C(i+1,j) + C(i,j+1) - C(i,j) );
    mx2 = -1/(2*h) .*( C(i,j+1) + C(i,j) - C(i-1,j+1) - C(i-1,j) );
    my2 = -1/(2*h) .*( C(i,j+1) - C(i,j) + C(i-1,j+1) - C(i-1,j) );
    mx3 = -1/(2*h) .*( C(i+1,j) + C(i+1,j-1) - C(i,j) - C(i,j-1) );
    my3 = -1/(2*h) .*( C(i+1,j) - C(i+1,j-1) + C(i,j) - C(i,j-1) );
    mx4 = -1/(2*h) .*( C(i,j) + C(i,j-1) - C(i-1,j) - C(i-1,j-1) );
    my4 = -1/(2*h) .*( C(i,j) - C(i,j-1) + C(i-1,j) - C(i-1,j-1) );
    
    m1 = (mx1^2 + my1^2)^(1/2);
    m2 = (mx2^2 + my2^2)^(1/2);
    m3 = (mx3^2 + my3^2)^(1/2);
    m4 = (mx4^2 + my4^2)^(1/2);
    M(i,j) = (m1+m2+m3+m4)/4;
    end
end
