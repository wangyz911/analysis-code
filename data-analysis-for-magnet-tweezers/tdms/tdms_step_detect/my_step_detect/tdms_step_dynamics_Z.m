% 本脚本用来统计恒力测量中的动力学信息，包括驻留时间，步长等信息
% 输入为符合对应要求的数据文件（xyz 和只有Z的）
% 输出为步长统计，台阶拟合图，驻留时间分布及其指数拟合，将拟合数据和原始数据保存下来，并根据驻留时间拟合计算反应速率，将结果保存。
% 对分布和拟合结果作图并保存
close all;

clear;
%% 读取库函数和头文件
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
NI_TDM_DLL_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %提取库名称
    %     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
NI_TDM_H_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% 打开指定TDMS 文件
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% 打开 bead trajectories 文件(自带磁铁文件)
[DNA_z_position_modi,magnet_z_position] = read_Z_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);

% 找到弛豫的区间和顶点，并做标记，为分割图像做参考
relax_pos = find(magnet_z_position == max(magnet_z_position));
end_pos = find(magnet_z_position == min(magnet_z_position)|abs(magnet_z_position-1.5)<0.01|abs(magnet_z_position-1.4)<0.01|abs(magnet_z_position-1.3)<0.01);
base_offset = min(DNA_z_position_modi(1:3000));
% end_pos = find(abs(magnet_z_position-1.4)<0.002);
%% data show
sample_rate = 100;
% shift 值，只有在修图时才用
DNA_z_shift =base_offset;
DNA_z_position_modi = DNA_z_position_modi - DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;

number=size(DNA_z_position_modi,1);
time=(1:number)./(60*sample_rate);                                                   %时间单位由帧转换到分钟,100Hz时是6000帧，注意！
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
%     force_ramp = force_zmag_m280(magnet_z_position(start_number:end_number),4,zmag_shift);
%     ind1 = find(abs(force_ramp-4.45)<0.02)+start_number;
%     DNA_z_position_modi(ind1) = DNA_z_position_modi(ind1)+0.0033;
%     ind2 = find(abs(force_ramp-8.55)<0.02)+start_number;
%     DNA_z_position_modi(ind2) = DNA_z_position_modi(ind2)+0.0085;
%     ind3 =
%     find(((force_ramp-4.48)>0.02)&((force_ramp-8.5)<0.02))+start_number;
%     DNA_z_position_modi(ind3) = DNA_z_position_modi(ind3)+0.0133;
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
    
        %%  确定是否修复数据曲线
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
        disp('是否修复 force ramp 曲线？')
        yes_ramp = input('是或者否','s');
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 参数设置
    force_stepsize= 0.1;
    MT_NO = 4.1;
     step_extract(data_ramp,zmag_ramp,force_stepsize,zmag_start,zmag_end,filefolder,name_save);

%% 首先新建文件夹保存结果，因为内容比较多，避免互相混淆甚至覆盖
    new_file_name=strcat(filefolder,name_save,'dwelltime2','_',date,'\');
    mkdir(new_file_name);                                                      %新建文件夹
    cd(new_file_name);                                                         %改变当前路径至
    step_number=1;                                                                  %总序号，力值曲线需要用
%% 然后将截取的数据 data_ramp 和磁铁位置一起做图，用鼠标选定要分析的区间

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
    dwell_time_curve=zeros(40,7);            %力值曲线，分别用来保存zmag，力值，k_unfold,k_fold。 这里假设只有10个台阶，更多的话就要增加矩阵行数
    %jian
%     fileID = fopen('step_and_std.txt','a');
    fileID2 = fopen('time_domination.txt','a');
%     fprintf(fileID,'%8s %12s\n','step','step_std');
    fprintf(fileID2,'%6s %12s %12s\n','fold','mid','unfold');
while (check)
%% 驻留时间分析
disp("是否进行dwell time 分析？ 是——1；否——0");
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

check = input('输入1选择区间');

if check ==1
    [stage_start,~]=ginput(1);
    stage_start=floor(stage_start);
    if stage_start<1
        stage_start=1;
    end
    
    [stage_end,~]=ginput(1);                                          %鼠标取点设置断点  ？
    stage_end=floor(stage_end);                                          %向下取整
    if stage_end>number
        stage_end=number;
    end
    % 读取平台数据和磁镊位置用来后续分析
    data_step = data_ramp(stage_start:stage_end);
    step_pos = zmag_ramp(stage_start);
    force = force_zmag_m280(step_pos,MT_NO,zmag_shift);                                  %用force zmag的关系间接得到force，因为短链的力算不准。
    
    % 利用差分算法定位台阶位置，比卡方算法更快更准确，不存在过拟合，无预设条件 
    delta_i = 10;
    [good_step_loc,Fit] = DF_step(data_step,delta_i);
    
    
        step_fig_name = strcat('step_detect',num2str(force),'.fig');
        h = gcf;
        saveas(h, step_fig_name,'fig');
    
    % 开始统计平均步长和驻留时间（仅限二态过程）
    N = length(Fit);
    figure;
    plot((1:N)./sample_rate,data_step.*1000,(1:N)./sample_rate,Fit*1000,'LineWidth',2);
    xlabel('Time(min)');
    ylabel('Ext.(nm)');
%     %% 对选定的数据区间data_step 调用step_detect算法
% 
%     non = [];
%     
%     % 对data_z进行step-detect 工作，结果用于后面的分析。
%     step_position = J_search(data_step,0.8);   % step_position 是根据原始数据拟合出的step图
%     
%     length_check = 3;
%     step_check = 0.001;%滤除比较小的杂音step
%     % 对 data_z进行步长分析，提取出拟合参数
%     [ data_fit,step,step_std,~,good1] = step_modulation( data_step,step_position,step_check,length_check);
    
    
    if input('good fit? ')
        
        % 生成图像后马上保存图像
        
        step_fig_name = strcat('step',num2str(force),'.fig');
        h = gcf;
        saveas(h, step_fig_name,'fig');
%         fprintf(fileID,'%6.8f \t',step);
%         fprintf(fileID,'%6.8f \t',step_std);
%         fprintf(fileID,'%f\r\n',non);
        % 对 data_z进行驻留时间分析，提取出拟合参数
        
       [ k_unfold,k_mid,k_fold,time_domination,dwell_time_down,dwell_time_mid,dwell_time_up,Fit_modi ]  = tdms_dwell_time_count(data_step*1000,Fit*1000,sample_rate);
        time_fig_name = strcat('dwelltime',num2str(force),'.fig');
        h = gcf;
        saveas(h, time_fig_name,'fig');
        % 如果down不是0，说明没有跳过这一段分析，则执行后续，如果是0,则跳入下一循环。
        % 得到拟合结果后，导出拟合结果，并计算k_fold and k_unfold

            
            
            fprintf(fileID2,'%6.8f %12.8f %12.8f\r\n',time_domination);
            %计算力值
            data_z_mean=mean(Fit);           %Z方向均值，即L
            
            % 储存计算结果
            
            dwell_time_curve(step_number,1)=step_number;                      %time_curve第1列标明序号
            dwell_time_curve(step_number,2)=data_z_mean;                       %time_curve 第2列输入Z值，也就是extension
            dwell_time_curve(step_number,3)=force;                             %第3列输入计算出的力值，即force
            dwell_time_curve(step_number,4)=step_pos;                          %第4列输入Zmag
            dwell_time_curve(step_number,5)=k_unfold;
            dwell_time_curve(step_number,6)=k_fold;
            dwell_time_curve(step_number,7)=k_mid;
            %保存原始数据
            new_data_name=strcat('data_',num2str(force),'.mat');
            %         new_data_name_y=strcat('data_y',num2str(step_number),'.mat');
            new_data_d_name=strcat('data_d','_',num2str(force),'.mat');
            
            save(new_data_name,'data_step','step_pos','dwell_time_down','dwell_time_mid','dwell_time_up');                                                %同时保存修正的Z信息和小波滤波的Z信息
            save(new_data_d_name,'Fit','Fit_modi','step_pos');                                            %存储并不等于写入，在载入上有着微妙的差别
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