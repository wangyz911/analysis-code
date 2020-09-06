N = 50;

data = ones(50,50);

xc = 25:0.1:30;
yc = 25:(-0.1):20;

for i = 1:9
  [r_x,r_y,r_x0,r_y0,r_x1,r_y1] = polar2grid(xc(i),yc(i));
  [r2_x,r2_y,r2_x0,r2_y0,r2_x1,r2_y1] = polar2grid(xc(i+1),yc(i+1));
  diff_x = r_x-r_x2;
  diff_y = r_y-r_y2;
  diff_x0 = r_x0-r2_x0;
  diff_y0 = r_y0-r2_y0;
end



