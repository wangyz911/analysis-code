function [rdp_with_pow] = rdp_power(r_sample,rdp)
% ��������rdp ����Ȩ�أ����������ڼ��������Ƿ��а�����
%   Ȩ�غ����Լ���������ͼ��

r_step = size(r_sample,2);
x = zeros(1,r_step);
for i=1:r_step
    x(i) = (i-1)/r_step;
end
t2 = 0.05;
t1 = 0.01;
fall = 1-exp(-(1-x).^2./t2);
rise = 1-exp(-x.^2./t1);
wnd = sqrt(fall.*rise.*x.*2);

rdp_with_pow = rdp.*wnd;
% 
% % plot(x,wnd);
% plot(r_sample,rdp);
% hold on
% plot (r_sample,rdp_with_pow)
end

