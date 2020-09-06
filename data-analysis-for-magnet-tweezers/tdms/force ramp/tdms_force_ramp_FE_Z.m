
% ���ű����ڴ���MeCP2�ļ��װ汾
close all;

clear;
%% ��ȡ�⺯����ͷ�ļ�
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
NI_TDM_DLL_Path = 'D:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %��ȡ������
    %     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfi0le(dllfolder,dllfile);
end
libname='nilibddc';
NI_TDM_H_Path = 'D:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
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

% shift ֵ��ֻ������ͼʱ����
DNA_z_shift =base_offset;
DNA_z_position_modi = DNA_z_position_modi - DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;

number=size(DNA_z_position_modi,1);
time=(1:number)./6000;                                                   %ʱ�䵥λ��֡ת��������,100Hzʱ��6000֡��ע�⣡
% ��������˫����ӵ���ֵ����
% ����ѧ�����Լ�201911���Ժ�Ĳ��Ӷ�������ֵ0.15�����޸����ٱ�ע
zmag_shift =0.3;
MT_NO = 4.1;
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
%     ind3 = find(((force_ramp-4.48)>0.02)&((force_ramp-8.5)<0.02))+start_number;
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
    %     DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
    % DNA_z_wavelet = DNA_z_wavelet';
    if forward ==0
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number));
        data_denoised = wdenoise(data_ramp,5, ...
    'Wavelet', 'sym6', ...
    'DenoisingMethod', 'Bayes', ...
    'ThresholdRule', 'Soft', ...
    'NoiseEstimate', 'LevelIndependent');
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
    
    figure('Name',name_save);
    seg_time = ((1:length(start_number:end_number))/6000)';
 
%     subplot(2,1,2);

    %     yyaxis left;
    plot(seg_time,data_ramp*1000,'MarkerSize',4,'Marker','.',...
        'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
    hold on
    plot(seg_time,data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
    xlabel('Time/min');ylabel('Ext./nm');
    hold off
% %     subplot(2,1,1);
%     force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
%     plot(seg_time,zmag_ramp);
%     xlabel('Time/min');ylabel('magnet position/mm');
%     subplot(3,1,2);
%     plot(seg_time,force_ramp);
%     xlabel('Time/min');ylabel('Force/pN');
    %%  ȷ���Ƿ��޸���������
    F = 1;
    while(abs(F-1)<10E-6)
        disp('�Ƿ��޸� force ramp ���ߣ�')
        yes_ramp = input('�ǻ��߷�');
        if yes_ramp ~=0
            close;
            data_rep = data_repair(data_ramp,yes_ramp);
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
    
    
%     data_ramp = data_repair;
        
    
    
    %     yyaxis right;
    %     plot(time(start_number:end_number),force_ramp);
    %     ylabel('Force/pN')
    
    % hold off
    % subplot(2,1,2);
    % force_ramp = force_zmag_T1_newMT(zmag_ramp,0);
    % plot(time(start_number:end_number),force_ramp);
    % xlabel('Time (min)');ylabel('Force (pN)');
    % plot(time(start_number:end_number),magnet_z_position(start_number:end_number)*1000);
    % ѯ���Ƿ���� F-E ����
    disp('�Ƿ���� force ramp ���ߣ�')
    yes_ramp = input('�ǻ��߷�','s');
    if yes_ramp == '1'
        % ���ȱ���ͼƬ��tif ��ʽ
        % ���� axes
%         axes1 = gca;
%         hold(axes1,'on');
%         
%         box(axes1,'on');
%         %         % ������������������
%         %         set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
%         %             'ZColor',[0 0 0])
%         
%         % ��������̶��ⷭ
%         set(axes1,'TickDir','out');
%         % ������������������
%         set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
%             'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
        [~] = change_plot_style();
        % ���ȱ���ͼƬ��tif ��ʽ
        fig_name = strcat(name_save,'.fig');
        saveas(gcf,fig_name);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��������
        force_stepsize= 0.1;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %���Ȱ��շ��ӳ�����΢����һ��Zֵ
        % ����DNA���ӳ��ȣ�����Zֵ�ϵ�����
        %     disp('please input the length of DNA (um)');
        %     DNA_length = input('DNA length = ','s');
        %     DNA_Z_shift = str2double(DNA_length) - max(data_ramp);
        %     data_ramp = data_ramp + DNA_Z_shift;
        
        
        % �����ֵ����extension curve, ��λ����΢��

        ex_num = 2;
        [ ext_curve, force_i ] = ramp_ext_median_M280_MT4( data_denoised,zmag_ramp,zmag_start,zmag_end,force_stepsize,zmag_shift,MT_NO,ex_num );
        force_curve = force_i;
        % ������ֵ���㷽ʽ��������2018.11.3-4��������ݣ��������FR����û�п���˫����ӣ����¼������е㲻��
%         z_ramp = -log(force_i./142.6)/1.436;
%         force_curve = force_zmag_m280(z_ramp,4,zmag_shift);
        
        figure;
        plot_size = min(size(ext_curve,1),size(force_curve,1));
        
        ext_curve = ext_curve(1:plot_size)*1000;
        force_curve = force_curve(1:plot_size);
        plot(force_curve,ext_curve, ...
            'MarkerFaceColor',[0.301960796117783 0.745098054409027 0.933333337306976],...
            'MarkerSize',8,...
            'Marker','o',...
            'LineWidth',1);
        
        ylabel('Ext./nm');
        xlabel('Force/pN');
        done=change_plot_style();
%         % ���� axes
%         axes1 = gca;
%         hold(axes1,'on');
%         
%         box(axes1,'off');
%         %         % ������������������
%         %         set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
%         %             'ZColor',[0 0 0])
%         
%         % ��������̶��ⷭ
%         set(axes1,'TickDir','out');
%         % ������������������
%         set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
%             'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
%         box off
%         ax2 = axes('Position',get(gca,'Position'),...
%             'XAxisLocation','top',...
%             'YAxisLocation','right',...
%             'Color','none',...
%             'XColor','k','YColor','k');
%         set(ax2,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
%             'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
%         set(ax2,'YTick', []);
%         set(ax2,'XTick', []);
%         box on


        %         title(name_save);
        FE_name = strcat(name_save,'_FE.fig');
        saveas(gcf,FE_name);
        force_ramp_name = strcat(name_save);
        save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve','data_ramp','zmag_ramp','MT_NO');
        
        
    end
    
    
end
% head_name = 'DT3';
% bead_name = strcat(head_name,strtok(file_name,'.'),ramp_th,'.mat');
% save(bead_name,'DNA_x_modi','DNA_y_modi','DNA_z_position_modi','magnet_z_position','bead_name');



