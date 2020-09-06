% 使用差分进化算法计算这个函数f = @(x,y) -20.*exp(-0.2.*sqrt((x.^2+y.^2)./2))-exp((cos(2.*pi.*x)+cos(2.*pi.*y))./2)+20+exp(1) 在区间[-4,4]上的最小值
% 它真正的最小值点是(0,0)
% 感觉这个算法很强，可以学习一下

N = 20; %设置种群数量
F = 0.5; %设置差分缩放因子
P_cr = 0.5; %设置交叉概率
T = 300; %设置最大迭代次数
f = @(x,y) -20.*exp(-0.2.*sqrt((x.^2+y.^2)./2))-exp((cos(2.*pi.*x)+cos(2.*pi.*y))./2)+20+exp(1); %定义目标函数

%种群初始化
population = -4 + rand(N,2).*8;
t = 0; %代数初始化
%开始迭代
while t < T
    %变异
    H_pop = [];
    for i = 1:N
        index = round(rand(1,3).*19)+1;
        add_up = population(index(1),:) + F.*(population(index(2),:)-population(index(3),:));
        H_pop = [H_pop; add_up];
    end
    %交叉
    V_pop = H_pop;
    for i = 1:N
        for j = 1:2
            if rand > P_cr
                V_pop(i,j) = population(i,j);
            end
        end
    end
    %选择
    for i = 1:N
        f_old = f(population(i,1),population(i,2));
        f_new = f(V_pop(i,1),V_pop(i,2));
        if f_new < f_old
            population(i,:) = V_pop(i,:);
        end
    end
    %更新t值
    t = t + 1;
end
population
% ————————————————
% 版权声明：本文为CSDN博主「NULL_M」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/weixin_42528077/article/details/82779819