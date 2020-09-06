function [ T,Y ] = runge_kutta( )
%  Runge_Kutta ∑Ω∑®≤‚ ‘Ω≈±æ


function dy = state3(~,y)
k12 = 3;
k32 = 0.8;
k21 = 0.5;
k23 = 0.2;
dy = zeros(3,1);    % a column vector
dy(1) = k21*y(2)- k12*y(1);
dy(2) = k12*y(1) - k21*y(2) - k23*y(2) + k32*y(3);
dy(3) = k23*y(2) - k32*y(3);
end

[T,Y] = ode45(@state3,[0,10],[1,0,0]);
plot(T,Y(:,1),'-',T,Y(:,2),'-.',T,Y(:,3),'.');
end

