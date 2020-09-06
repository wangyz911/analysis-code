a = 0.01:0.01:2;
S = 2./a-2./(a.^2).*(1-exp(-a));
figure;
plot(a,S);
xlabel('a');
ylabel('S');
