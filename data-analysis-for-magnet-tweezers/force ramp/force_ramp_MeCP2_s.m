%本脚本用来将单个G4 DNA非平衡态force ramp的数据进行分段，并和力值作图，再做step上的拟合，最后记录下break point 的位置
% 本脚本用于处理MeCP2的简易版本

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
% %三维情况，输出参数分别是，帧序列，x，y,z。
% [ ~,~,~,DNA_z_position ] = read_pico3( fid );
%一维情况，仅输出Z。
[ DNA_z_position ] = read_pico1( fid );

% 读取参考小球的XYZ信息
disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。

% [ ~,~,~,ref_DNA_z_position ] = read_pico3( fid );

[ ref_DNA_z_position ] = read_pico1( fid );

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
% 消除漂移, 并确定Z轴0点，用前5000:15000个点的均值来确定Z值零点, 要确保弛豫时间的帧数大于这个值。
DNA_z_position_no_shift=DNA_z_position - ref_DNA_z_position;
% zero_point_index = find(magnet_z_position(1:20000) == -1.998);
% zero_point_size = size(zero_point_index,1)-50;
% zero_point = mean(DNA_z_position_no_shift(zero_point_index(zero_point_size:end)));
% shift 值，只有在修图时才用
DNA_z_shift = 0;
DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);

number_array=size(DNA_z_position_modi);
number=number_array(1,1);
time=(1:number)./3600;                                                   %时间单位由帧转换到分钟
plot(DNA_z_position_modi);
% % 在弛豫的位置做个标记，方便选择区间
% hold on
% relax_marker = zeros(size(relax_pos,1),1);
% plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
% hold off
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
    ramp_th = '_1F';
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

%索引出磁铁位置，并转换为力值
zmag_ramp = magnet_z_position(start_number:end_number);
% 此处采用车师兄的力值校准数据，因为加载率是以车师兄的编译程序设定的，280的球用280，myOne的球用zmag_che
force_ramp = force_zmag_che(zmag_ramp,0.016);
% semilogy(time(start_number:end_number),force_clamp);
plot(time(start_number:end_number),force_ramp);
xlabel('Time(min)');ylabel('Force(pN)');

%% 选择一个ramp过程进行处理
%询问是否处理force ramp 曲线
disp('是否分析 force ramp 曲线？')
yes_ramp = input('是或者否','s');
if yes_ramp == '1'
    % 首先保存图片的tif 格式
    fig_name = strcat(name_save,'.fig');
    saveas(gcf,fig_name);
    % 参数设置
    stepsize= 0.002;
    zmag_start=magnet_z_position(start_number);
   

    %按zmag坐标索引出Z的轨迹
    data_ramp = DNA_z_position_modi(start_number:end_number);
    % 计算ramp的时间刻度，因为时间步长，就定为秒吧。

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %提取展开数据
    % 计算均值，即extension curve
    zmag_end = magnet_z_position(end_number);
    ext_curve = clamp_ext_mean(data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);
    force_curve = force_zmag_m280(zmag_start:stepsize:zmag_end, 0.01);

    
    figure;
    plot_size = min(size(ext_curve,1),size(force_curve,2));
    ext_curve = ext_curve(1:plot_size);
    force_curve = force_curve(1:plot_size)';
    plot(ext_curve*1000,force_curve,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title(name_save);
    FE_name = strcat(name_save,'_FE.fig');
    saveas(gcf,FE_name);
    force_ramp_name = strcat('new',name_save);
    save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve');

    
end

end

