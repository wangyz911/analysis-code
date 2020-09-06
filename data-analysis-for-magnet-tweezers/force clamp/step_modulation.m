function [ fitted_data,stepsize,step_std,state_find,good ] = step_modulation( data_z,step_position,step_check,length_check)
% 本函数用来对最小卡方查找step的方法进行一些补充，通过鼠标确认到底有几个台，阈值位置在哪儿，然后对属于同一个态的小step进行值的平均和长度的叠加。
%参数介绍：输入参数：data_z是原始数据，用来对照fitted_data
%的拟合情况。step_position是step_detect的第一步结果。
%输出参数：stepsize是一个向量，大小和step数相同，保存的是step的长度，state_num是状态数，step_std是步长的标准差。
% 本函数专门独立出来就是为了处理多个态的情况。
%% 导入数据，作图并决定有几个状态，阈值位置
% 此处做一个多态设置，如果step_position值为0，进行step_detect查找，如果有现成的step_position,就直接采用
if size(step_position,1) < 2
    step_position = J_search(data_z,0.3);
end
% 分析step_position，先拿出原始结果
step_info = get_step_info(data_z,step_position);
% fitted_data = get_fitted_data(data_z,step_position);
N = size(data_z,1);
% figure;
% plot(1:N,data_z,1:N,fitted_data,'LineWidth',2);
        %% 将漂移导致的小的step合并，将个别点造成的尖峰合并滤除。
        % 找到漂移点；
        sample_rate = 100*60;

        %此处的 step_shift其实只有初始化和判定循环条件的作用，找到一个就够了，函数内还会重新找。
        step_shift = find(abs(diff(step_info(:,2)))<=step_check, 1);
        while (~isempty(step_shift))
            [ step_position,~, step_shift ] = shift_cor( data_z, step_position, step_check ,length_check);
        end
                %对拟合曲线作图，为选值做准备
        fitted_data_modi = get_fitted_data(data_z,step_position);
        fitted_data = fitted_data_modi.*1000;% 单位换算
        figure;
        plot((1:N)./sample_rate,data_z.*1000,(1:N)./sample_rate,fitted_data,'LineWidth',2);
        xlabel('Time(min)');
        ylabel('Ext.(nm)');
%% 判定是否好数据，是否需要分析
disp('good data ?')
good = str2double(input('1 or 0','s'));
if good == 1
    
% 确定有多少个态
disp('how many states ?')
state_num = str2double(input('states = ','s'));
th_n = state_num-1;
% 预设置矩阵来保存分区出来的坐标。
state_find = zeros(size(fitted_data,1),state_num);


[~,threshold_y] = ginput(th_n);
%% 根据阈值划分data，每部分的data 的值进行平均，每个态跳跃的步长和标准差。
for i = 1:th_n
    if i==1
    state_find(:,i) = fitted_data < threshold_y(i);
    elseif i>1
        state_find(:,i)=fitted_data < threshold_y(i)&fitted_data > threshold_y(i-1);
    end
    state_find(:,i+1)=fitted_data> threshold_y(i);
end
% 预设置矩阵保存每个状态的均值和标准差
state_mean = zeros(state_num,1);
state_std = state_mean;
for j=1:state_num
    a=fitted_data(state_find(:,j) == 1);
    state_mean(j) = mean(a);
    state_std(j) = std(a);
end
%计算步长
stepsize = diff(state_mean);
step_std = sqrt(state_std(1:(state_num-1)).^2 + state_std(2:state_num).^2);

%% 依据新的fitted data 作图看效果。
for k = 1:state_num
    fitted_data(state_find(:,k)==1)= state_mean(k);
end

plot((1:N)./sample_rate,data_z.*1000,(1:N)./sample_rate,fitted_data,'LineWidth',2);
xlabel('Time(min)');
ylabel('Ext.(nm)');
else
    fitted_data=0;
    stepsize=0;
    step_std=0;
    state_find=0;
    
end
