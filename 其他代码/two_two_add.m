% 计算任意两行的数值加和并保存在新数组中，前两列为相加的城市代码，第三列为相加结果

data = zeros(1);

city_num = size(data,1);

add_result = zeros(nchoosek(city_num,2),3);
k = 1;
for i = 1:(city_num-1)
    for j = (i+1):city_num
        add_result(k,1) = data(i,1);
        add_result(k,2) = data(j,1);
        add_result(k,3) = data(i,2)+data(j,2);
        k = k+1;
    end 
end
