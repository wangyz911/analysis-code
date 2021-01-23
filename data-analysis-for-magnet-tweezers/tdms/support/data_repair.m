function [data_repair] = data_repair(data_ramp,fit_func)
%本函数用于修复一些曲线测量中意外造成的漂移
N = size(data_ramp,1);
t = (1:N);
t = t';
% disp('是否修复 force ramp 曲线？')
% yes_ramp = input('是或者否','s');
% if yes_ramp == '1'
%首先输入数据并画图显示，询问是否要进行修复

    if fit_func==3
    % 使用幂函数要比使用线性拟合要更符合走势，更平滑，而且很线性的时候也可以自然趋近，比对数函数限制少，好拟合。
    % 幂函数在接近0处衰减的很厉害，不适用于推断起点附近的状态
%     f = @(c,x)c(1)*x.^(1/c(2))+c(3);
%     c0=[1,6,0];
    f = @(c,x)c(1)*x+c(2);
    c0=[1,0];
    data_sm = smooth(data_ramp,400);% 平滑的点越多效果越好，不会影响数据原本的波动,但是在首位少于1000点时会有比较明显的拖尾效应。
    elseif fit_func==1
    f = @(c,x)c(1)*x+c(2);
    c0=[1,0];
    data_sm = smooth(data_ramp,2000);% 平滑的点越多效果越好，不会影响数据原本的波动,但是在首位少于1000点时会有比较明显的拖尾效应。
    elseif fit_func==4               % 特殊情况自定义平滑点数。
    f = @(c,x)c(1)*x+c(2);
    c0=[1,0];
    point_sm = str2double(input("enter the smooth number: ",'s'));
    data_sm = smooth(data_ramp,point_sm);
    elseif fit_func ==2
           f = @(c,x)c(1)*x+c(2);
           c0=[1,0];
           data_sm = wdenoise(data_ramp,6, ...
    'Wavelet', 'sym4', ...
    'DenoisingMethod', 'BlockJS', ...
    'ThresholdRule', 'James-Stein', ...
    'NoiseEstimate', 'LevelIndependent');% 平滑的点越多效果越好，不会影响数据原本的波动,但是在首位少于1000点时会有比较明显的拖尾效应。

    end





figure;
plot(t,data_ramp*1000,'MarkerSize',4,'Marker','.',...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
hold on
% data_sm = smooth(data_ramp,2000);% 平滑的点越多效果越好，不会影响数据原本的波动,但是在首位少于1000点时会有比较明显的拖尾效应。
plot(t,data_sm*1000,'LineWidth',2,'Color',[1 0 0]);
xlabel('Time/s)');ylabel('Ext./nm');

input('按任意键开始选择基准区间','s');
    
    [base_start,~]=ginput(1);
    base_start=floor(base_start);
    if base_start<1
        base_start=1;
    end
    
    [base_end,~]=ginput(1);                                          %鼠标取点设置断点  ？
    base_end=floor(base_end);                                          %向下取整
    if base_end > N
        base_end = N;
    end

    x = t(base_start:base_end);
    y = data_sm(base_start:base_end);
    

        base_fit=nlinfit(x,y,f,c0);
    % 基于基线计算修复值；
    input('按任意键开始选择修复区间','s');
    
        [rep_start,~]=ginput(1);
    rep_start=floor(rep_start);
    if rep_start<1
        rep_start=1;
    end
    
    [rep_end,~]=ginput(1);                                          %鼠标取点设置断点  ？
    rep_end=floor(rep_end);                                          %向下取整
    if rep_end > N
        rep_end = N;
    end
    base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% if fit_func==3
% %     base_rep = base_fit(1).*(t(rep_start:rep_end)).^(1/base_fit(2))+base_fit(3);
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% elseif fit_func==1
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% elseif fit_func ==2
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% end
    data_ramp(rep_start:rep_end) = data_ramp(rep_start:rep_end)-data_sm(rep_start:rep_end)+base_rep;
   %将修复区的前后对齐。对齐的设计非常巧妙，得意之作

   dif_start = base_rep(1)-data_sm(rep_start);
   dif_end = base_rep(end)-data_sm(rep_end);
   data_ramp(1:(rep_start-1)) = data_ramp(1:(rep_start-1))+dif_start;
   data_ramp((rep_end+1):end) = data_ramp((rep_end+1):end)+dif_end;
% end

data_repair = data_ramp;
% figure;
% plot(t,data_repair);
end

