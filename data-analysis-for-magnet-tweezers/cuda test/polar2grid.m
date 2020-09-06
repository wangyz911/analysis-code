function [r_x,r_y,r_x0,r_y0,r_x1,r_y1] = polar2grid(xc,yc)
N = 50;
step = 0.4;
r_min = 0;
r_max = floor(N/2-2);
r_N = floor((r_max-r_min)/step);
r = (0:r_N).*step;
r = r';
t_N = 16;
p = 0:(t_N-1);
t = p'.*2*pi/t_N;
r_x = zeros(r_N,t_N);
r_y = zeros(r_N,t_N);


for i = 1:r_N
    for j = 1:t_N
        r_x(i,j) = xc+r(i)*cos(t(j));
        r_y(i,j) = yc+r(i)*sin(t(j));
    end
end
r_x0 = floor(r_x);
r_x1 = r_x0+1;
r_y0 = floor(r_y);
r_y1 = r_y0+1;


end

