function [ k_unfold,k_mid,k_fold,time_domination,dwell_time_down,dwell_time_mid,dwell_time_up,Fit_modi ] = tdms_dwell_time_count( ~,fitted_data_modi,sample_rate )
%���������ڽ���step����ϣ����ˣ�פ��ʱ���ͳ�ƣ������ո���פ��ʱ���ָ�����ͼ�������ʱ�䣬�����ڶ�̬ͳ�ơ�
%ʹ��ʱ����ʵ������޸�stepcheck��length_check�Ĵ�С��
%% �Եõ������ݽ����˲��������������ָ�����
%�趨����
% N = size(data_z,1);
% %% ��ʼʹ�ö��ַ��������õ�ȫ�����ŵ�J
% 
% % ������ֳɵ�step_position���Ͳ��ü����ˡ�
% if size(step_position,1) < 2
%     step_position = J_search(data_z,0.3);
% end
% % �����ҵ���stepλ�õõ��������
% step_info = get_step_info(data_z,step_position);
% % fitted_data = get_fitted_data(data_z,step_position);
% % figure;
% % plot(1:N,data_z,1:N,fitted_data,'LineWidth',2);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%�˳�ֻ�м������Ծ�䣬��Ϊ�����ͳһ���ƣ�����������ʱ����Ҫ�ˡ�
%         %% ��Ư�Ƶ��µ�С��step�ϲ������������ɵļ��ϲ��˳���
%         % �ҵ�Ư�Ƶ㣻
% 
%         %�˴��� step_shift��ʵֻ�г�ʼ�����ж�ѭ�����������ã��ҵ�һ���͹��ˣ������ڻ��������ҡ�
% 
% 
%         step_shift = find(abs(diff(step_info(:,2)))<=step_check, 1);
%         while (~isempty(step_shift))
%             [ step_position,step_info, step_shift ] = shift_cor( data_z, step_position, step_check ,length_check);
%         end
%                 %�����������ͼ��Ϊѡֵ��׼��
%         fitted_data_modi = get_fitted_data(data_z,step_position);
%         figure;
%         plot(1:N,data_z,1:N,fitted_data_modi,'LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����һ��������ƣ��û�����ѡ���Ƿ����һ�����ݽ��з������е�������Ư�ƣ����Ǻܺã���Ӧ�ò��á�
% disp('good data ?')
% good = str2double(input('1 or 0','s'));
% if good == 1
    
    %% ��ͼ���ֶ�ȷ���м���̬����ѡȡ��ֵ������ֵ��ϵ��ÿһ�ι��࣬����������������ű������ָ����Ϲ�����
    

        
        
        disp('how many states ? ')
        state_num = str2double(input('states = ','s'));
        th_n = state_num-1;
        [~,threshold_y] = ginput(th_n);
        % Ԥ���þ���������������������ꡣ
        state_find = zeros(size(fitted_data_modi,1),state_num);
        Fit_modi= zeros(size(fitted_data_modi,1),1);
        for i = 1:th_n
            if i==1
                state_find(:,i) = fitted_data_modi < threshold_y(i);
                Fit_modi(state_find(:,i)>0) = mean(fitted_data_modi(state_find(:,i)>0));
            elseif i>1
                state_find(:,i)=fitted_data_modi < threshold_y(i)&fitted_data_modi > threshold_y(i-1);
                Fit_modi(state_find(:,i)>0) = mean(fitted_data_modi(state_find(:,i)>0));
            end
            state_find(:,i+1)=fitted_data_modi> threshold_y(i);
            Fit_modi(state_find(:,i+1)>0) = mean(fitted_data_modi(state_find(:,i+1)>0));
        end


    % ���ò�ֵķ����ҵ���Ե��1�����ǰһ�㣬-1���յ㡣
    % Ԥ����һ���������������źϲ���ÿ�εĳ��Ⱥϲ���ֵ�����ڰ�0����
    smooth_state = zeros(size(state_find,1),state_num);
    for i2 = 1:state_num
        segment_start=1;
        
    for p = 1:(size(state_find,1)-1)
        dif_state = diff(state_find(:,i2));
        if dif_state(p)==-1
            %�ҵ��±�Ե���ϲ��յ㣩�����Ⱥϲ���ȡֵ����Ȩƽ��
            %,��̨����ĩ������ʱ�䣬����ʵ������Ҫͳ��Ŀǰ���̬��ʱ�䣬��step_info����ǲ��Եģ�Ҳ������ʲôȡֵ��ֱ�Ӿ���ͳ�Ƴ���
            smooth_state(p,i2) = p-segment_start+1;
        elseif dif_state(p)==1
            %�ҵ��ϱ�Ե���ϲ���㣩�������µ���㣬ע���ֵ�ֵ��ʵ�ʵ��������һ��������ʵ�������ǲ������+1
            % �����и�Сtrick�� ʵ����state_find����һ�����ߵ����ݣ�����״̬��ʵ�߲��ֻ���
            % �����������̬��1��ͷ�����diff��һ����⵽����-1��������ʱ�䣬����̬����0��ͷ���ȼ�⵽1���������������¼��
            segment_start = p+1;
        end
    end
    end
if state_num == 2
    dwell_time_down = smooth_state(:,1);
    dwell_time_up = smooth_state(:,2);
    dwell_time_down(dwell_time_down==0)=[];
    dwell_time_up(dwell_time_up==0)=[];
    dwell_time_up = dwell_time_up./sample_rate;
    dwell_time_mid = dwell_time_up*0;
    dwell_time_down = dwell_time_down./sample_rate;
        % ���ÿ��̬�ڲ���ʱ���г��ֵİٷֱ�
    time_total = sum(dwell_time_up) + sum(dwell_time_down);
    time_domination = zeros(3,1);
    time_domination(1) = sum(dwell_time_down)/time_total;
    time_domination(2) = 0;
    time_domination(3) = sum(dwell_time_up)/time_total;
    %��ͳ�Ƶ�ʱ����ָ�����
    [down,up] = createFit(dwell_time_down,dwell_time_up);
    k_unfold = 1/down.mu;
            
    k_fold  = 1/up.mu;
    k_mid = 0;
    elseif state_num == 3
    dwell_time_down = smooth_state(:,1);
    dwell_time_mid = smooth_state(:,2);
    dwell_time_up = smooth_state(:,3);
    dwell_time_down(dwell_time_down==0)=[];
    dwell_time_mid(dwell_time_mid==0)=[];
    dwell_time_up(dwell_time_up==0)=[];
    
    dwell_time_up = dwell_time_up./sample_rate;
    dwell_time_mid = dwell_time_mid./sample_rate;
    dwell_time_down = dwell_time_down./sample_rate;
    % ���ÿ��̬�ڲ���ʱ���г��ֵİٷֱ�
    time_total = sum(dwell_time_up)+sum(dwell_time_mid)+sum(dwell_time_down);
    time_domination = zeros(3,1);
    time_domination(1) = sum(dwell_time_down)/time_total;
    time_domination(2) = sum(dwell_time_mid)/time_total;
    time_domination(3) = sum(dwell_time_up)/time_total;
    %��ͳ�Ƶ�ʱ����ָ�����
    [down,mid,up] = createFit3(dwell_time_down,dwell_time_mid ,dwell_time_up);
    k_unfold = 1/down.mu;        
    k_fold  = 1/up.mu;
    k_mid =1/mid.mu;
else
    k_unfold = 0;
    k_fold = 0;
    k_mid = 0;
end

end
% mean_time = 1./dwell_time_curve(:,5:7);


