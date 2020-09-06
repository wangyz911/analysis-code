function [good_step_loc,Fit,step,dwell_time] = DF_step(data_step,delta_i)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

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
            neighbour_dif(i)=(median(data_denoised(i:i+delta_i))-median(data_denoised((i-delta_i+1):i))); % ֻ���ü��������ܶ��Ϲؼ�����Ծ�㣬�������delta_i�Ĵ�λ
        end
%         nei_dif2 = zeros(length(neighbour_dif)-1,1);
%         for i=delta_i:length(data_denoised)  %Pick_a_Segment;
%             nei_dif2(i)=neighbour_dif(i)-neighbour_dif(i-delta_i+1); % ֻ���ü��������ܶ��Ϲؼ�����Ծ�㣬�������delta_i�Ĵ�λ
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

%% �����Ǻϲ���С��step����
step_check = max(step)*0.15; % ������飬С����󲽳��İٷ�֮20
% step_check = 0; % ������飬С����󲽳��İٷ�֮20
step_shift1 = find(step>0);
step_shift2=find(step<=step_check);
step_shift = intersect(step_shift1,step_shift2);

while( ~isempty(step_shift))
    N =length(step_shift);
    for i = 1:N
        %         if i<3  % �������õ�i-2��С��3�㲻��
        %             continue;
        %         end
        temp = (Fit_val(step_shift(i))*dwell_time(step_shift(i))+ Fit_val(step_shift(i)-1)*dwell_time(step_shift(i)-1))/sum(dwell_time((step_shift(i)-1):step_shift(i)));%����̨�׺ϲ�����Ҫ��ͳ�Ƽ����fitֵ
        Fit_val(step_shift(i)-1) = temp;
        dwell_time(step_shift(i)-1) = dwell_time(step_shift(i)-1)+dwell_time(step_shift(i)); %�����fitֵ�󣬽�̨�׳��ȼӺ�
        if step_shift(i)<3
            step(step_shift(i)-1)=0;
        else
            step(step_shift(i)-1) = abs(Fit_val(step_shift(i)-1)-Fit_val(step_shift(i)-2)); % �ϲ���fit(i)=fit(i+1)��ֱ����������
        end
        if step_shift(i)<length(step)-1 % �������ĩ�˾ͼ�����һ�ߵĵ㣬����Ͳ����ˣ�����Ϊ0,-1����Ϊ���鶼��good step loc����һ���ˣ����Գ���-1��λ�þ��Ѿ������һ��̨����
            step(step_shift(i)+1) = abs(Fit_val(step_shift(i)+1)-Fit_val(step_shift(i)-1)); %̨�׺ϲ�����̨�׵ĸ߶ȱ仯�ˣ���Ҫ�޸������stepֵ
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



% ���ݵ�ǰ̨��λ�ý���data��fit
le = length(good_step_loc);
Fit = zeros(length(data_denoised),1);
for k=1:le-1
    Fit(good_step_loc(k)+1:good_step_loc(k+1))=median(data_step(good_step_loc(k)+1:good_step_loc(k+1)));
end

%% �������ͼ�Ͳ����ֲ�
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

% ��������̶��ⷭ
set(axes1,'TickDir','out');
% ������������������
set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
hold off
subplot(1,2,2);
title('Histogram of all steps: green; fast steps: red','FontSize',8)
%     bar(Bins, Step_hist_all, 'g');
bar( step_hist_bin,step_hist_val, 'g');
axes1 = gca;
% ��������̶��ⷭ
set(axes1,'TickDir','out');
% ������������������
set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
hold off

end




