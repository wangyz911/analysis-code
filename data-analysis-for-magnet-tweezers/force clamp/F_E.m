% 本脚本用老磁镊上的数据来计算F-E

close all;
%非平衡态分析，基于二态数据，统计G4结构的寿命（持续时间）
%% -------------------------读取数据文件---------------------------
clear;
close all;
disp('###########################程序处理的流程############################')

% 读取数据球的信息
disp('---------------一、读取小球XYZ的数据：-------------------------------')
[FileName,PathName] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName,FileName);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
%三维情况，输出参数分别是，帧序列，x，y,z。
[ ~,DNA_x_pos,DNA_y_pos,DNA_z_pos ] = read_pico3( fid );
% %一维情况，仅输出Z。
% [ DNA_z_position ] = read_pico1( fid );

% 读取参考小球的XYZ信息
disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。

[ ~,ref_DNA_x_pos,ref_DNA_y_pos,ref_DNA_z_pos ] = read_pico3( fid );

% [ ref_DNA_z_pos ] = read_pico1( fid );

%读取磁铁数据
disp('---------------三、读取磁铁z方向移动的数据：--------------------------')
[FileName3,PathName3] = uigetfile('.gr','磁铁移动的数据文件');
file=strcat(PathName3,FileName3);
fid=fopen(file, 'r');
% 读取磁铁运动文件，数据顺序分别是，帧序列，磁铁位置，旋转，焦平面。
[ ~,magnet_z_position,~,~ ] = read_pico3( fid );

% %一维情况，仅输出magnet position。
% [ DNA_z_position ] = read_pico1( fid );

%% data show

DNA_x_pos_modi = DNA_x_pos - ref_DNA_x_pos;
DNA_y_pos_modi = DNA_y_pos - ref_DNA_y_pos;
DNA_z_pos_modi = DNA_z_pos - ref_DNA_z_pos;


% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;


number=size(DNA_z_pos_modi,1);
time=(1:number)./3600;                                                   %时间单位由帧转换到分钟

plot(DNA_z_pos_modi);
% 在弛豫的位置做个标记，方便选择区间
% hold on
% relax_marker = zeros(size(relax_pos,1),1);
% plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
% hold off

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
name_save=strtok(FileName,'.');

%% 在这里修改后缀，省的保存数据后一个个改
    ramp_th = '_test';
    name_save = strcat(name_save,ramp_th);
    

%% force-extension 分析阶段
% shift 值 是用于将长度修正到较为合理的数值上，
mol_length = 3;
bead_r = 0.5;
DNA_z_shift = mol_length + bead_r - max(DNA_z_pos_modi(start_number:end_number));
DNA_z_pos_modi = DNA_z_pos_modi + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_pos_modi);
DNA_z_wavelet = DNA_z_wavelet';
% 提取计算力值需要的数据区间
data_ramp = DNA_z_pos_modi(start_number:end_number);
x_pos_ramp = DNA_x_pos_modi(start_number:end_number);
y_pos_ramp = DNA_y_pos_modi(start_number:end_number);
% y_pos_ramp_modi = y_pos_ramp/0.059*0.072;
zmag_ramp = magnet_z_position(start_number:end_number);
% 先画出轨迹图和 对应磁铁轨迹，询问是否要做F-E 分析。
figure('Name',name_save);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_pos_modi(start_number:end_number)*1000,'k');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
plot(time(start_number:end_number),zmag_ramp);
xlabel('Time(min)');ylabel('Zmag(mm)');
% 询问是否分析 F-E 曲线
disp('是否分析 force ramp 曲线？')
yes_ramp = input('是或者否','s');
if yes_ramp == '1'
    % 首先保存图片的tif 格式
    fig_name = strcat(name_save,'.fig');
    saveas(gcf,fig_name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 参数设置
    stepsize= 0.002;
    zmag_start=magnet_z_position(start_number);
    zmag_end = magnet_z_position(end_number);
    % 计算ramp的时间刻度，因为时间步长，就定为秒吧。
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %提取展开数据
    % 计算均值，即extension curve
    ext_curve = ramp_ext_mean(data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);


    [force_curve,dr] = ramp_force_mean( ext_curve,x_pos_ramp,y_pos_ramp,zmag_ramp,zmag_start,zmag_end,stepsize );
    
    figure;
    plot_size = min(size(ext_curve,1),size(force_curve,1));
    ext_curve = ext_curve(1:plot_size);
    force_curve = force_curve(1:plot_size);
    plot(ext_curve,force_curve,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title(name_save);
    FE_name = strcat(name_save,'_FE.fig');
    saveas(gcf,FE_name);
    force_ramp_name = strcat('force_ramp_MeCP2_24NC_',name_save);
    save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve','dr');

    
end

end

