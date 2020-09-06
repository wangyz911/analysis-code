function local_step_search(data_z,start_point, N)
%获取数据的大小，为搜索做准备
data_size = size(data_z,1);

step_count = 0 ;
%预设置判定的逻辑变量，分step时为1，预设为0;
better = 0;
if data_size == 1
    %只有一个点，结束

else
    %计算未分step之前的罚函数
    J_min = N*std(data_z)^2 + step_count * 9 * var(data_z);
    %分step，count + 1
    step_count = step_count + 1 ;
    %搜索step的分割点
    for k = 2:data_size
        data_A = data_z(1:k);
        data_B = data_z(k+1:end);
        J_A = size(data_A,1)*std(data_A)^2+ step_count * 9 * var(data_A);
        J_B = size(data_B,1)*std(data_B)^2+ step_count * 9 * var(data_B);
        J_step = J_A + J_B;
        if J_step < J_min
            %判定搜索到更好的step点
            better = 1;
            %将轨迹一分为2，第一段的起点与之前起点一致，第二段起点为第一段起点加上step点
            step_point = k;
            start_point2 = k+start_point;
            J_min=J_step; %判断估计的位置是否是全局最优。
                
        end
    end
        %将step 出现的位置标记在结果矩阵中。
        if better == 1
            STEP_DETECT (step_point) = 1;
            % 对结果进行迭代
            local_step_search(data_A,start_point,N);
            local_step_search(data_B,start_point2,N);
        end

            
        
    
    
        
end
end

