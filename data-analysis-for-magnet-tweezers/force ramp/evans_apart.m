% evans apart
F=3:15;
k0=0.00449;
dx=4.27;
a=0.64;
P =a*(   k0/0.2  *  exp(  dx*F/4.1+ 4.1*k0/(dx*0.2) *( 1- exp(dx*F/4.1)  )  )   );
plot(F,P)
