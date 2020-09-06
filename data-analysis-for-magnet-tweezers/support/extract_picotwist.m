% G4 data analysis
% 该脚本的功能是将某加载率的拉伸曲线计算出力值并画出FE 曲线。

close all;

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
[ ~,x_pos,y_pos,DNA_z_position ] = read_pico3( fid );
% %一维情况，仅输出Z。
% [ DNA_z_position ] = read_pico1( fid );

% % 读取参考小球的XYZ信息
% disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
% [FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
% file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
% fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
% 
% [ ~,x_pos_ref,y_pos_ref,ref_DNA_z_position ] = read_pico3( fid );
% 
% % [ ref_DNA_z_position ] = read_pico1( fid );

%读取磁铁数据
disp('---------------三、读取磁铁z方向移动的数据：--------------------------')
[FileName3,PathName3] = uigetfile('.gr','磁铁移动的数据文件');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
% 读取磁铁运动文件，数据顺序分别是，帧序列，磁铁位置，旋转，焦平面。
[ ~,magnet_z_position,~,~ ] = read_pico3( fid );
% 找到弛豫的区间，方便标记
relax_pos = find(magnet_z_position == -1.998);
% %一维情况，仅输出magnet position。
% [ DNA_z_position ] = read_pico1( fid );

%%data show
number_array=size(DNA_z_position);
number=number_array(1,1);
time=(1:number)./60./60;                                                   %时间单位由帧转换到分钟
plot(DNA_z_position);
[start_number,start_y]=ginput(1);
start_number=floor(start_number);
if start_number<1
    start_number=1;
end
[end_number,end_y]=ginput(1);                                          %鼠标取点设置断点  ？
end_number=floor(end_number);                                          %向下取整
if end_number>number
    end_number=number;
end
name_length=size(FileName,2);
name_save=FileName(13:name_length-3);
figure('Name',name_save);


%% eliminate the effects of drifting.
% DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
% DNA_x_modi = x_pos - x_pos_ref;
% DNA_y_modi = y_pos - y_pos_ref;

DNA_z_position_modi=DNA_z_position;
DNA_x_modi = x_pos;
DNA_y_modi = y_pos;

DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number),'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number),'r');
xlabel('time(min)');ylabel('z_position_modi');
hold off
subplot(2,1,2);
plot(time(start_number:end_number),magnet_z_position(start_number:end_number));
xlabel('time(min)');ylabel('magnet');
% subplot(3,1,3)
% plot(time(start_number:end_number),fit_DNA(start_number:end_number));
% xlabel('time(min)');ylabel('z_position_filt');



clear;
close all;
disp('###########################程序处理的流程############################')

% 读取数据球的信息
disp('---------------一、读取小球XYZ的数据：-------------------------------')
[FileName,PathName] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName,FileName);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
data = read_picoN( fid ,6);