function [ step_info ] = get_step_info( data_z,step_position )
%该函数在同时指导拟合曲线和原始曲线的情况下， 计算得到各种step的信息,info中第一列是该台阶的长度（驻留时间），第二列是该台阶的高度
%包括step的长度，值

%预设置结果矩阵
info_size = size(step_position,1);
step_info = zeros(size(step_position,1)+1,2);
%首先交错相减得到step的长度信息(也可以使用diff函数)
temp_length1 = zeros(info_size,1);
temp_length1(2:end) = step_position(1:(info_size-1));
temp_length2 = step_position(1:info_size);
step_info(1:info_size,1) = temp_length2-temp_length1 ;
%最后一段尾巴的长度为数据总长减去最后一个step的坐标
step_info(info_size+1,1) = size(data_z,1) - step_position(info_size);
%然后通过均值得到拟合台阶的值
for i = 1:(info_size+1)
    if i<= info_size
        step_info(i,2) = median(data_z((temp_length1(i)+1):temp_length2(i)));
    else
        step_info(i,2) = median(data_z(step_position(info_size):end));
    end
end


end

