clc;
clear all;
%导入数据
load test_data_two_states;

%截取部分数据做测试
test=test_data_two_states(1:20000);
%得到数据大小
size_test=size(test,1);
%得到数据对应的时间序列
time_test=1:size_test;

%得到step的位置信息
step_position_bool=mixed_chi_square(test,1.8);
%提取step的位置信息
step_position=find(step_position_bool==1);
%得到step的个数
position_size=size(step_position,1);
%根据step信息拟合出step的曲线
fitted_candidate=get_fitted_candidate(test,step_position);
%得到每个step的长度，值，标准差
[step_length,state_value,state_std]=get_step_length(test,step_position);
%最后作图
plot(time_test,test,'b',time_test,fitted_candidate,'r');