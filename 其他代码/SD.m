function [ SD ] =SD(surnameX)
%利用姓氏的频率计算不同地区的基因距离

%% 导入任意两个数据，代入时已完成
%%   给出nei 公式
%初始基本参数
n = 1;
t1 = size(surnameX,1);                                 %获得姓氏频率矩阵的行数，即基因频率项数
t2 = size(surnameX,2);                                 %获得姓氏频率矩阵的列数，即参与比较的地区数

SD = zeros(t2);                                   %预先设定一个矩阵来保存基因距离的结果,矩阵大小应与地区数保持一致
D = SD;
%分别计算基因频率的几个部分
        
J2 = sum(surnameX.^2)/n;                               %求出所有地区姓氏频率的平方项
% Jy = sum(geneY.^2)/n;
Jxy = surnameX'* surnameX /n;                             %求出所有地区的姓氏频率的交叉项
%计算两个群体的总基因频率
for X = 1:t2
    for Y = X:t2
SD(X,Y) = -log(Jxy(X,Y)/sqrt(J2(X)*J2(Y)));          %对任意两个地区X,Y，计算基因距离矩阵，为了避免重复计算，使Y的取值大于等于X
D(X,Y) = Jxy(X,Y)/sqrt(J2(X)*J2(Y));
    end
end

% 输出结果


end

