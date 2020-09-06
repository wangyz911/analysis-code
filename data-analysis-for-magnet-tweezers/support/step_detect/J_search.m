function[ step_position ] = J_search(data_z,n)
%基于罚函数的step search 方法,增加一个可调参数n 来控制罚函数的惩罚力度
weight = n;
%获取数据的大小
data_size = size(data_z,1);
%建立一个全局变量来保存step的位置信息
global STEP_POSITION;

STEP_POSITION = zeros(data_size,1);
%利用函数进行递归搜索
local_step_search(data_z, 1 , weight);
%输出搜索结果
search_result = STEP_POSITION;
%得到step的位置和个数
step_position = find(search_result==1);
end

function local_step_search(data ,start_point , n)
%全局变量在任何一个函数中使用时都要先声明一遍
global STEP_POSITION;
%获取数据的大小，为搜索做准备
data_whole_size = size(data,1);
step_count = 0 ;
    %计算未分step之前的罚函数,作为初始J值
J_min = (size(data,1)+step_count * n )*var(data);

%预设置判定的逻辑变量，分step时为1，预设为0;
better = 0;
if data_whole_size <= 1
    %只有一个点，结束

else
    %计算未分step之前的罚函数

    %分step，count + 1
    step_count = step_count + 1 ;
    %搜索step的分割点,根据实际情况每次增加多个点可以极大缩短运行速度
    for k = 2:3:data_whole_size
        data_A = data(1:(k-1));
        data_B = data(k:end);
%         J_A = (size(data_A,1)+ step_count * 9 * n)*var(data_A);
%         J_B = (size(data_B,1)+ step_count * 9 * n)*var(data_B);
        J_A = (size(data_A,1)+ step_count * n)*var(data_A);
        J_B = (size(data_B,1)+ step_count * n)*var(data_B);
        J_step = J_A + J_B;
        if J_step < J_min
            
            %判定搜索到更好的step点,结束循环，从切点进行分割开始迭代
            better = 1;
            %将轨迹一分为2，第一段的起点与之前起点一致，第二段起点为step在总的序列上的位置
            step_point = k;
            %新发现的step点在总序列上的坐标
            step_position_temp = k+start_point-1;
             J_min=J_step; %判断估计的位置是否是全局最优。

        end
    end
        %将step 出现的位置标记在结果矩阵中。
        if better == 1
            STEP_POSITION (step_point+start_point-1) = 1;
            % 对结果进行迭代
            local_step_search(data(1:(step_point-1)),start_point,n);
            local_step_search(data(step_point:data_whole_size),step_position_temp, n);
        end

            
        
    
    
        
end
end

