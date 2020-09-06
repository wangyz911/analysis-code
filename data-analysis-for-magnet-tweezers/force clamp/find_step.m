function [ fitted_data ,step_info] = find_step( data_z )
%本函数是基于卡方分布的step detect方法的函数版，没有什么新内容，就是方便其他脚本调用
%内容基本与step_main脚本一致
%% 获取data的大小
% N = size(data_z,1);

%% 开始使用二分法迭代，得到全局最优的J
step_position = J_search(data_z,0.7);
% step_count = size(step_position,1);
%% 根据找到的step位置得到拟合曲线
fitted_data = get_fitted_data(data_z,step_position);
%得到台阶的长度以及值的信息
step_info = get_step_info(data_z,step_position);
% %作图
% time_sequence = (1:N)/60;
% plot(time_sequence,data_z,time_sequence,fitted_data);
%% 做驻留时间统计
% [step_hist,step_fit_down,step_fit_mid,step_fit_up ] = step_hist(fitted_data,step_info);


end

