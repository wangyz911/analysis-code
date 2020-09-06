% 本脚本用于判断县市的民族距离，如果少数民族比例大于30%就算作是少数民族，与其他民族的距离为1
% data = [];
% 首先拷贝数据到data 内，第一列城市ID，第二列城市经度，第三列城市纬度。
city_id = data(:,1);
ethnicity = data(:,2);
same_or_dif = zeros(size(data,1));
% qinl_huaih = 32-34

for i = 1:size(data,1)
    for j =i:size(data,1)
        same_or_dif(i,j) = ethnicity(i)||ethnicity(j);
    end
end

% 排成三列
array = zeros(nchoosek(size(data,1),2),3);
k = 1;
for j = 1:size(data,1)
    for i = 1:j-1
        array(k,1) = city_id(i);
        array(k,2) = city_id(j);
        array(k,3) = same_or_dif(i,j);
        k=k+1;
    end
end