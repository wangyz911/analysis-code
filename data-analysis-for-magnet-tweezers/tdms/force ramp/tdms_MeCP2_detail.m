% 本脚本是专门针对于MeCP2 诱导的染色质纤维结构展开十分迅速的情况，用于将展开瞬间放大，并将多条展开曲线叠在一起观察规律的。
% 可能更准确一些，但是会给实际计算 zmag 造成一些困难，因此最好还是采用单指数拟合。
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
time=(1:number)./12000;                                                   %时间单位由帧转换到分钟,200Hz时是12000帧，注意！

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
    ramp_th = '_4R';
    name_save = strcat(name_save,ramp_th);
    
%% 下面对截取的片段进行画图，并保存数据
%% force-extension 分析阶段
% 提取计算力值需要的数据区间, 如果是反向的，将数据也倒过来,注意 start 和end 点也要颠倒一下，以免顺序错位
    disp('Forward or Reverse?');
    forward = str2double(input('1=forward, 0 = reverse ','s'));
    if forward ==0
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number))*1000;
        zmag_ramp = flipud(magnet_z_position(start_number:end_number));
        zmag_start=magnet_z_position(end_number);
        zmag_end = magnet_z_position(start_number);

    else
        data_ramp = DNA_z_position_modi(start_number:end_number)*1000;
        zmag_ramp = magnet_z_position(start_number:end_number);
        zmag_start=magnet_z_position(start_number);
        zmag_end = magnet_z_position(end_number);

    end
    save_name = strcat(name_save,'_detail',ramp_th,'.mat');
save(save_name,'data_ramp','zmag_ramp','name_save','ramp_th','forward');


 
end
