
% 本脚本用于处理MeCP2的简易版本, 只处理Z值
close all;

clear;
%% 读取库函数和头文件
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
NI_TDM_DLL_Path = 'C:\analysis-code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %提取库名称
    %     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
NI_TDM_H_Path = 'C:\analysis-code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% 打开指定TDMS 文件
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% 打开 bead trajectories 文件(自带磁铁文件)
[ DNA_z_position_modi,magnet_z_position] = read_Z_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);

% 找到弛豫的区间和顶点，并做标记，为分割图像做参考
relax_pos = find(magnet_z_position == max(magnet_z_position));
end_pos = find(magnet_z_position == min(magnet_z_position));

%% data show

% shift 值，只有在修图时才用
DNA_z_shift =0;
DNA_z_position_modi = DNA_z_position_modi + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;

number=size(DNA_z_position_modi,1);
time=(1:number)./6000;                                                   %时间单位由帧转换到分钟,100Hz时是6000帧，注意！
% 这里设置双面槽子的力值修正
zmag_shift =0.3;

plot(DNA_z_position_modi);
% 在弛豫的位置做个标记，方便选择区间
hold on
relax_marker = zeros(size(relax_pos,1),1);
end_marker = zeros(size(end_pos,1),1);
plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
plot(end_pos,end_marker,'k','LineStyle','none','Marker','o');
hold off

%% 选择数据区间
disp('请选择合适的区间')

if input('输入1选择区间','s')=='1'
    
    [start_number,~]=ginput(1);
    start_number=floor(start_number);
    if start_number<1
        start_number=1;
    end
    
    [end_number,~]=ginput(1);                                          %鼠标取点设置断点  ？
    end_number=floor(end_number);                                          %向下取整
    if end_number>number
        end_number=number;
    end
    
    % name_save=FileName(13:name_length-3);
    % 下面这个函数直接截取文件名的主要部分，去除后缀名，比减字符个数更加灵活。
    name_save=strtok(file_name,'.');
    
    %% 在这里修改后缀，省的保存数据后一个个改，F代表forward, R代表reverse
    ramp_th = '_1';
    name_save = strcat(name_save,ramp_th);
    
    
    %% force-extension 分析阶段
    % 提取计算力值需要的数据区间, 如果是反向的，将数据也倒过来,注意 start 和end 点也要颠倒一下，以免顺序错位
    disp('Forward or Reverse?');
    forward = str2double(input('1=forward, 0 = reverse ','s'));
%     DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
% DNA_z_wavelet = DNA_z_wavelet';
    if forward ==0
        
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number));
        data_denoised = flipud(sigDEN5(data_ramp));
        zmag_ramp = flipud(magnet_z_position(start_number:end_number));
        zmag_start=magnet_z_position(end_number);
        zmag_end = magnet_z_position(start_number);
    else
        data_ramp = DNA_z_position_modi(start_number:end_number);
        data_denoised = sigDEN5(DNA_z_position_modi(start_number:end_number));
        zmag_ramp = magnet_z_position(start_number:end_number);
        zmag_start=magnet_z_position(start_number);
        zmag_end = magnet_z_position(end_number);
    end
    figure('Name',name_save);
    % subplot(2,1,1);
    force_ramp = force_zmag_m280(zmag_ramp,4,zmag_shift);
%     yyaxis left;
    plot(time(start_number:end_number),data_ramp*1000,'MarkerSize',4,'Marker','.',...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
    hold on
    plot(time(start_number:end_number),data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
    xlabel('Time (min)');ylabel('Ext. (nm)');
    

    %%  确定是否修复数据曲线
    F = 1;
    while(abs(F-1)<10E-6)
        disp('是否修复 force ramp 曲线？')
        yes_ramp = input('是或者否');
        if yes_ramp ~=0
            close;
            data_rep = data_repair(data_ramp,yes_ramp);
            close;
            figure;
            plot(time(start_number:end_number),data_rep*1000,'MarkerSize',4,'Marker','.',...
                'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
            hold on
            data_denoised = sigDEN5(data_rep);
            plot(time(start_number:end_number),data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
            xlabel('Time/min)');ylabel('Ext./nm');
            data_ramp = data_rep;
        else
            break;
        end
    end
    
    
%     data_ramp = data_rep;
    
%     yyaxis right;
%     plot(time(start_number:end_number),force_ramp);
%     ylabel('Force/pN')
    
    % hold off
    % subplot(2,1,2);
    % force_ramp = force_zmag_T1_newMT(zmag_ramp,0);
    % plot(time(start_number:end_number),force_ramp);
    % xlabel('Time (min)');ylabel('Force (pN)');
    % plot(time(start_number:end_number),magnet_z_position(start_number:end_number)*1000);
    % 询问是否分析 F-E 曲线
    disp('是否分析 force ramp 曲线？')
    yes_ramp = input('是或者否','s');
    if yes_ramp == '1'
        % 创建 axes
        axes1 = gca;
        hold(axes1,'on');
        
        box(axes1,'on');
        % 设置其余坐标区属性
        set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
            'ZColor',[0 0 0]);
        
        % 首先保存图片的tif 格式
        fig_name = strcat(name_save,'.fig');
        saveas(gcf,fig_name);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 参数设置
        stepsize= -0.01;
        ex_num = 1;
        
        % 计算均值，即extension curve, 单位还是微米
        [ ext_curve, zmag_i ] = clamp_ext_mean(data_denoised,zmag_ramp,zmag_start,zmag_end,stepsize,ex_num);
        force_curve = force_zmag_m280(zmag_i,4.1,zmag_shift);
        
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
        
        % 创建 axes
        axes1 = gca;
        hold(axes1,'on');
        
        box(axes1,'on');
        % 设置其余坐标区属性
        set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
            'ZColor',[0 0 0]);
        
%         title(name_save);
        FE_name = strcat(name_save,'_FE.fig');
        saveas(gcf,FE_name);
        force_ramp_name = strcat(name_save);
        save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve','data_ramp');
        
        
    end
    
    
end
% head_name = 'DT3';
% bead_name = strcat(head_name,strtok(file_name,'.'),ramp_th,'.mat');
% save(bead_name,'DNA_x_modi','DNA_y_modi','DNA_z_position_modi','magnet_z_position','bead_name');



