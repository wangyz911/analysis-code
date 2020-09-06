function [ fitted_data,stepsize,step_std,state_num,dwell_time_mean,state_mean,good ] = step_modulation_multi( data_z,step_position,step_check,length_check)
% ��������������С��������step�ķ�������һЩ���䣬ͨ�����ȷ�ϵ����м���̨����ֵλ�����Ķ���Ȼ�������ͬһ��̬��Сstep����ֵ��ƽ���ͳ��ȵĵ��ӡ�
%�������ܣ����������data_z��ԭʼ���ݣ���������fitted_data
%����������step_position��step_detect�ĵ�һ�������
%���������stepsize��һ����������С��step����ͬ���������step�ĳ��ȣ�state_num��״̬����step_std�ǲ����ı�׼�
% ������ר�Ŷ�����������Ϊ�˴�����̬�������
%% �������ݣ���ͼ�������м���״̬����ֵλ��
% �˴���һ����̬���ã����step_positionֵΪ0������step_detect���ң�������ֳɵ�step_position,��ֱ�Ӳ���
if size(step_position,1) < 2
    step_position = J_search(data_z,0.7);
end
% ����step_position�����ó�ԭʼ���
step_info = get_step_info(data_z,step_position);
% fitted_data = get_fitted_data(data_z,step_position);
N = size(data_z,1);
% figure;
% plot(1:N,data_z,1:N,fitted_data,'LineWidth',2);
        %% ��Ư�Ƶ��µ�С��step�ϲ������������ɵļ��ϲ��˳���
        % �ҵ�Ư�Ƶ㣻
        % ���˵�stepsize �ر�С�����������䲢������̨��
        %�˴��� step_shift��ʵֻ�г�ʼ�����ж�ѭ�����������ã��ҵ�һ���͹��ˣ������ڻ��������ҡ�
        step_shift = find(abs(diff(step_info(:,2)))<=step_check, 1);
        while (~isempty(step_shift))
            [ step_position,~, step_shift ] = shift_cor( data_z, step_position, step_check ,length_check);
        end
                %�����������ͼ��Ϊѡֵ��׼��
        fitted_data_modi = get_fitted_data(data_z,step_position);
        fitted_data = fitted_data_modi.*1000;% ��λ����
        figure;
        plot((1:N)./12000,data_z.*1000,(1:N)./12000,fitted_data,'LineWidth',2);
        xlabel('Time(min)');
        ylabel('Ext.(nm)');
%% �ж��Ƿ�����ݣ��Ƿ���Ҫ����
disp('good data ?')
good = str2double(input('1 or 0','s'));
if good == 1
% ȷ�Ͻ��з�������ʼһ��������̨�׵�����
% ����һ��state_num ���ڼ����������е�����Ľ������
state_num = 1;
while (str2double(input('next?=','s')))    

state_find = zeros(size(fitted_data,1),100);
threshold_y_array = zeros(100,1);

[~,threshold_y] = ginput(1);
threshold_y_array(state_num) = threshold_y(1);
state_num = state_num + 1;
end
%% ������ֵ����data��ÿ���ֵ�data ��ֵ����ƽ�����õ�ÿ��̬��Ծ�Ĳ����ͱ�׼�
for i = 1:(state_num-1)
    if i==1
    state_find(:,i) = fitted_data < threshold_y_array(i);
    elseif i>1
        state_find(:,i)=fitted_data < threshold_y_array(i)&fitted_data > threshold_y_array(i-1);
    end
    state_find(:,i+1)=fitted_data> threshold_y_array(i);
end
% Ԥ���þ��󱣴�ÿ��״̬�ľ�ֵ�ͱ�׼��,��ƽ��פ��ʱ��
state_mean = zeros(state_num,1);
state_std = state_mean;
dwell_time_mean = state_mean;
for j=1:state_num
    a=fitted_data(state_find(:,j) == 1);
    state_mean(j) = mean(a);
    state_std(j) = std(a);
    % �������פ��ʱ��
    % ����ȡ��p��̨�׵�����
    b=find(state_find(:,j) == 1);
    seg_start = find(diff(b) == 1);
    % diff �ж����ȱ�ٵ�һ�����˹�����
    seg_start = [0;seg_start];
    seg_end = find(diff(b)==-1);
    % �����յ��ȥ��㣬�õ�פ��ʱ��֡��������200�õ��������Ժ�Ҫ�����ֲ��Ļ�dwell_time_arrayҲ���Ըĳ���
    dwell_time_array = (seg_end-seg_start)./200;

    dwell_time_mean(j) = mean(dwell_time_array);
end
%���㲽��
stepsize = diff(state_mean);
step_std = sqrt(state_std(1:(state_num-1)).^2 + state_std(2:state_num).^2);



%% �����µ�fitted data ��ͼ��Ч����
for k = 1:state_num
    fitted_data(state_find(:,k)==1)= state_mean(k);
end;


plot((1:N)./12000,data_z.*1000,(1:N)./12000,fitted_data,'LineWidth',2);
xlabel('Time(min)');
ylabel('Ext.(nm)');
else
    fitted_data=0;
    stepsize=0;
    step_std=0;
    state_find=0;
    
end
