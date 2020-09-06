function [ OAV ] = allanVariance( data )
%计算一条磁球轨迹的allan方差，得到结果（并作图）
%% 得到原始数据，注意输入的数据必须是N x 1格式的向量
%% allan variance 的计算公式
%单位换算
data_nm = data*1000;
%确定数据的大小，确定均值窗口的大小
data_size = size(data,1);
N = 0:(floor(log2(data_size))-1);
m_size = 2.^N;
%% 代入OAV公式计算
%预设置分段矩阵，均值结果向量，OAV结果向量
window = cell(size(m_size));
x_mean1 = zeros(data_size,1);
OAV = zeros(size(m_size,2),1);
%另设定一个x_mean2 来作为循环相减的向量，避免过多使用for循环
x_mean2 = zeros(data_size+1,1);

for n=1:size(m_size,2)
    %n中分段法，有n个分段方式，装在cell中
    window(n)= {1:m_size(n)};
    %第n种分段情况下，求出的均值共有多少个，即mean_size
    mean_size = data_size-max(window{n});
    
    for  t = 0 :(mean_size-1)
        x_mean1(t+1) = mean(data_nm(window{n}+t));
    end
    %按照公式计算OAV
    x_mean2(2:end) = x_mean1;
    OAV(n) = sum((x_mean2(2:end-1)-x_mean1(2:end)).^2/2)/mean_size;
end
%将帧数坐标换算成时间坐标，作双对数图像
    time = m_size./60;
    figure;
    loglog(time(1:end),OAV(1:end));
end

