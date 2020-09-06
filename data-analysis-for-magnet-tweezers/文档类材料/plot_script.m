%本脚本是文献绘图专用脚本，比较杂乱，分段执行,使用时请注释掉其他功能模块，避免变量重名。

%% 作两个展开的lnK vs F 对比图
k_unfold1 = dwell_time_curve(:,5);
k_fold1 = dwell_time_curve(:,6);
F1 = dwell_time_curve(:,3);
lnK1 = log(k_unfold1./k_fold1);
fit1 = polyfit(F1,lnK1,1);
K1 = exp(lnK1);
err1 = 0.05*F1;


k_unfold2 = dwell_time_curve(:,5);
k_fold2 = dwell_time_curve(:,6);
F2 = dwell_time_curve(:,3);
lnK2 = log(k_unfold2./k_fold2);
fit2 = polyfit(F2,lnK2,1);
K2 = exp(lnK2);
% 误差部分
err2 = 0.05*F2;

force = 0:15;
    figure;
    hold on;
    errorbar(K1,F1,err1,'*');
    semilogx(exp(polyval(fit1,force)),force,'b');
    errorbar(K2,F2,err2,'o');
    semilogx(exp(polyval(fit2,force)),force,'r');

    xlabel('K');
    ylabel('Force(pN)');
    view(90,-90);
    legend('unfold 1','fit 1','unfold 2','fit 2');
    hold off;
%% 作一个展开的kf and ku vs F 对比图
k_unfold1 = dwell_time_curve(:,5);
k_fold1 = dwell_time_curve(:,6);
F1 = dwell_time_curve(:,3);

fit1 = polyfit(F1,log(k_unfold1),1);
fit2 = polyfit(F1,log(k_fold1),1);
err1 = 0.05*F1;

force = 0:0.1:15;
    figure;
    semilogx(exp(polyval(fit1,force)),force,'b');
    hold on;
    errorbar(k_unfold1,F1,err1,'*');
    semilogx(exp(polyval(fit2,force)),force,'r');
    errorbar(k_fold1,F1,err1,'o');


    xlabel('k(s^{-1})');
    ylabel('Force(pN)');
    view(90,-90);
%     legend('unfold 1','fit 1','unfold 2','fit 2');
%     hold off;    
%% 画原始数据图及其局部放大图像。
% %先载入局部放大的数据
% %然后修正横坐标单位
% frame = 1:size(data_z,1);
% time = frame./60;
% figure;
% plot(time,data_z-0.5,'LineWidth',1);
% hold on 
% plot(time,data_d-0.5,'LineWidth',2);
% xlabel('time/s');
% ylabel('extension/μm')
% title('F = 6.38pN');

%% 画多个并列的图，配上可能的展开模型
figure;
%fig1
subplot(3,1,1);
data1 = data_z(:,1);
time1 = (1:size(data1,1))./3600;
plot(time1,data1,'k');
hold on 
plot(time1,sigDEN(data1),'r');
ylabel('Extension/μm');
title('F = 8.4pN')
%fig2
subplot(3,1,2);
data2 = data_z(:,1);
time2 = (1:size(data2,1))./3600;
plot(time2,data2,'k');
hold on 
plot(time2,sigDEN(data2),'r');
ylabel('Extension/μm');
title('F = 9.2pN')
%fig3
subplot(3,1,3);
data3 = data_z(:,1);
time3 = (1:size(data3,1))./3600;
plot(time3,data3,'k');
hold on 
plot(time3,sigDEN(data3),'r');
ylabel('Extension/μm');
title('F=10.0pN')
%fig4
subplot(4,1,4);
data4 = data_z(:,1);
time4 = (1:size(data4,1))./3600;
plot(time4,data4,'k');
hold on 
plot(time4,sigDEN5(data4),'r');
ylabel('Ext.(μm)');
xlabel('Time(min)');

%% 画两种展开模式的反应速率图
% 展开速率
% 先得到原始数据
%展开1 
% k_unfold1_log = log(dwell_time_curve(:,5));
% k_fold1_log = log(dwell_time_curve(:,6));
% F1 = dwell_time_curve(:,3);
% 
% fit1_unfold = polyfit(F1,k_unfold1_log,1);
% fit1_fold = polyfit(F1,k_fold1_log,1);
% %展开2
% k_unfold2_log = log(dwell_time_curve(:,5));
% k_fold2_log = log(dwell_time_curve(:,6));
% F2 = dwell_time_curve(:,3);
% 
% fit2_unfold = polyfit(F2,k_unfold2_log,1);
% fit2_fold = polyfit(F2,k_fold2_log,1);
% % 按需要分别作图
% %展开速率比较
%     figure;
%     hold on;
%     plot(F1,k_unfold1_log,'*');
%     plot(F1,polyval(fit1_unfold,F1),'b');
%     plot(F2,k_unfold2_log,'o');
%     plot(F2,polyval(fit2_unfold,F2),'r');
% 
%     ylabel('unfolding rate');
%     xlabel('force/pN');
%     legend('unfold 1','fit 1','unfold 2','fit 2');

%% 将origin 中的hist拟合转到matlab中来画，比较方便统一格式。
%首先提取直方图和线的信息。
% bin_center = 0;
% frequency = 0;
% fit_curve_x = 0;
% fit_curve_sum = 0;
% fit_curve_sum_x=0;
% fit_curve_1 = 0;
% fit_curve_2 = 0;
% er = 0;
% er_x = 0;
% er_y = 0;
figure;
hold on
bar(bin_center,frequency);
plot(fit_curve_sum_x,fit_curve_sum);
plot(fit_curve_x,fit_curve_1);
plot(fit_curve_x,fit_curve_2);
errorbar(er_x,er_y,er);
xlabel('Force(pN)');
ylabel('Probability');

%% 将若干个2维的图画成3维来显示
%% 1、准备工作，本部分只执行一次
figure;
hold on
i = 0;
% 设置力值，count，ext的存放矩阵

%% 2、本部分每导入一次数据，手动运行一次，不做shift处理，如果做shift处理，data加上0.1*i
switch i
    case 0
        data_0 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_0 = linspace(force_min,force_max,N);
        count_0 = ones(1,N)*i;
        i=i+1;
    case 1
        data_1 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_1 = linspace(force_min,force_max,N);
        count_1 = ones(1,N)*i;
        i=i+1;
    case 2
        data_2 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_2 = linspace(force_min,force_max,N);
        count_2 = ones(1,N)*i;
        i=i+1;
    case 3
        data_3 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_3 = linspace(force_min,force_max,N);
        count_3 = ones(1,N)*i;
        i=i+1;
    case 4
        data_4 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_4 = linspace(force_min,force_max,N);
        count_4 = ones(1,N)*i;
        i=i+1;
    case 5
        data_5 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_5 = linspace(force_min,force_max,N);
        count_5 = ones(1,N)*i;
        i=i+1;
    case 6
        data_6 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_6 = linspace(force_min,force_max,N);
        count_6 = ones(1,N)*i;
        i=i+1;
    case 7
        data_7 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_7 = linspace(force_min,force_max,N);
        count_7 = ones(1,N)*i;
        i=i+1;
    case 8
        data_8 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_8 = linspace(force_min,force_max,N);
        count_8 = ones(1,N)*i;
        i=i+1;
    case 9
        data_9 = data_ramp;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_9 = linspace(force_min,force_max,N);
        count_9 = ones(1,N)*i;
        i=i+1;
    otherwise
        disp('need to add code');
end
%%  3、最终出图

        plot3(force_0,count_0,data_0*1000);
        hold on
        plot3(force_1,count_1,data_1*1000);
        plot3(force_2,count_2,data_2*1000);
        plot3(force_3,count_3,data_3*1000);
        plot3(force_4,count_4,data_4*1000);
        plot(force_5,data_5*1000);
        plot(force_6,data_6*1000);
        plot(force_7,data_7*1000);
        plot(force_8,data_8*1000);
        plot(force_9,data_9*1000);
ylabel('Ext.(nm)');
xlabel('Force(pN)');
title('First unfolding');
title('Second unfolding');
        
% 对force ramp，首先将加载率的zmag数据替换成force。
%% 画一个替代的bar
hold on
x = [0.5,1.5,2.5,3.5,4.5,5.5];
y = [0.6615,0.3554,0.1635,0.0487,0.0233,0.0374];
bar(x,y);
