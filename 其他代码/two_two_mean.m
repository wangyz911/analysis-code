%% 第一步，新建一个变量 unnamed 把表复制进去。
% unnamed 是从上往下数为省份，从左往右数为年份的数据源矩阵
trade = unnamed;
% 读取表格的大小
trade_size = size(trade,1);
year_num = size(trade,2);
% 下面这个函数是组合数，看N个省份两两有几个组合
trade_array = zeros(nchoosek(trade_size,2)*year_num,1);
k=1;
for y = 1:year_num
% 最后结果的初始序号

% 存放计算均值结果的矩阵
trade_mean = zeros(trade_size);

% 计算均值
for i=1:(trade_size-1)
    for j = (i+1):trade_size
        trade_mean(i,j)=(trade(i,y)+trade(j,y))/2;
    end

end
% 变成一列
for i = 2:(trade_size)
    for j = 1:(i-1)
        trade_array(k,1) = trade_mean(j,i);
        k=k+1;
    end
end
end
