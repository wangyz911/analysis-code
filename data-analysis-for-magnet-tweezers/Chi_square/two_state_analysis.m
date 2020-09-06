function [ upper_state_size,lower_state_size ] = two_state_analysis( time_series,step_position,step_length )
%这个函数可以对于两态的情况，可以获得上下两态的驻留帧数，根据频率可以进一步计算驻留长度及其分布。

total_data_number=size(time_series,1);
step_position_with_end=[1;step_position;total_data_number];





end

