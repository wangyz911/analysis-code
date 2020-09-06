%本脚本用来将单个G4 DNA非平衡态force ramp的数据进行分段，并和力值作图，再做step上的拟合，最后记录下break point 的位置


%非平衡态分析，基于二态数据，统计G4结构的寿命（持续时间）
%% -------------------------读取数据文件---------------------------
clear;
close all;
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
disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
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
disp('---------------三、读取磁铁z方向移动的数据：--------------------------')
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


%% eliminate the effects of drifting.
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
force_clamp = (force_zmag_che(magnet_z_position(start_number:end_number)));
semilogy(time(start_number:end_number),force_clamp);
xlabel('Time(min)');ylabel('Force(pN)');
%%  利用find函数找出force ramp 区间的数据，并且分段
%找出 force_ramp 态, 注意zmag值都是负的，要用加号
%绷紧态坐标，可修改
ramp_start = -0.948 ;
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
%减去首尾5个点，消除一些振荡产生的坏点
start_end_number(:,1) = start_end_number(:,1)-100;
start_end_number(:,2) = start_end_number(:,2)-10;
% 设定结果矩阵和加载率,这里保存跃变位置的z值，有时跃变有来回跳动，因此*10确保足够的空间。
z_NI = zeros(segment_number*10,1);
z_IN = z_NI;
% 设定保存jump步长的结果矩阵
step_NI = zeros(segment_number*10,1);
step_IN = step_NI;

%j 是数据存储的序号，与i同起点但不同增速，增速取决于跃变数
J_record = zeros(segment_number*10,2);
% 用于数有多少条轨迹的计数器。
trajectory_count = 0;
j_NI = 1;
j_IN = 1;

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
        N = size(data_ramp,1);
        %索引出磁铁位置，并转换为力值
        zmag_ramp = magnet_z_position(start_end_number(i,1):start_end_number(i,2));
        % 此处采用车师兄的力值校准数据，因为加载率是以车师兄的编译程序设定的
        force_ramp = force_zmag_che(zmag_ramp);

        %用小波滤波平滑曲线
        data_ramp_d = sigDEN5(data_ramp);
        %对拟合曲线作图，同时在右侧拟出力值
        subplot(1,2,1)
        plot(1:N,data_ramp,1:N,data_ramp_d,'LineWidth',2);
        subplot(1,2,2)
        plot(1:N,force_ramp,'LineWidth',2);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %看图决定是否估计，如果图像不好就弃掉，如果好进行估计
        %需要有一个是否处理的总开关
        disp(num2str(i))
        disp('good data ? ？')
        
        good_data = input('good or bad','s');
        if good_data =='1'
        %然后是每一种数据是否记录                    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %提取NI部分的展开数据
        disp('是否有未记录的NI展开？')
        disp(num2str(i))
        disp('NI')
        yes_or_no = input('有几个NI ','s');
        n = round(str2double(yes_or_no));
        %提取展开位置的x坐标，换算成zmag，后期统一换算成力值，存入结果矩阵
        if yes_or_no == '0'
            z_NI(j_NI) = 0;
            step_NI(j_NI) = 0;
            j_NI = j_NI+1;
        %增加一个中途退出功能
        elseif strcmp(yes_or_no,'exit')
              break;
        else
            trajectory_count = trajectory_count+1;
            [jump_x,jump_y] = ginput(n);
            %提取展开瞬间的Z轴位置，存入结果矩阵
            for t =1:n
                jump = round(jump_x(t,1));
                z_NI(j_NI+t-1) = zmag_ramp(jump);
                % 增加了对步长的统计，要求采jump点时点在展开点上沿。
                step_NI(j_NI+t-1) = mean(data_ramp_d(jump+5)) - mean(data_ramp_d((jump-10)));
            end
            j_NI = j_NI+n;
            
        end
        J_record(i,1) = n;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 紧接着提取IN 展开的数据
        disp('是否有未记录的IN展开？')
        disp(num2str(i))
        disp('IN')
        yes_or_no = input('有几个IN ','s');
        n2 = round(str2double(yes_or_no));
        %提取展开位置的x坐标，换算成zmag，后期统一换算成力值，存入结果矩阵
        if yes_or_no == '0'
            z_IN(j_IN)=0;
            j_IN = j_IN+1;
        %增加一个中途退出功能
        elseif strcmp(yes_or_no,'exit')
              break;
        else
            [jump_x,~] = ginput(n2);
            %提取展开瞬间的力值，存入结果矩阵
            for t =1:n2
                jump = round(jump_x(t,1));
                z_IN(j_IN+t-1) = zmag_ramp(jump);
                step_IN(j_IN+t-1) = mean(data_ramp_d(jump:(jump+3))) - mean(data_ramp_d((jump-5):(jump-2)));
            end
            j_IN = j_IN+n2;
            
        end
        J_record(i,2) = n2;
 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %跳出循环的总开关
        elseif strcmp(good_data,'exit')
              break;

        end
    end
    
%% 提取完一根数据的所有结果后，保存结果
    %消除0元素，保存有用的结果。
    z_NI(z_NI==0)=[];
    z_IN(z_IN==0)=[];
    step_NI(step_NI==0)=[];
    step_IN(step_IN==0)=[];
    

    force_ramp_name = strcat('force_ramp_NI_G4_',name_save,'_',loading_rate);
    save(strcat(force_ramp_name,'.mat'), 'z_NI','z_IN','J_record','trajectory_count','step_NI','step_IN');


close all;
end

