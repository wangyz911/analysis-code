%  本脚本特为MeCP2 remodel 的高级染色质结构（简称MeR 结构）的数据分析而写，目标是统计出每一步展开的各个状态的始末位置，展开步长，平均驻留时间
%  本脚本的核心算法是采用卡方二分法搜索，将数据划分为若干个台阶，使得总的卡方结果最小。
%  因为实际数据的step 非常的多，至少有十几个，且并非每次都确定，所以对于step size
%  的手动划分是半循环制的，直到输入0后方才停止划分区间。
%  最终想要导出的结果：每个态的位置，步长，驻留时间。

close all;

clear;
%% 读取库函数和头文件
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
NI_TDM_DLL_Path = 'F:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %提取库名称
    %     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
NI_TDM_H_Path = 'F:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% 打开指定TDMS 文件
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% 打开 bead trajectories 文件(自带磁铁文件)
[ DNA_x_modi,DNA_y_modi,DNA_z_position_modi,magnet_z_position] = read_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);

% 找到弛豫的区间和顶点，并做标记，为分割图像做参考
relax_pos = find(magnet_z_position == max(magnet_z_position));
end_pos = find(magnet_z_position == min(magnet_z_position));
%% data show

% shift 值，只有在修图时才用
DNA_z_shift =0;
DNA_z_position_modi = DNA_z_position_modi + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
DNA_z_wavelet = DNA_z_wavelet';

number=size(DNA_z_position_modi,1);
time=(1:number)./12000;                                                   %时间单位由帧转换到分钟,100Hz时是6000帧，注意！

plot(DNA_z_position_modi);
% 在弛豫的位置做个标记，方便选择区间
hold on
relax_marker = zeros(size(relax_pos,1),1);
end_marker = ones(size(end_pos,1),1);
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
    
    %% 在这里修改后缀，省的保存数据后一个个改
    ramp_th = '_5R';
    name_save = strcat(name_save,ramp_th);
    
    
    %% force-extension 分析阶段
    % 提取计算力值需要的数据区间, 为了和图上保持一致以便于分析，单位转化成nm
    % 在本例中我们不适用卡方自动划分区间的方法，因为展开频率太快，有些step 不会被识别，所以我们使用人工手段来区分step.
    % 故后文fitted_data = data_ramp；一般不应如此
    % 设置一个state_num 用于计数，后期切掉多余的结果矩阵
    disp('Forward or Reverse?');
    if str2double(input('1=forward, 0 = reverse ','s'))==0
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number))*1000;
    else
        data_ramp = DNA_z_position_modi(start_number:end_number)*1000;
    end
    
    fitted_data = medfilt1(data_ramp,3);
    
    % 先画出轨迹图和 对应磁铁轨迹，询问是否要做F-E 分析。
    figure('Name',name_save);
    % subplot(2,1,1);
    plot(time(start_number:end_number),data_ramp,'k','Marker','.','MarkerSize',4);
    hold on
    plot(time(start_number:end_number),fitted_data,'r','Marker','.','MarkerSize',4);
    
    
    % 询问是否分析
    disp('---------------需要做步长&驻留时间统计吗？0-不需要；1-需要')
    yes_or_no_string1=input('judge1=','s');                                    %*
    if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不
        %% 确认进行分析，开始一个个定出台阶的区间
        %预设置保存分析结果的矩阵，大小由分析区间和台阶大小决定
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
        %% 根据阈值划分data，每部分的data 的值进行平均，得到每个态跳跃的步长和标准差。
        
        for i = 1:(state_num-1)
            if i==1
                state_find(:,i) = fitted_data < threshold_y_array(i);
            elseif i>1
                state_find(:,i)=fitted_data < threshold_y_array(i)&fitted_data > threshold_y_array(i-1);
            end
            state_find(:,i+1)=fitted_data> threshold_y_array(i);
        end
        % 预设置矩阵保存每个状态的均值和标准差,和平均驻留时间
        state_mean = zeros(state_num,1);
        state_std = zeros(state_num,1);
        dwell_time_mean = zeros(state_num,1);
        dwell_time_count = zeros(state_num,1);
        % 对 data_ramp进行步长分析，提取出分析的参数：每个态的均值，每个态的平均驻留时间，态间步长，步长标准值，拟合后的数据，总状态数
        for j=1:state_num
            % 这里没有使用fitted_data 的原因是中值滤波有助于消除毛刺，但是对于算均值可能有点影响，用原数据算好一点
            a=data_ramp(state_find(:,j) == 1);
            state_mean(j) = mean(a);
            state_std(j) = std(a);
            % 下面计算驻留时间
            % 先提取第p个台阶的索引
            b=state_find(:,j);
            seg_start = find(diff(b) == 1);
            seg_end = find(diff(b)==-1);
            % diff 从头判断起点缺少第一个，人工补上，后面的都不用加
            if size(seg_start,1)< size(seg_end,1)
                seg_start = [0;seg_start];
                %  最后一个末尾没有-1的情况，人工补上最后的索引
            elseif size(seg_start,1)> size(seg_end,1)
                seg_end = [seg_end;size(b,1)];
            end
            
            % 所有终点减去起点，得到驻留时间帧数，除以200得到秒数，以后要分析分布的话dwell_time_array也可以改出来
            dwell_time_array = (seg_end-seg_start)./200;
            dwell_time_count(j) = size(dwell_time_array,1);
            dwell_time_mean(j) = mean(dwell_time_array);
        end
        %计算步长
        step = diff(state_mean);
        step_std = sqrt(state_std(1:(state_num-1)).^2 + state_std(2:state_num).^2);
        
        
        
        %% 依据新的fitted data 作图看效果。
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
        
        
        % 生成图像后马上保存图像
        step_fig_name = strcat(name_save,ramp_th,'_fit','.fig');
        h = gcf;
        saveas(h, step_fig_name,'fig');
        
        
        % 储存计算结果
        % 首先将结果矩阵修正为合适的大小，存放的数据最多就是状态数
        dwell_time_result = dwell_time_result(1:state_num,5);
        dwell_time_result(1:state_num,1)=state_mean;
        dwell_time_result(1:state_num,2)=dwell_time_mean;
        dwell_time_result(1:state_num,3)=dwell_time_count;
        dwell_time_result(1:(state_num-1),4)=step;
        dwell_time_result(1:(state_num-1),5)=step_std;
        
        %保存原始数据
        new_data_name=strcat(name_save,ramp_th,'_mt','.mat');
        
        
        save(new_data_name,'data_ramp','fitted_data','dwell_time_result','name_save');                                                %同时保存修正的Z信息和小波滤波的Z信息
        
        
    end
    % 循环完成，关闭文件。
    
    
end




















