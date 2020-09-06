function [ dx_folded, dx_unfolded ] = barrier_calculate( lifetime )
%已知驻留时间，计算反应势垒 历史使命已完成，并入了dwell_time_analysis脚本，以后或许会被其他脚本调用，但输入参数的格式很蛋疼。
%   Detailed explanation goes here

%% 得到数据
dwelltime = lifetime';
time_folded = dwelltime(1,:);
time_unfolded = dwelltime(2,:);
time_force = dwelltime(3,:);
%% 对时间取对数，并做线性拟合 （最后没有输出常数项，似乎不准且不重要）
time_folded_ln = log(time_folded);
time_unfolded_ln = log(time_unfolded);
fit_folded = polyfit(time_force,time_folded_ln,1);
fit_unfolded = polyfit(time_force,time_unfolded_ln,1);
Kb_T = 1.3806504e-2*(26.0+273.15); 
dx_folded = fit_folded(1)*Kb_T;
dx_unfolded = fit_unfolded(1)*Kb_T;
%% 作图显示结果

time_force_s=time_force(1):0.01:time_force(end);
figure;
hold on
plot(time_force,time_folded_ln,'r','LineStyle','o');
plot(time_force_s,time_force_s.*fit_folded(1)+fit_folded(2),'r');
plot(time_force,time_unfolded_ln,'b','LineStyle','*');
plot(time_force_s,time_force_s.*fit_unfolded(1)+fit_unfolded(2),'b');
xlabel('Force / pN');
ylabel('ln(dwell_time) / s');
title('barrier_calculattion');

end

