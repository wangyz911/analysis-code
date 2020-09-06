%  ���ű���ΪMeCP2 remodel �ĸ߼�Ⱦɫ�ʽṹ�����MeR �ṹ�������ݷ�����д��Ŀ����ͳ�Ƴ�ÿһ��չ���ĸ���״̬��ʼĩλ�ã�չ��������ƽ��פ��ʱ��
%  ���ű��ĺ����㷨�ǲ��ÿ������ַ������������ݻ���Ϊ���ɸ�̨�ף�ʹ���ܵĿ��������С��
%  ��Ϊʵ�����ݵ�step �ǳ��Ķ࣬������ʮ�������Ҳ���ÿ�ζ�ȷ�������Զ���step size
%  ���ֶ������ǰ�ѭ���Ƶģ�ֱ������0�󷽲�ֹͣ�������䡣
%  ������Ҫ�����Ľ����ÿ��̬��λ�ã�������פ��ʱ�䡣

close all;

clear;
%% ��ȡ�⺯����ͷ�ļ�
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
NI_TDM_DLL_Path = 'F:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %��ȡ������
    %     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
NI_TDM_H_Path = 'F:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% ��ָ��TDMS �ļ�
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% �� bead trajectories �ļ�(�Դ������ļ�)
[ DNA_x_modi,DNA_y_modi,DNA_z_position_modi,magnet_z_position] = read_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);

% �ҵ���ԥ������Ͷ��㣬������ǣ�Ϊ�ָ�ͼ�����ο�
relax_pos = find(magnet_z_position == max(magnet_z_position));
end_pos = find(magnet_z_position == min(magnet_z_position));
%% data show

% shift ֵ��ֻ������ͼʱ����
DNA_z_shift =0;
DNA_z_position_modi = DNA_z_position_modi + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
DNA_z_wavelet = DNA_z_wavelet';

number=size(DNA_z_position_modi,1);
time=(1:number)./12000;                                                   %ʱ�䵥λ��֡ת��������,100Hzʱ��6000֡��ע�⣡

plot(DNA_z_position_modi);
% �ڳ�ԥ��λ��������ǣ�����ѡ������
hold on
relax_marker = zeros(size(relax_pos,1),1);
end_marker = ones(size(end_pos,1),1);
plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
plot(end_pos,end_marker,'k','LineStyle','none','Marker','o');
hold off

%% ѡ����������
disp('��ѡ����ʵ�����')

if input('����1ѡ������','s')=='1'
    
    [start_number,~]=ginput(1);
    start_number=floor(start_number);
    if start_number<1
        start_number=1;
    end
    
    [end_number,~]=ginput(1);                                          %���ȡ�����öϵ�  ��
    end_number=floor(end_number);                                          %����ȡ��
    if end_number>number
        end_number=number;
    end
    
    % name_save=FileName(13:name_length-3);
    % �����������ֱ�ӽ�ȡ�ļ�������Ҫ���֣�ȥ����׺�����ȼ��ַ�����������
    name_save=strtok(file_name,'.');
    
    %% �������޸ĺ�׺��ʡ�ı������ݺ�һ������
    ramp_th = '_5R';
    name_save = strcat(name_save,ramp_th);
    
    
    %% force-extension �����׶�
    % ��ȡ������ֵ��Ҫ����������, Ϊ�˺�ͼ�ϱ���һ���Ա��ڷ�������λת����nm
    % �ڱ��������ǲ����ÿ����Զ���������ķ�������Ϊչ��Ƶ��̫�죬��Щstep ���ᱻʶ����������ʹ���˹��ֶ�������step.
    % �ʺ���fitted_data = data_ramp��һ�㲻Ӧ���
    % ����һ��state_num ���ڼ����������е�����Ľ������
    disp('Forward or Reverse?');
    if str2double(input('1=forward, 0 = reverse ','s'))==0
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number))*1000;
    else
        data_ramp = DNA_z_position_modi(start_number:end_number)*1000;
    end
    
    fitted_data = medfilt1(data_ramp,3);
    
    % �Ȼ����켣ͼ�� ��Ӧ�����켣��ѯ���Ƿ�Ҫ��F-E ������
    figure('Name',name_save);
    % subplot(2,1,1);
    plot(time(start_number:end_number),data_ramp,'k','Marker','.','MarkerSize',4);
    hold on
    plot(time(start_number:end_number),fitted_data,'r','Marker','.','MarkerSize',4);
    
    
    % ѯ���Ƿ����
    disp('---------------��Ҫ������&פ��ʱ��ͳ����0-����Ҫ��1-��Ҫ')
    yes_or_no_string1=input('judge1=','s');                                    %*
    if yes_or_no_string1=='1'                                                  %�����˾ͻ�ͼ��û����Ͳ�
        %% ȷ�Ͻ��з�������ʼһ��������̨�׵�����
        %Ԥ���ñ����������ľ��󣬴�С�ɷ��������̨�״�С����
        dwell_time_result=zeros(100,5);
        
        state_num = 1;
        state_find = zeros(size(fitted_data,1),40);
        threshold_y_array = zeros(40,1);
        while (str2double(input('next?=','s')))
            
            [~,threshold_y] = ginput(1);
            threshold_y_array(state_num) = threshold_y(1);
            state_num = state_num + 1;
            threshold_y(1)
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
        state_std = zeros(state_num,1);
        dwell_time_mean = zeros(state_num,1);
        dwell_time_count = zeros(state_num,1);
        % �� data_ramp���в�����������ȡ�������Ĳ�����ÿ��̬�ľ�ֵ��ÿ��̬��ƽ��פ��ʱ�䣬̬�䲽����������׼ֵ����Ϻ�����ݣ���״̬��
        for j=1:state_num
            % ����û��ʹ��fitted_data ��ԭ������ֵ�˲�����������ë�̣����Ƕ������ֵ�����е�Ӱ�죬��ԭ�������һ��
            a=data_ramp(state_find(:,j) == 1);
            state_mean(j) = mean(a);
            state_std(j) = std(a);
            % �������פ��ʱ��
            % ����ȡ��p��̨�׵�����
            b=state_find(:,j);
            seg_start = find(diff(b) == 1);
            seg_end = find(diff(b)==-1);
            % diff ��ͷ�ж����ȱ�ٵ�һ�����˹����ϣ�����Ķ����ü�
            if size(seg_start,1)< size(seg_end,1)
                seg_start = [0;seg_start];
                %  ���һ��ĩβû��-1��������˹�������������
            elseif size(seg_start,1)> size(seg_end,1)
                seg_end = [seg_end;size(b,1)];
            end
            
            % �����յ��ȥ��㣬�õ�פ��ʱ��֡��������200�õ��������Ժ�Ҫ�����ֲ��Ļ�dwell_time_arrayҲ���Ըĳ���
            dwell_time_array = (seg_end-seg_start)./200;
            dwell_time_count(j) = size(dwell_time_array,1);
            dwell_time_mean(j) = mean(dwell_time_array);
        end
        %���㲽��
        step = diff(state_mean);
        step_std = sqrt(state_std(1:(state_num-1)).^2 + state_std(2:state_num).^2);
        
        
        
        %% �����µ�fitted data ��ͼ��Ч����
        for k = 1:state_num
            fitted_data(state_find(:,k)==1)= state_mean(k);
        end
        N = size(data_ramp,1);
        figure;
        plot((1:N)./200,data_ramp,'k','Marker','.','MarkerSize',6);
        hold on
        plot((1:N)./200,fitted_data,'r','LineWidth',1)
        xlabel('Time(min)');
        ylabel('Ext.(nm)');
        
        
        % ����ͼ������ϱ���ͼ��
        step_fig_name = strcat(name_save,ramp_th,'_fit','.fig');
        h = gcf;
        saveas(h, step_fig_name,'fig');
        
        
        % ���������
        % ���Ƚ������������Ϊ���ʵĴ�С����ŵ�����������״̬��
        dwell_time_result = dwell_time_result(1:state_num,5);
        dwell_time_result(1:state_num,1)=state_mean;
        dwell_time_result(1:state_num,2)=dwell_time_mean;
        dwell_time_result(1:state_num,3)=dwell_time_count;
        dwell_time_result(1:(state_num-1),4)=step;
        dwell_time_result(1:(state_num-1),5)=step_std;
        
        %����ԭʼ����
        new_data_name=strcat(name_save,ramp_th,'_mt','.mat');
        
        
        save(new_data_name,'data_ramp','fitted_data','dwell_time_result','name_save');                                                %ͬʱ����������Z��Ϣ��С���˲���Z��Ϣ
        
        
    end
    % ѭ����ɣ��ر��ļ���
    
    
end




















