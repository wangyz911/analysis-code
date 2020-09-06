%% 对得到的数据进行滤波处理，并分类进行指数拟合
data_d=sigDEN(data');

%设定区分跳跃的中间阈值
 threshold=(max(data_d)+min(data_d))/2;
 %预设一个矩阵来计数,利用阈值粗略地分类
count=data_d-threshold;
count=medfilt1(count,20);
up=find(count>0);
count(up)=1;
down=find(count<=0);
count(down)=-1;
%利用中值滤波抹平噪声造成的干扰
step=medfilt1(count,10);
%利用错位相乘,找到上升沿/下降沿，由于中值滤波的关系，上升/下降沿处乘积为0；
m=size(step,2)+1;
edge=zeros(m,1)';

for n=2:(m-1);
    edge(n-1)=step(n)*step(n-1);
end 
%找到值为0的点（都是成对出现），每隔一个依次相减，得到上下两个态的驻留时间
change=find(edge==0);
i=size(change,2);
dwell_time_up=zeros(i/2,1)';
dwell_time_down=zeros(i/2,1)';
j=1;%第一个点已经在循环外计算了
% %由于起点处没有0，第一个驻留时间直接用第一个change的值,第一段截取过不完整，不要了
% dwell_time_up(1)=change(1);

for k=3:4:(size(change,2)-2)
        dwell_time_up(j)=change(k+2)-change(k);
            j=j+1;
end
j=1;
for k=1:4:(size(change,2)-2)
        dwell_time_down(j)=change(k+2)-change(k);
            j=j+1;
end
%以上情况考虑的是起点为上升沿，如果起点是下降沿，那么将原本上下的驻留时间对调即可。
if step(5)==-1
    interchange=dwell_time_up;
    dwell_time_up=dwell_time_down;
    dwell_time_down=interchange;
end
%删除为dwell time中为零的部分，以免影响分布。
cut=find(dwell_time_up,1,'last');
dwell_time_up((cut+1):end) = [];
cut=find(dwell_time_down,1,'last');                                        %除掉为零的部分不要
dwell_time_down((cut+1):end) = [];
dwell_time_up=dwell_time_up./60;
dwell_time_down=dwell_time_down./60;
%对两个分布进行拟合
figure;                                                                    %拟合要做直方图，先预置一个图出来，免得覆盖其他图像。
[dwell_time_fit_down,dwell_time_fit_up]=createFit(dwell_time_down,dwell_time_up);

figure;
plot(edge+0.5);
hold on
plot(data);
% plot(step);
axis([0 35000 -2 3]);
