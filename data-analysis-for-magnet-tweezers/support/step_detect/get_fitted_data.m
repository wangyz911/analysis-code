function [ fitted_data ] = get_fitted_data( data_z,step_position )
%本函数依据已知的数据轨迹和找到的step得到数据的step型拟合数据

%导入数据，确定一共有多少段
segment_number = size(step_position ,1)+1;
%预设置拟合结果矩阵
total_data_number = size(data_z,1);
fitted_data = zeros(total_data_number,1);
% 下面这个矩阵是1，中间一个向量，再加一个常数，相当于中间的向量收尾各加了一个数，step_segment_with_end最终是一个一维向量
step_segment_with_end = [1; step_position; total_data_number];
%依分段结果分别进行拟合
for i = 1:segment_number
    fitted_data(step_segment_with_end(i):step_segment_with_end(i+1))=mean(data_z(step_segment_with_end(i):step_segment_with_end(i+1)));
end


end

