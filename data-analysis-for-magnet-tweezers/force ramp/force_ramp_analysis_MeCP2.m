%本脚本用来将单个G4 DNA非平衡态force ramp的数据进行分段，并和力值作图，再做step上的拟合，最后记录下break point 的位置


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
[ ~,~,~,DNA_z_position ] = read_pico3( fid );
% %一维情况，仅输出Z。
% [ DNA_z_position ] = read_pico1( fid );

% 读取参考小球的XYZ信息
disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。

[ ~,~,~,ref_DNA_z_position ] = read_pico3( fid );

% [ ref_DNA_z_position ] = read_pico1( fid );

%读取磁铁数据
disp('---------------三、读取磁铁z方向移动的数据：--------------------------')
[FileName3,PathName3] = uigetfile('.gr','磁铁移动的数据文件');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
% 读取磁铁运动文件，数据顺序分别是，帧序列，磁铁位置，旋转，焦平面。
[ ~,magnet_z_position,~,~ ] = read_pico3( fid );

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
name_save=FileName(1:name_length-3);
figure('Name',name_save);


%% eliminate the effects of drifting.
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
% 绘制出ref球的轨迹，用来判断跃变的可靠性。
DNA_z_ref = sigDEN5(ref_DNA_z_position);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'k');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
plot(time(start_number:end_number),ref_DNA_z_position(start_number:end_number)*1000,'g');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
force_ramp = (force_zmag_m280(magnet_z_position(start_number:end_number)));
% semilogy(time(start_number:end_number),force_clamp);
plot(time(start_number:end_number),force_ramp);
xlabel('Time(min)');ylabel('Force(pN)');
%%  利用find函数找出force ramp 区间的数据，并且分段
disp('是否分段')
segment_yes = input('分段？','s');
if segment_yes == '1'
    
    
    
    %找出 force_ramp 态, 注意zmag值都是负的，要用加号
    %绷紧态坐标，可修改
    ramp_start = -1.998 ;
    stepsize= 0.002;
    step_num = 900;
    %找出磁铁在ramp起点值以上的部分，即ramp部分
    tension_index = find(magnet_z_position(start_number:end_number) - ramp_start > 0);
    
    %对ramp部分进行差分，差分数来大于1的坐标点就是不同区间的断点
    diff_tension_index = diff(tension_index);
    %得到断点坐标，注意这里是对diff的坐标，而diff（break_point）才是zmag中的坐标
    break_point = find(diff_tension_index>10);
    %提取每一段的长度
    segment_length = zeros(size(break_point,1),1);
    segment_length(1) = break_point(1);
    segment_length(2:end) = diff(break_point);
    %得到分段数，预制结果矩阵
    segment_number = size(break_point,1) + 1;
    start_end_number = zeros(segment_number,2);
    %对绷紧态的数据进行分段，分段的起点和终点保存在start_end_number矩阵中
    for i = 1:segment_number
        if i ==1
            start_end_number(i,1) = tension_index(1) + start_number;
            start_end_number(i,2) = start_end_number(i,1) + segment_length(i);
            %对第一段来说，起点是总起点，终点是第一个diff点（diff函数自动使得结果坐标左移一位）
            
        elseif i<segment_number
            %对中间段，第i段的起点是第i-1段终点加上对应的diff值,终点是第i段的起点加上这一段的长度diff(break_point)
            start_end_number(i,1) = start_end_number(i-1,2) + diff_tension_index(break_point(i-1));
            start_end_number(i,2) = start_end_number(i,1)+ segment_length(i);
        else
            start_end_number(i,1) = start_end_number(i-1,2) + diff_tension_index(break_point(i-1));
            start_end_number(i,2) = tension_index(end) + start_number;
        end
    end
    %减去首尾若干个点，消除一些振荡产生的坏点
    start_end_number(:,1) = start_end_number(:,1)-20;
    start_end_number(:,2) = start_end_number(:,2)-10;
    % 设定结果矩阵和加载率,这里保存跃变位置的Z值和F值，有时跃变有来回跳动，因此*24确保足够的空间。
    z_rupture_num = zeros(segment_number,1);
    ext_curve = zeros(segment_number,step_num);
    % 用于数有多少条轨迹的计数器。
    trajectory_count = 0;
    
    
    loading_rate = '0.2pN';
    %% 分别对每个ramp过程进行处理
    %询问是否处理force ramp 曲线
    disp('是否分析 force ramp 曲线？')
    yes_ramp = input('是或者否','s');
    if yes_ramp == '1'
        
        %可选择从第几段开始分析
        disp('从第几段开始进行分析？(第一次只能从头开始)')
        yes_segment = input('第几段 = ','s');
        
        start_segment_num = round(str2double(yes_segment));
        
        trajectory_count = 0;
        %figure 放在外面，解决不断要关闭图像页面的问题
        figure;
        for i = start_segment_num : segment_number
            %按zmag坐标索引出Z的轨迹
            data_ramp = DNA_z_position_modi(start_end_number(i,1):start_end_number(i,2));
            data_ref = ref_DNA_z_position(start_end_number(i,1):start_end_number(i,2));
            N = size(data_ramp,1);
            % 计算ramp的时间刻度，因为时间步长，就定为秒吧。
            ramp_time =(1:N)/60;
            %索引出磁铁位置，并转换为力值
            zmag_ramp = magnet_z_position(start_end_number(i,1):start_end_number(i,2));
            % 此处采用车师兄的力值校准数据，因为加载率是以车师兄的编译程序设定的
            force_ramp = force_zmag_m280(zmag_ramp);
            %用小波滤波平滑曲线
            data_ramp_d = sigDEN5(data_ramp);
            data_ref_d = sigDEN5(data_ref);
            %对拟合曲线作图，同时在下侧拟出力值
            subplot(2,1,1)
            plot(ramp_time,data_ramp,ramp_time,data_ramp_d);
            hold on
            plot(ramp_time,data_ref_d);
            hold off
            subplot(2,1,2)
            plot(ramp_time,force_ramp);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %看图决定是否估计，如果图像不好就弃掉，如果好进行估计
            %需要有一个是否处理的总开关
            disp(num2str(i))
            disp('good data ? ？')
            ramp_NO = num2str(i);
            fig_name = strcat(name_save,ramp_NO,'.fig');
            
            good_data = input('good or bad','s');
            if good_data =='1'
                % 首先保存图片的tif 格式
                saveas(gcf,fig_name);
                %然后是每一种数据是否记录
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %提取展开数据
                
                %                 yes_or_no = input('有几个展开 ','s');
                %                 n = round(str2double(yes_or_no));
                %                 %将展开个数统计到矩阵中
                %                 z_rupture_num = n;
                %                 trajectory_count = trajectory_count+1;
                % 计算均值，即extension curve

                zmag_start=magnet_z_position(start_number);
                zmag_end = magnet_z_position(end_number);
                ext_curve(i,:) = ramp_ext_mean(data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);
                force_curve = force_zmag_m280(zmag_start:stepsize:zmag_end);
                figure;
                plot(ext_curve,force_curve);
                %增加一个中途退出功能
            elseif strcmp(yes_or_no,'exit')
                break;
            end
            
        end
        
    end
    
    %% 提取完一根数据的所有结果后，保存结果
    %消除0元素，保存有用的结果。
    
    
    
    force_ramp_name = strcat('force_ramp_MeCP2_24NC_',name_save);
    save(strcat(force_ramp_name,'.mat'), 'ext_curve');
    
end
close all;


