% 该脚本的功能是将某加载率的拉伸曲线计算出力值并画出FE 曲线。

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
[ ~,x_pos_ramp,y_pos_ramp,DNA_z_position ] = read_pico3( fid );
% %一维情况，仅输出Z。
% [ DNA_z_position ] = read_pico1( fid );

% 读取参考小球的XYZ信息
disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。

[ ~,x_pos_ramp_ref,y_pos_ramp_ref,ref_DNA_z_position ] = read_pico3( fid );

% [ ref_DNA_z_position ] = read_pico1( fid );

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

%% data show
x_pos_ramp_modi = x_pos_ramp - x_pos_ramp_ref;
y_pos_ramp_modi = y_pos_ramp - y_pos_ramp_ref;

% 消除漂移, 并确定Z轴0点，用前5000:15000个点的均值来确定Z值零点, 要确保弛豫时间的帧数大于这个值。
DNA_z_position_no_shift=DNA_z_position - ref_DNA_z_position;
% zero_point_index = find(magnet_z_position(1:20000) == -1.998);
% zero_point_size = size(zero_point_index,1)-5000;
% zero_point = mean(DNA_z_position_no_shift(zero_point_index(zero_point_size:end)));
% shift 值，只有在修图时才用
DNA_z_shift =0;
% DNA_z_position_modi = DNA_z_position_no_shift - zero_point + DNA_z_shift;
DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);

number=size(DNA_z_position_modi,1);

time=(1:number)./3600;                                                   %时间单位由帧转换到分钟
plot(DNA_z_position_modi);
% 在弛豫的位置做个标记，方便选择区间
hold on
relax_marker = zeros(size(relax_pos,1),1);
plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
hold off
disp('请选择合适的区间')
if input('输入1选择区间','s')=='1'
    disp('在这儿停顿~');

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
% name_save=FileName(13:name_length-3);
name_save=FileName(5:(name_length-3));


%% 在这里修改后缀，省的保存数据后一个个改
    ramp_th = '_1';
    name_save = strcat(name_save,ramp_th);
 

%% eliminate the effects of drifting.
figure('Name',name_save);

% 绘制出ref球的轨迹，用来判断跃变的可靠性。
DNA_z_ref = sigDEN5(ref_DNA_z_position);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'k');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
plot(time(start_number:end_number),(ref_DNA_z_position(start_number:end_number)-0.1)*1000,'g');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
% 画出磁铁的运动轨迹
plot(time(start_number:end_number),magnet_z_position(start_number:end_number),'k');
zmag_ramp = magnet_z_position(start_number:end_number);
xlabel('Time (min)');ylabel('Zmag (mm)');

%% 选择一个ramp过程进行处理
%询问是否处理force ramp 曲线
disp('是否分析 force ramp 曲线？')
yes_ramp = input('是或者否','s');
if yes_ramp == '1'
    % 首先保存图片的tif 格式
    fig_name = strcat(name_save,'.fig');
    saveas(gcf,fig_name);
%     %%%%%%%%%%%% 不固定步长的版本
%     % 载入恒定加载率的zmag位置数组
%     load z_mag_series.mat;
%     % 按磁镊磁铁的尿性，加0.002作为修正
%     z_mag_series = z_mag_series+0.002;
%     data_ramp = DNA_z_position_modi(start_number:end_number);
%     ext_curve = zeros(size(z_mag_series));
%     % 计算均值，即extension curve
%     for i =1:size(z_mag_series,1)
%         ext_curve(i)= mean(data_ramp(abs(zmag_ramp-z_mag_series(i))< 0.0015))*1000;
%         
%     end
% 
%     force_curve = force_zmag_che(z_mag_series, 0.016);
    %%%%%%%%%%% 固定步长的版本
    % 参数设置
    stepsize= 0.002;
    zmag_start=magnet_z_position(start_number);
    zmag_end = magnet_z_position(end_number);
    % 输入DNA分子长度，以作Z值上的修正
    disp('please input the length of DNA (um)');
    DNA_length = input('DNA length = ','s');
    DNA_Z_shift = str2double(DNA_length) - max(DNA_z_position_modi(start_number:end_number));
    
    data_ramp = DNA_z_position_modi(start_number:end_number) + DNA_Z_shift;   
    
    %提取展开数据
    % 计算均值，即extension curve,均值的效果不好，考虑多采些点。
%     interp_num = 20;
    [ ext_curve,zmag_i ] = ramp_ext_mean( data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);
    bead_r = 0.5; % 磁球半径0.5微米
    ext_curve_F = ext_curve+bead_r;
    [force_curve_y,dy2] = ramp_force_mean( ext_curve_F,y_pos_ramp_modi,zmag_ramp,zmag_start,zmag_end,stepsize );
    [force_curve_x,dx2] = ramp_force_mean( ext_curve_F,x_pos_ramp_modi,zmag_ramp,zmag_start,zmag_end,stepsize );


%% 作图与保存数据
    figure;
    plot_size = min(size(ext_curve,1),size(force_curve_y,1));
    ext_curve = ext_curve(1:plot_size);
    force_curve_y = force_curve_y(1:plot_size)';
    plot(ext_curve,force_curve_y,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title(name_save);
    FE_name = strcat(name_save,'_FE.fig');
    saveas(gcf,FE_name);
    force_ramp_name = strcat('force_ramp_2G4_',name_save);
    save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve_x','force_curve_y','zmag_i','dy2','dx2');

    
end


end