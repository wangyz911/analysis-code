unnamed = zeros(1);
%将数据粘贴到如上矩阵中，每一竖排代表同一年各省的创新数，不同竖排代表不同年份
%在这里设定省份数和年数，比如这里是23个省12年
prov_num = 23;
year_num = 12;
%自动将一长列转化成每年一列，用于后面的分析
prov_year = zeros(23,12);
m = 1;
for i = 1:12
    prov_year(:,i)=unnamed(m:prov_num*i);
    m = m + prov_num;
end


%预设置结果矩阵，用于保存结果
PD_year = zeros(sum(1:prov_num),year_num);
PD_year_ln = zeros(sum(1:prov_num),year_num);
for year = 1:year_num
    %提取第year年的创新数据，进行分析
    patent = prov_year(:,year);
    [DI,DI2] = D(patent);
    [ DI_ln,DI_ln2 ] = logD(patent);
    %得到结果后，保存该年创新结果
    PD_year(:,year) = DI2;
    PD_year_ln(:,year) = DI_ln2;
end
    