 

A = 0.9;
B = 1;

x = 0:0.01:1;

f = A*x.^2.*(B-x.^2);

plot(x,f);