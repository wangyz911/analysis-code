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
% 长度修正项
DNA_z_position_modi = (DNA_z_position_modi -0.5);

DNA_z_wavelet=sigDEN(DNA_z_position_modi);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
plot(time(start_number:end_number),force_zmag_che(magnet_z_position(start_number:end_number)));
xlabel('Time(min)');ylabel('Force(pN)');

%%  利用find函数找出绷紧态区间的数据，并且分段,由于代码原因，最后一段提不出来，可选择测量结束是人工再提到-0.3
%找出绷紧态, 注意zmag值都是负的，要用加号
%绷紧态坐标，使用代码前需要按实际情况修改
tensin_position = -0.2980 ;
tension_index = find(abs(magnet_z_position(start_number:end_number) - tensin_position) < 0.002);

%对绷紧态进行差分，差分数来大于1的坐标点就是断点
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
%预设置结果矩阵，第一列为折叠态，第二列为展开一步的状态，完全展开态不计入
    lifetime = zeros(segment_number,4);
%% 分别对每个态进行数据处理，并保存结果
%询问是否进行寿命统计的处理
disp('是否进行寿命估计？')
yes_lifetime = input('是或者否','s');
if yes_lifetime == '1' 
    
    %可选择从第几段开始分析
    disp('从第几段开始进行寿命估计？')
yes_segment = input('第几段 = ','s');

start_segment_num = round(str2double(yes_segment));
%起点之前的都作0处理。
% lifetime(1:start_segment_num,:) = 0;
    
    for i = start_segment_num : segment_number
        %按zmag坐标索引出Z的轨迹
        data_tension = DNA_z_position_modi(start_end_number(i,1):start_end_number(i,2));
        N = size(data_tension,1);
        % 开始使用二分法迭代，得到全局最优的J
        search_result = J_search(data_tension,0.7);
        %得到step的位置和个数
        step_position = find(search_result==1);
        step_count = size(step_position,1);
        % 根据找到的step位置得到拟合曲线
        fitted_data = get_fitted_data(data_tension,step_position);
        %对拟合曲线作图，为选值做准备
        figure;
        plot(1:N,data_tension,1:N,fitted_data,'LineWidth',2);
        %看图决定是否估计，如果图像不好就弃掉，如果好进行估计
        disp('是否进行寿命估计？')
        disp(num2str(i))
        yes_or_no = input('是-1，否-0 = ','s');
        if yes_or_no == '1'
            disp('取点说明，请取第一点为down 和mid的阈值，第二点为mid 和up 的阈值，并使第二点x坐标作为搜索的边界,如果只有两个态，使第二点低于第一点')
            [threshold_x,threshold_y] = ginput(2);
            %提取down态的寿命，存入结果矩阵
            down_part = find(fitted_data < threshold_y(1,1));
            down_part_modi = down_part( down_part < floor(threshold_x(1,1))) ;
            lifetime(i,1) = size(down_part_modi,1);
            %计算第一次跃变的高度，保存在第三列
            lifetime(i,3) = fitted_data(floor(threshold_x(1,1))) - fitted_data(max(down_part_modi));
            %提取mid态的寿命，存入结果矩阵
            mid_part = find(fitted_data > threshold_y(1,1) & fitted_data < threshold_y(2,1));
            mid_part_modi = mid_part(mid_part < floor(threshold_x(2,1)) & mid_part > max(down_part_modi));
            lifetime(i,2) = size(mid_part_modi,1);
            %计算第二次跃变的高度(如果有的话)，保存在第四列
            if isempty(mid_part) == 0
                lifetime(i,4) = fitted_data(floor(threshold_x(2,1))) - fitted_data(max(mid_part));
            end
        end
    end
    
% 提取完一根数据的所有结果后，保存结果，如果是二态过程，则第二列数据无意义，不采用即可
disp('how many states ?')
states = input('二态过程或者三态过程 states = ','s');
if states == '3'
    
    lifetime_name = strcat('lifetime3',name_save,'(',num2str(tensin_position),')');
    save(strcat(lifetime_name,'.mat'), 'lifetime');
elseif states == '2'
    lifetime_name = strcat('lifetime2',name_save,'(',num2str(tensin_position),')');
    save(strcat(lifetime_name,'.mat'), 'lifetime');
else
    disp('并没有这样的功能');
end
close all;
end


