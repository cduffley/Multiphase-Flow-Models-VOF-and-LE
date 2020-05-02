function new_x = cellfinder(x,mx,my,new_x_r)

if (mx > 0 && my<0) || (mx>0 && my>0) %4 and 1
    new_x =  h*floor((new_x_r)/h);
end

if (mx < 0 && my>0) || (mx<0 && my<0) %2 and 3
    new_x =  h*floor((x+h+dx)/h);
    
end