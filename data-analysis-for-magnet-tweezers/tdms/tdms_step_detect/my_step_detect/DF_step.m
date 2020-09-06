function [good_step_loc,Fit,step,dwell_time] = DF_step(data_step,delta_i)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

    data_denoised = wdenoise(data_step,5, ...
        'Wavelet', 'sym6', ...
        'DenoisingMethod', 'Bayes', ...
        'ThresholdRule', 'Soft', ...
        'NoiseEstimate', 'LevelIndependent');
% delta_i = 25;
%for each segment separate
    neighbour_dif=zeros(length(data_step)-1,1);


                  %for each segment separate
        for i=delta_i:length(data_denoised)-delta_i  %Pick_a_Segment;
            neighbour_dif(i)=(median(data_denoised(i:i+delta_i))-median(data_denoised((i-delta_i+1):i))); % 只有用减法，才能对上关键的跳跃点，否则会有delta_i的错位
        end
%         nei_dif2 = zeros(length(neighbour_dif)-1,1);
%         for i=delta_i:length(data_denoised)  %Pick_a_Segment;
%             nei_dif2(i)=neighbour_dif(i)-neighbour_dif(i-delta_i+1); % 只有用减法，才能对上关键的跳跃点，否则会有delta_i的错位
%         end
[~,good_step_loc] = findpeaks(abs(neighbour_dif),'MinPeakDistance',delta_i,'MinPeakProminence',2*mean(abs(neighbour_dif)),'MinPeakHeight',median(abs(neighbour_dif)));

good_step_loc = [0;good_step_loc;length(data_denoised)];
le = length(good_step_loc);

Fit_val = zeros(le,1);
for j = 1:le-1
    Fit_val(j)=median(data_step((good_step_loc(j)+1):good_step_loc(j+1)));
end
Fit_val(end)=0;
step = zeros(le,1);
step(1) = 0;
step(end) = 0;
step(2:end-1) = abs(diff(Fit_val(1:end-1)));
dwell_time = zeros(le,1);
dwell_time(1:end-1) = diff(good_step_loc);
dwell_time(end) = 0;

%% 下面是合并过小的step环节
step_check = max(step)*0.15; % 步长检查，小于最大步长的百分之20
% step_check = 0; % 步长检查，小于最大步长的百分之20
step_shift1 = find(step>0);
step_shift2=find(step<=step_check);
step_shift = intersect(step_shift1,step_shift2);

while( ~isempty(step_shift))
    N =length(step_shift);
    for i = 1:N
        %         if i<3  % 计算中用到i-2，小于3算不了
        %             continue;
        %         end
        temp = (Fit_val(step_shift(i))*dwell_time(step_shift(i))+ Fit_val(step_shift(i)-1)*dwell_time(step_shift(i)-1))/sum(dwell_time((step_shift(i)-1):step_shift(i)));%两个台阶合并，主要是统计计算出fit值
        Fit_val(step_shift(i)-1) = temp;
        dwell_time(step_shift(i)-1) = dwell_time(step_shift(i)-1)+dwell_time(step_shift(i)); %计算出fit值后，将台阶长度加和
        if step_shift(i)<3
            step(step_shift(i)-1)=0;
        else
            step(step_shift(i)-1) = abs(Fit_val(step_shift(i)-1)-Fit_val(step_shift(i)-2)); % 合并后fit(i)=fit(i+1)，直接拿来用了
        end
        if step_shift(i)<length(step)-1 % 如果不是末端就计算另一边的点，否则就不算了，保持为0,-1是因为数组都和good step loc保持一致了，所以长度-1的位置就已经是最后一个台阶了
            step(step_shift(i)+1) = abs(Fit_val(step_shift(i)+1)-Fit_val(step_shift(i)-1)); %台阶合并后新台阶的高度变化了，需要修复两侧的step值
        end
        
    end
    good_step_loc(step_shift) = [];
    Fit_val(step_shift) = [];
    step(step_shift) = [];
    dwell_time(step_shift) =[];
    step_shift1 = find(step>0);
    step_shift2=find(step<=step_check);
    step_shift = intersect(step_shift1,step_shift2);
end



% 依据当前台阶位置进行data的fit
le = length(good_step_loc);
Fit = zeros(length(data_denoised),1);
for k=1:le-1
    Fit(good_step_loc(k)+1:good_step_loc(k+1))=median(data_step(good_step_loc(k)+1:good_step_loc(k+1)));
end

%% 画出拟合图和步长分布
figure;
Step_hist=histogram(step*1000);
step_hist_bin = Step_hist.BinEdges(1:end-1)+Step_hist.BinWidth/2;
step_hist_val = Step_hist.Values;

figure;
subplot(1,2,1);
hold on;
title('Reconstructed steps','FontSize',8)
time = (1:length(data_step))./100;
plot(time,data_step*1000,'MarkerSize',4,'Marker','.',...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
plot(time, Fit*1000,'LineWidth',2,'Color',[1 0 0]);
xlabel('Time/s');ylabel('Ext./nm');
axes1 = gca;

% 设置坐标刻度外翻
set(axes1,'TickDir','out');
% 设置其余坐标区属性
set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
hold off
subplot(1,2,2);
title('Histogram of all steps: green; fast steps: red','FontSize',8)
%     bar(Bins, Step_hist_all, 'g');
bar( step_hist_bin,step_hist_val, 'g');
axes1 = gca;
% 设置坐标刻度外翻
set(axes1,'TickDir','out');
% 设置其余坐标区属性
set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
hold off

end




