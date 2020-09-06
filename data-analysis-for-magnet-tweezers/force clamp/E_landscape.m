function [ dE, dx, S] = E_landscape( area_force )
%本函数用于已知折叠/展开态的hist面积和力值，计算自由能势垒。
%输入为函数N*3的数组，三列分别是A状态面积，B状态面积，对应力值。
%输出为1*3数组，分别为dE,dX, 数据的好坏评估S。
%% 归一化面积为比率。
area_force_t=area_force';
A=area_force_t(1,:);
B=area_force_t(2,:);
F=area_force_t(3,:);
sum = A+B;
A_normal = A./sum;
B_normal = B./sum;
%% 计算自由能势垒的值及其误差
E_point=B_normal./A_normal;
E_point_ln=log(E_point);
[fit,S] = polyfit(F,E_point_ln,1);                                         %多项式拟合，返回的fit为长度为1+1的向量，分别是次数由高到低的系数。S 为拟合的置信度分析。
dE=fit(2);                                                                 %常数项
dx=fit(1);
% erA=area_force_t(2,:)./A;
% erB = area_force_t(4,:)./B;
% errorE=sqrt(erA.^2+erB.^2).*E_point;                                  %相对误差的合成

%% 作图显示结果
figure;
hold on;
hf=errorbar(E_point,F,0.05*F,'r*');
Fs=F(1):0.01:F(end);
plot(exp(dE+Fs.*dx),Fs);


end

