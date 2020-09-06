%
% % 先把累计步长坐标算出来
% dwell_time_mean = dwell_time_result(:,2);
% dwell_time_count = dwell_time_result(:,3);
% step = dwell_time_result(:,4);
% step_std = dwell_time_result(:,5);
% N = size(dwell_time_result,1);
% step_accu = zeros(N,1);
% for i = 1:N
%     step_accu(i) = sum(step(1:i));
% end
% % dominated_time = dwell_time_mean.*dwell_time_count;
% % step_nc = round(step_accu/60);
% % plot(step_accu,dominated_time,'Marker','o');
% % hold on
% % plot(step_accu,dwell_time_mean,'Marker','o');
%
% % % 计算从某个台阶往上走一个台阶和往下走一个台阶的次数；
% % down_count = zeros(N,1);
% % up_count = zeros(N,1);
% % for i = 1:N
% %     if  i==1
% %         down_count(i) = 0;
% %         up_count(i) = dwell_time_count(i);
% %     elseif i==N
% %         down_count(i) = dwell_time_count(i)-1;
% %         up_count(i) = 0;
% %     else
% %        down_count(i) = up_count(i-1)-1;
% %        up_count(i) =  dwell_time_count(i)-down_count(i);
% %     end
% % end
%
% % 准依据每个态的平均驻留时间画个能谱图
% dwell_time_mean_index = round(dwell_time_mean*1000);
% step_map = zeros(sum(dwell_time_mean_index),1);
% start = 1;
% for i = 1:size(dwell_time_mean_index);
%     step_map(start:(start+dwell_time_mean_index(i)-1)) = step_accu(i);
%     start = dwell_time_mean_index(i)+start;
% end
% hold on
% plot(step_map,'Marker','o');
%
%
% %% 把往返轨迹画在一个图中，以观察稳定态。
% figure;
% hold on
% data_ramp = data_ramp - min(data_ramp);
% N  = 1:size(data_ramp,1);
% N = N;
% data_ramp = data_ramp;
% plot(N,data_ramp,'Marker','.','MarkerSize',6);






%%  比较细节专用

%  接下来需要根据磁铁位置的信息将数据基本上对齐，最好保证Y轴上最高点对齐，X轴上好像没啥办法，保证最高点的XY值对齐吧。
LimX = 10000;
LimY = 2000; % 这里设置一个常数，看具体图像的值来人工设定


if forward ==0
%     data_ramp = flipud(data_ramp);
%     zmag_ramp = flipud(zmag_ramp);
    N = size(data_ramp,1);
    
    data_ramp = data_ramp - min(data_ramp) ;
    frame = (1:N);
    plot(frame,data_ramp,'Marker','.','MarkerSize',6);
    
else
    N = size(data_ramp,1);
    maxY = mean(data_ramp(zmag_ramp==max(zmag_ramp)));
    data_ramp = data_ramp-min(data_ramp)-32.6;
    frame = (1:N);
    plot(frame,data_ramp,'Marker','.','MarkerSize',6);
end

hold on
ylabel('Ext. (nm)')

% N = 1:size(ans2,1);
% plot(N+7560,ans2(:,2));
% hold on
% plot(ans3(:,2));



%% 数据分析部分 本部分按照步长排了个类似电泳的阶梯，用于判断哪些态是稳定的。
forward_data = zeros(1,1);
reverse_data = zeros(1,1);

step = size(forward_data,1);
tra_num = size(forward_data,2);
forward_accu = zeros(size(forward_data));
accu_plot = ones(100*size(forward_accu,1),size(forward_accu,2));

for i = 1:tra_num
    accu = 0;
    for j = 1:step
        accu = accu+forward_data(j,i);
        forward_accu(j,i) = accu;
        accu_plot(((j-1)*100+1):j*100,i) = accu_plot(((j-1)*100+1):j*100,i)*accu;
    end
end

for i = 1:tra_num
    for j = 1:step
        plot (((i-1)*100+1):(i*100),accu_plot(((j-1)*100+1):j*100,i),'.');
        hold on
    end
end

    
 %% 截取部分数据来做直方图分析。
 % F2_1;F2_2;F2_3;F2_4;F2_5;F2_6;F2_7 s7;s8;s9;s10
data4F = [ssss1];
data4F_s = data4F(:,2);
figure;
createFit_mecp2(data4F_s);

%%  多个直方图合成一个，已成功
h1 = openfig('wild type.fig','reuse');  
ax1 = gca;  
h2 = openfig('R106W_FE.fig','reuse'); % open figure  
ax2 = gca; % get handle to axes of figure  
h3 = openfig('3F.fig','reuse');  
ax3 = gca;  
h4 = openfig('4F.fig','reuse');  
ax4 = gca;  

h7 = figure; %create new figure  
 s1 = subplot(2,1,1); %create and get handle to the subplot axes  
s2 = subplot(2,1,2);  
s3 = subplot(3,1,2); %create and get handle to the subplot axes  
s4 = subplot(3,1,3); 

fig1 = get(ax1,'children'); %get handle to all the children in the figure  
fig2 = get(ax2,'children');  
fig3 = get(ax3,'children'); %get handle to all the children in the figure  
fig4 = get(ax4,'children');  

copyobj(fig1,s1); %copy children to new parent axes i.e. the subplot axes  
copyobj(fig2,s2);  
copyobj(fig3,s3); %copy children to new parent axes i.e. the subplot axes  
copyobj(fig4,s4);  

xlabel('Force/pN');
ylabel('Ext./nm');


%% 具体分析展开中100步长的细节
% 首先从轨迹图中抠出step 细节，然后将每个数据都值都归到同一高度。
    m333_1 = m333_1 - min(m333_1);
    m333_2= m333_2 - min(m333_2);
    m333_3 = m333_3 - min(m333_3);
    m333_4 = m333_4 - min(m333_4);
    m333_5 = m333_5 - min(m333_5);
    m333_6 = m333_6 - min(m333_6);
    m333_7 = m333_7 - min(m333_7);
    m333_8 = m333_8 - min(m333_8);
    m333_9 = m333_9 - min(m333_9);
    m333_10 = m333_10 - min(m333_10);
    m333_11 = m333_11 - min(m333_11);
    
big_sum = [m333_1;m333_2;m333_3;m333_4;m333_5;m333_6;m333_7;m333_8;m333_9;m333_10;m333_11];
m333_sum = big_sum(:,2);

    m37_1 = m37_1 - min(m37_1);
    m37_2= m37_2 - min(m37_2);
    m37_3 = m37_3 - min(m37_3);
    m37_4 = m37_4 - min(m37_4);
    m37_5 = m37_5 - min(m37_5);
    m37_6 = m37_6 - min(m37_6);
    m37_7 = m37_7 - min(m37_7);
    m37_8 = m37_8 - min(m37_8);
    m37_9 = m37_9 - min(m37_9);
    m37_10 = m37_10 - min(m37_10);
    m37_11 = m37_11 - min(m37_11);
    m37_12 = m37_12 - min(m37_12);
    m37_13 = m37_13 - min(m37_13);
    m37_14 = m37_14 - min(m37_14);
    m37_15 = m37_15 - min(m37_15);
%     m37_16 = m37_16 - min(m37_16);
%     m37_17 = m37_17 - min(m37_17);
    m37_18 = m37_18 - min(m37_18);
    m37_19 = m37_19 - min(m37_19);
    m37_20 = m37_20 - min(m37_20);
    m37_21 = m37_21 - min(m37_21);
    m37_22 = m37_22 - min(m37_22);
    m37_23 = m37_23 - min(m37_23);
    m37_24 = m37_24 - min(m37_24);
    m37_25 = m37_25 - min(m37_25);
    m37_26 = m37_26 - min(m37_26);
    m37_27 = m37_27 - min(m37_27);
    m37_28 = m37_28 - min(m37_28);
    m37_29 = m37_29 - min(m37_29);
    m37_30 = m37_30 - min(m37_30);
m37_sum = [m37_1;m37_2;m37_3;m37_4;m37_5;m37_6;m37_7;m37_8;m37_9;m37_10;...
           m37_11;m37_12;m37_13;m37_14;m37_15;m37_18;m37_19;m37_20;...
           m37_21;m37_22;m37_23;m37_24;m37_25;m37_26;m37_27;m37_28;m37_29;m37_30;];
m37_step = m37_sum(:,2);
med_m37 = medfilt1(m37_step,3);
    
    m22_1 = m22_1 - min(m22_1);
    m22_2= m22_2 - min(m22_2);
    m22_3 = m22_3 - min(m22_3);
    m22_4 = m22_4 - min(m22_4);
    m22_sum = [m22_1;m22_3;m22_4];
    m22_step = m22_sum(:,2);
    
%% T检验测试
x = zeros(1);
y  = zeros(1);
[H,P,CI]=ttest2(x,y)
  
ext_t1 = ext_t1-0.05;

%% 展开力值分析
wt_t1 = [];
