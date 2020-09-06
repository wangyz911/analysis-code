
%step 搜索工作的主程序（脚本）
%利用卡方分布以及罚函数原理来检测出step，并进行拟合
%  罚函数为J = 卡方=sum(k=1:N)（实际值k-预测值k）^2  - W *
%  sum(k=1:N)delta(xk-x(k-1)),第一部分描述的是卡方值，第二部分描述的是总step数，W =
%  9sigma^2，是原始数据的方差。
%% 预设置系数以及结果矩阵
clc;
clear;
load test_data_two_states;
data_z = test_data_two_states(1:5000);
N = size(data_z,1);

%% 开始使用二分法迭代，得到全局最优的J
search_result = J_search(data_z,0.7);
%得到step的位置和个数
step_position = find(search_result==1);
step_count = size(step_position,1);
%% 根据找到的step位置得到拟合曲线
fitted_data = get_fitted_data(data_z,step_position);
%得到台阶的长度以及值的信息
step_info = get_step_info(data_z,step_position);
%作图
time_sequence = (1:N)/60;
plot(time_sequence,data_z,time_sequence,fitted_data);
%% 做驻留时间统计
[step_hist,step_fit_down,step_fit_mid,step_fit_up ] = step_hist(fitted_data,step_info);

