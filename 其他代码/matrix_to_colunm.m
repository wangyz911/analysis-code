% 创建矩阵，把矩阵复制进来
% 得到矩阵的元素数
a = size(yuyanjuli_pro);
num  =a(1)*a(2);  %就是矩阵的行数乘以列数
one_column_data = reshape(unnamed,num,1);   %得到了一列的数据


%% 把一个上三角矩阵转成一列 按列排（竖着数）
a = size(yuyanjuli_pro,1);
num = nchoosek(a,2);
data = zeros(num-a,1);


s = 1;
for i = 2:a
    data(s:(s+i-2)) =unnamed(1:(i-1),i);
    s = s+i-1;
end
%% 排成三列
yuyan_pro_array = zeros(nchoosek(size(pro,1),2)+size(pro,1),3);
k = 1;
for j = 1:size(pro,1)
    for i = 1:j
        yuyan_pro_array(k,1) = pro(i);
        yuyan_pro_array(k,2) = pro(j);
        yuyan_pro_array(k,3) = yuyanjuli_pro(i,j);
        k=k+1;
    end
end


%% 把一个下三角矩阵转成一列 按列排（竖着数）
a = size(unnamed,1);
num = nchoosek(a,2);
data = zeros(num,1);


s = 1;
for i = 1:(a)
    j = a-i;
    data(s:(s+j-1)) =unnamed((i+1):a,i);
    s = s+j;
end
cen = zeros(a,1);
for i = 1:a
    cen(i) = unnamed(i,i);
end 

    