% multi data plot
% 该脚本用于将多组数据做在同一张图内，并进行一定的修饰，用于文献中呈现原始数据等。

%% 载入数据
% 准备工作，本部分只执行一次

i = 0;

%% 本部分每导入一次数据，手动运行一次
switch i
    case 0
        data_0 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_0 = linspace(force_min,force_max,N);
        time_0 = (1:N)./60;
        i=i+1;
    case 1
        data_1 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_1 = linspace(force_min,force_max,N);
         time_1 = (1:N)./60;
        i=i+1;
    case 2
        data_2 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_2 = linspace(force_min,force_max,N);
         time_2 = (1:N)./60;
        i=i+1;
    case 3
        data_3 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_3 = linspace(force_min,force_max,N);
         time_3 = (1:N)./60;
        i=i+1;
    case 4
        data_4 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_4 = linspace(force_min,force_max,N);
         time_4 = (1:N)./60;
        i=i+1;
    case 5
        data_5 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_5 = linspace(force_min,force_max,N);
         time_5 = (1:N)./60;
        i=i+1;
    case 6
        data_6 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_6 = linspace(force_min,force_max,N);
         time_6 = (1:N)./60;
        i=i+1;
    case 7
        data_7 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_7 = linspace(force_min,force_max,N);
         time_7 = (1:N)./60;
        i=i+1;
    case 8
        data_8 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_8 = linspace(force_min,force_max,N);
         time_8 = (1:N)./60;
        i=i+1;
    case 9
        data_9 = data_ramp+0.1*i;
        force_min = min(force_ramp);
        force_max = max(force_ramp);
        N = size(data_ramp,1);
        force_9 = linspace(force_min,force_max,N);
         time_9 = (1:N)./60;
        i=i+1;
    otherwise
        disp('need to add code');
end
%% 最终出图
figure;

subplot(2,1,1)
hold on
        plot(time_0(200:end),(data_0(200:end)+0.25)*1000);
        plot(time_1(200:end),data_1(200:end)*1000);
        plot(time_2(200:end),(data_2(200:end))*1000);
        plot(time_3(200:end),(data_3(200:end))*1000);
        plot(time_4(200:end),(data_4(200:end)-0.15)*1000);
        plot(time_5(200:end),(data_5(200:end)-0.15)*1000);
        plot(force_6,data_6*1000);
        plot(force_7,data_7*1000);
        plot(force_8,data_8*1000);
        plot(force_9,data_9*1000);
        ylabel('Ext.(nm)');
subplot(2,1,2)
plot(time_0(200:end),force_0(200:end));
ylabel('Force(pN)');
xlabel('Time(sec)');

% 对force ramp，首先将加载率的zmag数据替换成force。
