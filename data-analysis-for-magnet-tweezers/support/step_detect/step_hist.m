function [ step_hist,step_fit_down,step_fit_mid,step_fit_up ] = step_hist( fitted_data,step_info )
%已经初步拟合出了step，需要统计处于折叠态和展开态的驻留时间分布

%导入数据，预设置时间序列,作图
time_se = 1:size(fitted_data,1);
figure;
plot(time_se,fitted_data);
%根据拟合图判断有多少个态，然后在图上标定出阈值，注意阈值从上往下标定
disp('how many threshold ?')
state_number = str2double(input('number = ','s'));
threshold_number = state_number-1;
    [~,threshold_y] = ginput(threshold_number);
%预设置结果矩阵，N行两列，第一列为up态，依列序号逐级往下
step_hist = zeros(size(step_info,1),state_number);
%逐个step判定，并将台阶长度归类到预设结果矩阵
if state_number == 2
    %两态的情况，如果台阶高于阈值，将该台阶的长度放入up列1，否则放入down列2
    for i = 1:size(step_info,1)
    if step_info(i,2) >threshold_y(1,1)
        step_hist(i,1) = step_info(i,1);
    else step_hist(i,2) = step_info(i,1);
    end
    end
    step_hist = step_hist./60;
    step_up = step_hist(:,1);
    step_up(step_up == 0) = [];
   
    step_down = step_hist(:,2);
    step_down(step_down == 0) = [];
    %做指数拟合
    figure;                                                                    %拟合要做直方图，先预置一个图出来，免得覆盖其他图像。
[step_fit_down,step_fit_up]=createFit(step_down,step_up);
%二态情况下中间态直接缺省为0
step_fit_mid = 0;

elseif state_number == 3
    %三态情况，如果台阶高于阈值1，将其长度放入up列1，如果不高于1，高于阈值2，放入middle列2，否则放入down列3
    for i = 1:size(step_info,1)
    if step_info(i,2) >threshold_y(1,1)
        step_hist(i,1) = step_info(i,1);
    elseif step_info(i,2) > threshold_y(1,2)
        step_hist(i,2) = step_info(i,1);
    else step_hist(i,3) = step_info(i,1);
    end
    end
    step_hist = step_hist./60;
    step_up = step_hist(:,1);
    step_up(step_up == 0) = [];
    step_mid = step_hist(:,2);
    step_mid(step_up == 0) = [];
   
    step_down = step_hist(:,3);
    step_down(step_down == 0) = [];
    %做三个态的指数拟合
    figure;                                                                    %拟合要做直方图，先预置一个图出来，免得覆盖其他图像。
    [step_fit_down,step_fit_mid,step_fit_up]=createFit(step_down,step_mid,step_up);
else
    disp('臣妾做不到啊');
end

end

