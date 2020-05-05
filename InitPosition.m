function [xCoord, yCoord] = InitPosition(n, mode)
%i = 0;
xCoord = zeros(1,n);
yCoord = zeros(1,n);

switch mode
    case 1
        %Test Mode (1 Particle roughly in the middle)
        %particlePos = zeros(Nx,Ny);
        xCoord = 0.5;
        yCoord = 0.5;
    case 2
        %Uniform Distribution
        sqrtn = sqrt(n);
        interval = 1/(sqrtn-1);
        k = interval;
        l = interval;
        count = 1;
        %disp(interval)
%       xCoord(1) = 0;
%       yCoord(1) = 0;
        
        for j = 1:sqrtn
            for i = 1:sqrtn
                xCoord(count) = k;
                yCoord(count) = l;
                k = k + interval;
                count = count + 1;
            end
            k = interval;
            l = l + interval;
        end
        
%         %Zero out bottom left
%         xCoord(1) = 0;
%         yCoord(1) = 0;
%         
%         %Zero out bottom, top, left, and right rows
%         xCoord(1:sqrtn) = 0;
%         xCoord(end-sqrtn:end) = 0;
%         yCoord(1:sqrtn) = 0;
%         yCoord(end-sqrtn:end) = 0;
%         
%         for z = 1+sqrtn:sqrtn:n
%             xCoord(z) = 0;
%             xCoord(z+sqrtn-1) = 0;
%             yCoord(z) = 0;
%             yCoord(z+sqrtn-1) = 0;
%         end
%         
%         %Zero out bottom rows
        
        
    case 3
        %Random Distribution
        xCoord = rand(1,n);
        yCoord = rand(1,n);
end