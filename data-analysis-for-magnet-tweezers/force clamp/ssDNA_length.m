function [ length ] = ssDNA_length(f)
%force_estimate  通过ssDNA force curve的公式，在给定力值和碱基数的的情况下计算ssDNA长度的大小。
% 设定好公式的参数，此公式适用范围为力值0~100pN，盐浓度大于50mM K+
% 该公式在使用时需要先手动调整bp数
h =0.34;
K=0.1;  %K+ 浓度, 单位为mol
a1=0.21;   a2=0.34;   a3=2.1*log(K/0.0025)/log(0.15/0.0025);
f1=0.0037;  f2=2.9;
f3=8000;
bp = 21;
length = bp*h*(a1*log(f/f1)/(1+a3*exp(-f/f2))-a2-f/f3);

end

