function [ start_end_number,segment_number ] = data_separation_for_ramp( ramp_start, magnet_z_position, start_number )
%   本函数是数据分段脚本的函数形式，用于将每一次ramp实验的数据切分开。
%%  利用find函数找出force ramp 区间的数据，并且分段
%找出 force_ramp 态, 注意zmag值都是负的，要用加号
%绷紧态坐标，可修改
% ramp_start = -0.948 ;
%找出磁铁在ramp起点值以上的部分，即ramp部分
tension_index = find(magnet_z_position - ramp_start > 0);

%对ramp部分进行差分，排除机械抖动的小幅变化，差分数来大于10的坐标点一定是不同区间的断点
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


end

