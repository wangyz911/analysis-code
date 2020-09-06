function [ D2 ] = GD( geneX )
%利用neil 公式进行基因距离的计算

%%   导入任意两个数据，代入时已完成
%%   给出nei 公式
%初始基本参数
n = 3;

t2 = size(geneX,2);                                 %获得基因频率矩阵的列数，即参与比较的省份数

D = zeros(t2);                                   %预先设定一个矩阵来保存基因距离的结果,矩阵大小应与省份数保持一致

%分别计算基因频率的几个部分
        
J2 = sum(geneX.^2)/n;                               %求出所有省的基因频率的平方项
% Jy = sum(geneY.^2)/n;
Jxy = geneX'* geneX /n;                             %求出所有省的基因频率的交叉项
%计算两个群体的总基因频率
for X = 1:t2
    for Y = 1:t2
D(X,Y) = -log(Jxy(X,Y)/sqrt(J2(X)*J2(Y)));          %对任意两个省X,Y，计算基因距离矩阵，为了避免重复计算，使Y的取值大于等于X
    end
end
%计算结果是一个上三角矩阵，将其下三角抹去，然后按顺序拼成一个长列
D2 = zeros(sum(1:t2),1);
m = 1;
for i=1:t2
    D2(m:(m+i-1)) =D(1:i,i);
    m = m+i;
end
% 输出结果为D2


end

