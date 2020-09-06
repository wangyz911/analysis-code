function [ down,mid, up ] = dwell_time_count3( data_z )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%% 对得到的数据进行滤波处理，并分类进行指数拟合
%设定参数
N = size(data_z,1);
%% 开始使用二分法迭代，得到全局最优的J

        search_result = J_search(data_z,0.7);
        %得到step的位置和个数
        step_position = find(search_result==1);

%         % 根据找到的step位置得到拟合曲线
%         fitted_data = get_fitted_data(data_z,step_position);
%         %对拟合曲线作图，为选值做准备
%         figure;
%         plot(1:N,data_z,1:N,fitted_data,'LineWidth',2);
        %% 将漂移导致的小的step合并，将个别点造成的尖峰合并滤除。
        % 找到漂移点；
        step_info = get_step_info(data_z,step_position) ;
        %此处的 step_shift其实只有初始化和判定循环条件的作用，找到一个就够了，函数内还会重新找。
        step_check = 0.005;
        length_check = 2;
        step_shift = find(abs(diff(step_info(:,2)))<=step_check, 1);
        while (~isempty(step_shift))
            [ step_position,step_info, step_shift ] = shift_cor( data_z, step_position, step_check ,length_check);
        end
                %对拟合曲线作图，为选值做准备
        fitted_data_modi = get_fitted_data(data_z,step_position);
        figure;
        plot(1:N,data_z,1:N,fitted_data_modi,'LineWidth',2);        
        
%% 看图后手动确定有几个态，并选取阈值，按阈值关系将每一段归类，最后输出结果，由主脚本来完成指数拟合工作。

           disp('取点说明，请取尽量明确区分两个态的中间的点, 从低向高处取点')
           [~,threshold_y] = ginput(2);
           segment_down = step_info(:,2) < threshold_y(1,1);
           segment_mid = step_info(:,2)> threshold_y(1,1)&step_info(:,2) < threshold_y(2,1);
           segment_up = step_info(:,2)> threshold_y(2,1);
           dwell_time_down = step_info(segment_down,1);
           dwell_time_mid = step_info(segment_mid,1);
           dwell_time_up = step_info(segment_up,1);

           dwell_time_up = dwell_time_up./60;
           dwell_time_down = dwell_time_down./60;
           dwell_time_mid = dwell_time_mid./60;
           %对统计的时间做指数拟合
           [down,mid,up] = createFit3(dwell_time_down,dwell_time_mid,dwell_time_up);

end

