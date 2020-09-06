function [ DI,DI2 ] = D(patent)
%UNTITLED2 此处显示有关此函数的摘要
%   初始基本参数
t1 = size(patent,1);
DI = zeros(t1);
%计算各地区专利差
for X = 1:t1
    for Y = X:t1
DI(X,Y)=abs(patent(X)-patent(Y));
    end
DI2 = zeros(sum(0:(t1-1)),1);
m = 1;
for i=2:t1
    DI2(m:(m+i-2)) =DI(1:(i-1),i);
    m = m+i-1;
end
end