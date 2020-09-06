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
% saveas(gcf,strcat(name_save,'_origin','_',date,'.fig'));
% saveas(gcf,strcat(name_save,'_origin','_',date,'.tiff'),'tiffn');
% save (strcat('varible_',name_save,'_origin',date));

%% eliminate the effects of drifting.
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
fit_DNA=medfilt1(DNA_z_position_modi,20);
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
%%  F-E 分析
% 确认是否进行F_E分析
disp('---------------需要做F_E分析吗？0-不需要；1-需要')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不画
    new_file_name=strcat(PathName,name_save,'new_FE','_',date,'\');
    mkdir(new_file_name);                                                      %新建文件夹
    cd(new_file_name);                                                         %进入新建文件夹
    subplot(2,1,1);
    plot(DNA_z_position_modi(start_number:end_number),'DisplayName','DNA_z_position','YDataSource','DNA_z_position');grid on;
    hold on
    plot(DNA_z_wavelet(start_number:end_number),'r');
    ylabel('z');
    hold off
    subplot(2,1,2);
    plot(magnet_z_position(start_number:end_number),'LineWidth',1,'DisplayName','magnet_z_position','YDataSource','DNA_z_position');grid on;
    ylabel('magnet_z_position');
    %设定计算所需的初始常数，以及预设置矩阵
    disp('---------------请输入试验温度');
    T_str=input('T =','s');
    T = str2double(T_str);
    
    DNA_length=1.034;                                                           %定义L，轮廓长度，单位是微米
    Kb_multi_T=1.3806504e-2*( T + 273.15);
    %步长设置
    stepsize = 0.002;
    %如果是从绷紧到松弛，步长加负号
    disp('---------------UP OR DOWN ?');
    up_down=input('STATE =','s');
    if strcmp(up_down,'down')
        stepsize = -stepsize;
    end
    
    
    
    %     start_z = input('请给出F=1pN处的zmag值并输入 = ','s');
    %     start_z = '0.2';
    %     DNA_start = find(abs(magnet_z_position + str2double(start_z)) < 10e-3);
    DNA_z_position_cali = DNA_z_position_modi +1;
    deal_number=1;
    DNA_y_position_modi = DNA_y_position-ref_DNA_y_position;                     %跳过算力情况下补充定义y,假定y方向上没有漂移？
    %     DNA_x_position_modi=DNA_x_position-ref_DNA_x_position;                     %定义x
    
    
    %     fig=3;                                                                     %设定图像标号和子图标号
    %     subfig=1;
    force_number=1;                                                                  %总序号，力值曲线需要用
    
    %给出F_E分析的起点和终点
    disp('---------------请点击F_E统计的起点和终点');
    yes_or_no_string2=input('judge1=','s');                                    %*
    if yes_or_no_string2=='1'                                                  %此处是必要的停顿，否则取点函数会锁定到刚画出的图上，我们只能在总图上取点
        [step_data_x,step_data_y] = ginput(2);
        %得到所选起点和终点的值（x值不重要）
        step_first_y=magnet_z_position(floor(step_data_x(1,1))+start_number);                           %截取后的图像新坐标从0开始，而要读取的数据沿用了老的序列号，需要加上start_number才能读取正确信号。
        step_end_y=magnet_z_position(floor(step_data_x(2,1))+start_number);
        
        %初始磁铁位置等于起点的y坐标
        mean_mag = step_first_y(1,1);
        %预设置力值曲线的矩阵，大小由分析区间和台阶大小决定
        force_curve=zeros(ceil((step_end_y-step_first_y)/abs(stepsize)),6);                                                   %力值曲线，分别用来保存，力值，校准长度的力值，长度。
        %循环条件，用步长的正负来影响条件循环中不等号的方向，非常机智。
        while(mean_mag*stepsize < step_end_y*stepsize)
            %得到一个台阶的序号,注意这里应该考虑人为的分界，找到的台阶应在我们选取的范围内。
            step_mag = find(abs(magnet_z_position-mean_mag)<10E-3);
            step_mag = step_mag(step_mag < floor(step_data_x(2,1))+start_number & ...
                                step_mag > floor(step_data_x(1,1))+start_number);
            %得到序号对应的data_z, data_y ,磁铁位置
            
            step_y = DNA_y_position_modi(step_mag);
            step_z = DNA_z_position_cali(step_mag);
            %计算横向振动方差以及Z坐标均值
            y_cor = var_correction(step_y,T);
            %加上磁球的半径。
            z_mean = mean(step_z)+0.5;
            %利用公式计算力值
            step_force = Kb_multi_T * z_mean * 1.0e-3/y_cor;
            step_force2 = Kb_multi_T * z_mean * 1.0e-3/var(step_y);
            force_curve(force_number,1)=force_number;                      %force_curve第1列标明序号
            force_curve(force_number,2)=z_mean -0.5;                             %force_curve 第2列输入Z值，也就是extension，此处应减去磁球半径
            force_curve(force_number,3)=step_force;                             %第3列输入计算出的力值，即force
            force_curve(force_number,4)=mean_mag;                          %第4列输入Zmag
            force_curve(force_number,5)=step_force2;
            force_curve(force_number,6)=y_cor;
            force_curve(force_number,7)=var(step_y);
            %修改参数，进入下一循环
            mean_mag = mean_mag + stepsize;
            force_number = force_number + 1;
        end
    end
    %将得到的F-E曲线作图
    force_line = force_curve(:,3);
    extension_line = force_curve(:,2);
    %消除未赋值而为零的点
    force_line(force_line==0)=[];
    extension_line(extension_line==0)=[];
    %未校正对比图
    %作图
    figure;
    plot(extension_line ,force_line,'-*');
    title('force-extension');
    xlabel('extension');
    ylabel('force');
    %保存分析结果
    disp('是否保存相关数据')
    data_save = input('是1 否0  =','s');
    if data_save == '1'
        %判断后缀名
        if stepsize > 0
            routine = 'up';
        else routine = 'down';
        end
        %创建文件名,保存文件
        force_name = strcat('force_extension_',FileName(13:15),'_ref',FileName2(15:16),'_',routine,'.mat');
        save(force_name,'force_curve');                                     %保存力值-长度信息
        data_name = strcat('data_',FileName(13:15),'_ref',FileName2(15:16),'_',routine,'.mat');
        save(data_name,'DNA_y_position_modi','DNA_z_position_cali','magnet_z_position',...
            'force_curve','force_line','extension_line','T','stepsize','start_number','end_number','DNA_length');
        

    end
end







