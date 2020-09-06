% ���ű�����ͳ�ƺ��������еĶ���ѧ��Ϣ������פ��ʱ�䣬��������Ϣ
% ����Ϊ���϶�ӦҪ��������ļ���xyz ��ֻ��Z�ģ�
% ���Ϊ����ͳ�ƣ�̨�����ͼ��פ��ʱ��ֲ�����ָ����ϣ���������ݺ�ԭʼ���ݱ���������������פ��ʱ����ϼ��㷴Ӧ���ʣ���������档
% �Էֲ�����Ͻ����ͼ������
close all;

clear;
%% ��ȡ�⺯����ͷ�ļ�
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
NI_TDM_DLL_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %��ȡ������
    %     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
NI_TDM_H_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% ��ָ��TDMS �ļ�
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% �� bead trajectories �ļ�(�Դ������ļ�)
[DNA_z_position_modi,magnet_z_position] = read_Z_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);

% �ҵ���ԥ������Ͷ��㣬������ǣ�Ϊ�ָ�ͼ�����ο�
relax_pos = find(magnet_z_position == max(magnet_z_position));
end_pos = find(magnet_z_position == min(magnet_z_position)|abs(magnet_z_position-1.5)<0.01|abs(magnet_z_position-1.4)<0.01|abs(magnet_z_position-1.3)<0.01);
base_offset = min(DNA_z_position_modi(1:3000));
% end_pos = find(abs(magnet_z_position-1.4)<0.002);
%% data show
sample_rate = 100;
% shift ֵ��ֻ������ͼʱ����
DNA_z_shift =base_offset;
DNA_z_position_modi = DNA_z_position_modi - DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;

number=size(DNA_z_position_modi,1);
time=(1:number)./(60*sample_rate);                                                   %ʱ�䵥λ��֡ת��������,100Hzʱ��6000֡��ע�⣡
% ��������˫����ӵ���ֵ����
zmag_shift =0.3;


plot(DNA_z_position_modi);
% �ڳ�ԥ��λ��������ǣ�����ѡ������
hold on
relax_marker = zeros(size(relax_pos,1),1);
end_marker = zeros(size(end_pos,1),1);

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
%     force_ramp = force_zmag_m280(magnet_z_position(start_number:end_number),4,zmag_shift);
%     ind1 = find(abs(force_ramp-4.45)<0.02)+start_number;
%     DNA_z_position_modi(ind1) = DNA_z_position_modi(ind1)+0.0033;
%     ind2 = find(abs(force_ramp-8.55)<0.02)+start_number;
%     DNA_z_position_modi(ind2) = DNA_z_position_modi(ind2)+0.0085;
%     ind3 =
%     find(((force_ramp-4.48)>0.02)&((force_ramp-8.5)<0.02))+start_number;
%     DNA_z_position_modi(ind3) = DNA_z_position_modi(ind3)+0.0133;
    % name_save=FileName(13:name_length-3);
    % �����������ֱ�ӽ�ȡ�ļ�������Ҫ���֣�ȥ����׺�����ȼ��ַ�����������
    name_save=strtok(file_name,'.');
    
    %% �������޸ĺ�׺��ʡ�ı������ݺ�һ�����ģ�F����forward, R����reverse
    ramp_th = '_1';
    name_save = strcat(name_save,ramp_th);
    
    
    %% force-extension �����׶�
    % ��ȡ������ֵ��Ҫ����������, ����Ƿ���ģ�������Ҳ������,ע�� start ��end ��ҲҪ�ߵ�һ�£�����˳���λ
    disp('Forward or Reverse?');
    forward = str2double(input('1=forward, 0 = reverse ','s'));

    if forward ==0
        
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number));
        data_denoised = flipud(wdenoise(data_ramp,5, ...
        'Wavelet', 'sym6', ...
        'DenoisingMethod', 'Bayes', ...
        'ThresholdRule', 'Soft', ...
        'NoiseEstimate', 'LevelIndependent'));
        zmag_ramp = flipud(magnet_z_position(start_number:end_number));
        zmag_start=magnet_z_position(end_number);
        zmag_end = magnet_z_position(start_number);
    else
        data_ramp = DNA_z_position_modi(start_number:end_number);
        data_denoised = wdenoise(data_ramp,5, ...
        'Wavelet', 'sym6', ...
        'DenoisingMethod', 'Bayes', ...
        'ThresholdRule', 'Soft', ...
        'NoiseEstimate', 'LevelIndependent');
        zmag_ramp = magnet_z_position(start_number:end_number);
        zmag_start=magnet_z_position(start_number);
        zmag_end = magnet_z_position(end_number);
        
    end
    
        %%  ȷ���Ƿ��޸���������
    figure('Name',name_save);
    % subplot(2,1,1);

    %     yyaxis left;
    plot(time(start_number:end_number),data_ramp*1000,'MarkerSize',4,'Marker','.',...
        'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
    hold on
    plot(time(start_number:end_number),data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
    xlabel('Time/min');ylabel('Ext./nm');

    F = 1;
    while(abs(F-1)<10E-6)
        disp('�Ƿ��޸� force ramp ���ߣ�')
        yes_ramp = input('�ǻ��߷�','s');
        if yes_ramp == '1'
            close;
            data_rep = data_repair(data_ramp,1);
            close;
            figure;
            plot(time(start_number:end_number),data_rep*1000,'MarkerSize',4,'Marker','.',...
                'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
            hold on
            data_denoised = wdenoise(data_rep,5, ...
        'Wavelet', 'sym6', ...
        'DenoisingMethod', 'Bayes', ...
        'ThresholdRule', 'Soft', ...
        'NoiseEstimate', 'LevelIndependent');
            plot(time(start_number:end_number),data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
            xlabel('Time/min');ylabel('Ext./nm');
            data_ramp = data_rep;
        else
            break;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��������
    force_stepsize= 0.1;
    MT_NO = 4.1;
     step_extract(data_ramp,zmag_ramp,force_stepsize,zmag_start,zmag_end,filefolder,name_save);

%% �����½��ļ��б���������Ϊ���ݱȽ϶࣬���⻥�������������
    new_file_name=strcat(filefolder,name_save,'dwelltime2','_',date,'\');
    mkdir(new_file_name);                                                      %�½��ļ���
    cd(new_file_name);                                                         %�ı䵱ǰ·����
    step_number=1;                                                                  %����ţ���ֵ������Ҫ��
%% Ȼ�󽫽�ȡ������ data_ramp �ʹ���λ��һ����ͼ�������ѡ��Ҫ����������

%     figure('Name',name_save);
%     subplot(2,1,1);
% 
%     %     yyaxis left;
%     plot(data_ramp*1000,'MarkerSize',4,'Marker','.',...
%         'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
%     hold on
%     plot(data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
%     xlabel('Time/frame');ylabel('Ext./nm');
% 
% %     data_ramp = data_repair;
% 
%     %     yyaxis right;
%     %     plot(time(start_number:end_number),force_ramp);
%     %     ylabel('Force/pN')
%     
%     hold off
%     subplot(2,1,2);
%     force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
%     plot(force_ramp);
%     xlabel('Time/frame');ylabel('Force (pN)');
%     plot(time(start_number:end_number),magnet_z_position(start_number:end_number)*1000);

     check = 1;
    dwell_time_curve=zeros(40,7);            %��ֵ���ߣ��ֱ���������zmag����ֵ��k_unfold,k_fold�� �������ֻ��10��̨�ף�����Ļ���Ҫ���Ӿ�������
    %jian
%     fileID = fopen('step_and_std.txt','a');
    fileID2 = fopen('time_domination.txt','a');
%     fprintf(fileID,'%8s %12s\n','step','step_std');
    fprintf(fileID2,'%6s %12s %12s\n','fold','mid','unfold');
while (check)
%% פ��ʱ�����
disp("�Ƿ����dwell time ������ �ǡ���1���񡪡�0");
    figure('Name',name_save);
    axes1 = subplot(2,1,1);

    %     yyaxis left;
    plot(data_ramp*1000,'MarkerSize',4,'Marker','.',...
        'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
    hold on
    plot(data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
    xlabel('Time/frame');ylabel('Ext./nm');
    
    hold off
    axes2 = subplot(2,1,2);
    force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
    plot(force_ramp);
    xlabel('Time/frame');ylabel('Force (pN)');
    linkaxes([axes1,axes2],'x');

check = input('����1ѡ������');

if check ==1
    [stage_start,~]=ginput(1);
    stage_start=floor(stage_start);
    if stage_start<1
        stage_start=1;
    end
    
    [stage_end,~]=ginput(1);                                          %���ȡ�����öϵ�  ��
    stage_end=floor(stage_end);                                          %����ȡ��
    if stage_end>number
        stage_end=number;
    end
    % ��ȡƽ̨���ݺʹ���λ��������������
    data_step = data_ramp(stage_start:stage_end);
    step_pos = zmag_ramp(stage_start);
    force = force_zmag_m280(step_pos,MT_NO,zmag_shift);                                  %��force zmag�Ĺ�ϵ��ӵõ�force����Ϊ���������㲻׼��
    
    % ���ò���㷨��λ̨��λ�ã��ȿ����㷨�����׼ȷ�������ڹ���ϣ���Ԥ������ 
    delta_i = 10;
    [good_step_loc,Fit] = DF_step(data_step,delta_i);
    
    
        step_fig_name = strcat('step_detect',num2str(force),'.fig');
        h = gcf;
        saveas(h, step_fig_name,'fig');
    
    % ��ʼͳ��ƽ��������פ��ʱ�䣨���޶�̬���̣�
    N = length(Fit);
    figure;
    plot((1:N)./sample_rate,data_step.*1000,(1:N)./sample_rate,Fit*1000,'LineWidth',2);
    xlabel('Time(min)');
    ylabel('Ext.(nm)');
%     %% ��ѡ������������data_step ����step_detect�㷨
% 
%     non = [];
%     
%     % ��data_z����step-detect ������������ں���ķ�����
%     step_position = J_search(data_step,0.8);   % step_position �Ǹ���ԭʼ������ϳ���stepͼ
%     
%     length_check = 3;
%     step_check = 0.001;%�˳��Ƚ�С������step
%     % �� data_z���в�����������ȡ����ϲ���
%     [ data_fit,step,step_std,~,good1] = step_modulation( data_step,step_position,step_check,length_check);
    
    
    if input('good fit? ')
        
        % ����ͼ������ϱ���ͼ��
        
        step_fig_name = strcat('step',num2str(force),'.fig');
        h = gcf;
        saveas(h, step_fig_name,'fig');
%         fprintf(fileID,'%6.8f \t',step);
%         fprintf(fileID,'%6.8f \t',step_std);
%         fprintf(fileID,'%f\r\n',non);
        % �� data_z����פ��ʱ���������ȡ����ϲ���
        
       [ k_unfold,k_mid,k_fold,time_domination,dwell_time_down,dwell_time_mid,dwell_time_up,Fit_modi ]  = tdms_dwell_time_count(data_step*1000,Fit*1000,sample_rate);
        time_fig_name = strcat('dwelltime',num2str(force),'.fig');
        h = gcf;
        saveas(h, time_fig_name,'fig');
        % ���down����0��˵��û��������һ�η�������ִ�к����������0,��������һѭ����
        % �õ���Ͻ���󣬵�����Ͻ����������k_fold and k_unfold

            
            
            fprintf(fileID2,'%6.8f %12.8f %12.8f\r\n',time_domination);
            %������ֵ
            data_z_mean=mean(Fit);           %Z�����ֵ����L
            
            % ���������
            
            dwell_time_curve(step_number,1)=step_number;                      %time_curve��1�б������
            dwell_time_curve(step_number,2)=data_z_mean;                       %time_curve ��2������Zֵ��Ҳ����extension
            dwell_time_curve(step_number,3)=force;                             %��3��������������ֵ����force
            dwell_time_curve(step_number,4)=step_pos;                          %��4������Zmag
            dwell_time_curve(step_number,5)=k_unfold;
            dwell_time_curve(step_number,6)=k_fold;
            dwell_time_curve(step_number,7)=k_mid;
            %����ԭʼ����
            new_data_name=strcat('data_',num2str(force),'.mat');
            %         new_data_name_y=strcat('data_y',num2str(step_number),'.mat');
            new_data_d_name=strcat('data_d','_',num2str(force),'.mat');
            
            save(new_data_name,'data_step','step_pos','dwell_time_down','dwell_time_mid','dwell_time_up');                                                %ͬʱ����������Z��Ϣ��С���˲���Z��Ϣ
            save(new_data_d_name,'Fit','Fit_modi','step_pos');                                            %�洢��������д�룬������������΢��Ĳ��
            step_number = step_number+1;

    end
close all;
end

end
dwell_time_curve(step_number:end,:)=[];

%     fclose(fileID);
    fclose(fileID2);
    save('dwell_time_data.mat','dwell_time_curve','time_domination');  
end