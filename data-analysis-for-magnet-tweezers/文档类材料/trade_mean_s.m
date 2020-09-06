%% 第一步，新建一个变量 unnamed 把表复制进去。
trade = unnamed;
% 读取表格的大小
trade_size = size(trade,1);
% 下面这个函数是组合数，看N个省份两两有几个组合
trade_array = zeros(nchoosek(trade_size,2),1);
% 最后结果的初始序号
k=1;
% 存放计算均值结果的矩阵
trade_mean = zeros(size(trade));
% 计算均值
for i=1:(trade_size-1)
    for j = (i+1):trade_size
        trade_mean(i,j)=(trade(i,j)+trade(j,i))/2;
    end
    
end
% 变成一列
for i = 2:(trade_size)
    for j = 1:(i-1)
        trade_array(k) = trade_mean(j,i);
        k=k+1;
    end
end

        
        