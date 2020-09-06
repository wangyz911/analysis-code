% G4 data analysis
%% -------------------------读取数据文件---------------------------
clear;close all;
disp('###########################程序处理的流程############################')
disp('---------------一、读取小球XYZ的数据：-------------------------------')
[FileName,PathName] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName,FileName);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
standard_string='abcd';      %为什么要四个字符
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';                                 %4个一组依次读取文件中的字符，与strcmp结合用来判断数据起始点'-a!'
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);                                                                %去掉字符头，开始读取数据
DNA_x_position_array=textscan(fid,'%f%f');                                 %开始读取数据,生成一个两个列向量构成的元胞矩阵，第一个列向量是帧序列，第二个是位置信息
frame_seriels=DNA_x_position_array{1,1};                                   %读取DNAx方向帧序列
DNA_x_position=DNA_x_position_array{1,2};                                  %读取x方向位置信息
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');  
end
fgetl(fid);
DNA_y_position_array=textscan(fid,'%f%f');                                 %同理，读取y方向信息
DNA_y_position=DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');  
end
fgetl(fid);
DNA_z_position_array=textscan(fid,'%f%f');                                 %读取z方向数据
DNA_z_position=DNA_z_position_array{1,2};  
% 读取参考小球的XYZ信息
disp('---------------一、读取参考小球XYZ的数据：-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
standard_string='abcd';      %为什么要四个字符
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';                                 %4个一组依次读取文件中的字符，与strcmp结合用来判断数据起始点'-a!'
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);                                                                %去掉字符头，开始读取数据
ref_DNA_x_position_array=textscan(fid,'%f%f');                                 %开始读取数据,生成一个两个列向量构成的元胞矩阵，第一个列向量是帧序列，第二个是位置信息
ref_frame_seriels=ref_DNA_x_position_array{1,1};                                   %读取DNAx方向帧序列
ref_DNA_x_position=ref_DNA_x_position_array{1,2};                                  %读取x方向位置信息
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');  
end
fgetl(fid);
ref_DNA_y_position_array=textscan(fid,'%f%f');                                 %同理，读取y方向信息
ref_DNA_y_position=ref_DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');  
end
fgetl(fid);
ref_DNA_z_position_array=textscan(fid,'%f%f');                                 %读取z方向数据
ref_DNA_z_position=ref_DNA_z_position_array{1,2};  
%读取磁铁数据
disp('---------------二、读取磁铁z方向移动的数据：--------------------------')
[FileName3,PathName3] = uigetfile('.gr','磁铁移动的数据文件');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
magnet_z_position_array=textscan(fid,'%f%f');                              %读取磁铁在z方向移动的数据，包括帧序列信息。
frame_seriels_magnet=magnet_z_position_array{1,1};
frame_seriels_magnet_all=size(frame_seriels_magnet);
magnet_z_position=magnet_z_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
magnet_z_rotation_array=textscan(fid,'%f%f');                              %读取磁铁在Z方向扭转的数据
magnet_z_rotation=magnet_z_rotation_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
magnet_focus_array=textscan(fid,'%f%f');                                   %读取磁镊焦平面位置的数据
magnet_focus=magnet_focus_array{1,2};                                      %以上过程复用频繁，可以讲读数据部分写成函数文件。
%%data show
number_array=size(DNA_z_position);
number=number_array(1,1);
time=(1:number)./60./60;                                                   %设置时间步长
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
% subplot(2,3,1);
% plot(time(1:end_number),DNA_x_position(1:end_number));
% xlabel('time(min)');ylabel('x');
% subplot(2,3,2);
% plot(time(1:end_number),DNA_y_position(1:end_number),'m');
% xlabel('time(min)');ylabel('y');
% title(name_save);
% subplot(2,3,3);
% plot(time(1:end_number),DNA_z_position(1:end_number));
% xlabel('time(min)');ylabel('z');
% subplot(2,3,4);
% plot(time(1:end_number),magnet_focus(1:end_number));
% xlabel('time(min)');ylabel('focus');
% subplot(2,3,5);
% plot(time(1:end_number),magnet_z_rotation(1:end_number));
% xlabel('time(min)');ylabel('rotation');
% subplot(2,3,6);
% plot(time(1:end_number),magnet_z_position(1:end_number));
% xlabel('time(min)');ylabel('magnet');
saveas(gcf,strcat(name_save,'_origin','_',date,'.fig'));
saveas(gcf,strcat(name_save,'_origin','_',date,'.tiff'),'tiffn');
save (strcat('varible_',name_save,'_origin',date));

%% eliminate the effects of drifting.
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
fit_DNA=medfilt1(DNA_z_position_modi,20);
data_analysis=DNA_z_position_modi(start_number:end_number);
subplot(3,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number));
xlabel('time(min)');ylabel('z_position_modi');
subplot(3,1,2);
plot(time(start_number:end_number),magnet_z_position(start_number:end_number));
xlabel('time(min)');ylabel('magnet');
subplot(3,1,3)
plot(time(start_number:end_number),fit_DNA(start_number:end_number));
xlabel('time(min)');ylabel('z_position_filt');
%% 步长统计分析

disp('---------------需要做步长统计吗？0-不需要；1-需要')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不画
new_file_name=strcat(PathName,name_save,'new','_',date,'\');
mkdir(new_file_name);                                                      %新建文件夹
subplot(2,1,1);
plot(DNA_z_position_modi(start_number:end_number),'DisplayName','DNA_z_position','YDataSource','DNA_z_position');grid on;
ylabel('z');
subplot(2,1,2);
plot(magnet_z_position(start_number:end_number),'DisplayName','magnet_z_position','YDataSource','DNA_z_position');grid on;
ylabel('magnet_z_position');
%ylim([-1.1 -0.9]);
    yes_or_no2=1;
    deal_number=1;

fig=3;                                                                 %设定图像标号和子图标号
subfig=1;
while yes_or_no2==1                                                    %反复分段，直到分完
disp('---------------请点击步长统计的起点和终点');
yes_or_no_string2=input('judge1=','s');                                    %*
if yes_or_no_string2=='1'                                                  %此处是必要的停顿，否则取点函数会锁定到刚画出的图上，我们只能在总图上取点
[step_data_x,~] = ginput(2);
step_first=floor(step_data_x(1,1));
step_end=floor(step_data_x(2,1));
        if step_end>end_number
            step_end=end_number;
            yes_or_no2=0;
        end
% DNA_y_position_modi=DNA_y_position-ref_DNA_y_position;                     %跳过算力情况下补充定义y
data=DNA_z_position_modi(step_first:step_end);                             %同时提取修正的Z信息和小波滤波的Z信息
data_d=sigDEN(data);                                                       %指令化的三级小波滤波，须在建立文件夹后第一时间将sigDEN函数文件拷到该文件夹。

% data_input(:,2)=data_4_analysis;                                           %输入数据（是一种很有参考价值的写法）第一列为序号，第二列为数据
% data_input(:,1)=(1:size(data_4_analysis,1))';
new_data_name=strcat('data_',num2str(deal_number),'.mat');
new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');
cd(new_file_name);                                                         %改变当前路径至
figure(fig)
subplot(4,2,subfig);
plot(step_first:step_end,data,'b');hold on;
plot(step_first:step_end,data_d,'r');
subplot(4,2,subfig+1);
hist(data_d,100);
subfig=subfig+2;
if subfig==9
    fig=fig+1;
    subfig=1;
end
save(new_data_name,'data');                                                %同时保存修正的Z信息和小波滤波的Z信息
save(new_data_d_name,'data_d');                                            %存储并不等于写入，在载入上有着微妙的差别

% clear data_4_analysis;
% clear data_input;
deal_number=deal_number+1;
end
end
end

%[data, indexes,lijst,properties,initval]=Steps_Find(new_file_name);
%disp('请输入大概的台阶步数：');
%step_number_string=input('step_number=','s');
%step_number=str2double(step_number_string);
%dummy=Steps_Evaluate(data,indexes,lijst,properties,initval,step_number); 


















