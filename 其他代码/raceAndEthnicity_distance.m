% 本脚本用于计算民族距离，其公式为ED=sqrt(sum((e(i,k)-e(j,k))^2));

%% 首先创建变量并粘贴进来数据，数据应该横向为民族分布，纵向为地区
data = zeros(1);
% 提取地区数量
city_num = size(data,1);
% 提取民族数量，或者说最大民族数量
race_num = size(data,2);

% 预设置结果矩阵，边长为地区数量。
ED = zeros(city_num);
id_A = zeros(city_num);
id_B = zeros(city_num);
% 进行距离的计算
for i = 1:city_num
    for j = i:city_num
        id_A(i,j)=i;
        id_B(i,j)=j;
        ED(i,j) = sqrt(sum((data(i,:)-data(j,:)).^2));
    end
end

%% 将数据整合成三列，分别是城市A的序号，B的序号，以及民族距离
% 首先创建矩阵，大小为城市两两组合数。

ED_column = zeros(nchoosek(city_num,2)+city_num,3);
k = 1;
for i = 1:city_num
    for j = i:city_num
        ED_column(k,1) = i;
        ED_column(k,2) = j;
        ED_column(k,3) = ED(i,j);
        k=k+1;
    end
end
















