
%利用neil 公式进行基因距离的计算

%%   导入任意两个数据，代入时已完成
%%%%%%%%%%%%%%%%%%%%%%  
%%   给出nei 公式
%初始基本参数， 首先执行前两行，创建两个空矩阵，把基因频率的数据放入geneX, 城市代码放入geneX_no
geneX = [];
geneX_no = [];   % 城市编号

%%%%%%%%%%%%%%%%%%%%%%
geneX1 = geneX.*1E-4;   % 这里是基因频率的单位，据说是要乘一个10的-4次方，根据实际情况可以修改
geneX = geneX1';        % 这里将基因频率矩阵转置一下，便于计算


%%%%%%%%%%%%%%%%%%%%%%
n = 1;

city_no = size(geneX,2);                                 %获得基因频率矩阵的列数，即参与比较的省份数

D = zeros(city_no);                                   %预先设定一个矩阵来保存基因距离的结果,矩阵大小应与省份数保持一致
A_name = zeros(city_no);                              % 预先设置一个矩阵来保存A城市的城市代码
B_name = zeros(city_no);                              %预先设置一个矩阵来保存B城市的城市代码


%分别计算基因频率的几个部分
        
J2 = sum(geneX.^2)/n;                               %求出所有省的基因频率的平方项
% Jy = sum(geneY.^2)/n;
Jxy = geneX'* geneX /n;                             %求出所有省的基因频率的交叉项
%计算两个群体的总基因频率
for X = 1:city_no
    for Y = X:city_no
        A_name(X,Y) = geneX_no(X);                 %这里计算AB两个城市间的基因距离，并分别保存AB两个城市的城市代码
        B_name(X,Y) = geneX_no(Y);
D(X,Y) = -log(Jxy(X,Y)/sqrt(J2(X)*J2(Y)));          %对任意两个省X,Y，计算基因距离矩阵，为了避免重复计算，使Y的取值大于等于X
    end
end

%%%%%%%%%%%%%%%%%%%%%%

% 将基因距离结果矩阵竖着排成一列
a = size(D,1);
num = nchoosek(a,2);
distance_array = zeros(num-a,1);   % 这个变量就是排成一列的最终结果

% 将基因距离对应的城市代码排成一列
distance_name = zeros(num-a,2);
s = 1;
for i = 2:a
    distance_name(s:(s+i-2),1) = A_name(1:(i-1),i);     %distance_name 是一个两列的矩阵，分别代表A城市和B城市的城市代码
    distance_name(s:(s+i-2),2) = B_name(1:(i-1),i);
    distance_array(s:(s+i-2)) =D(1:(i-1),i);            % 这个矩阵就是排成一列的基因距离，和上面的城市代码对一一对应
    s = s+i-1;
end




