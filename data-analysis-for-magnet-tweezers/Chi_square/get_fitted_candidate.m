function [ fitted_candidate ] = get_fitted_candidate(time_series,step_position)
%这是一个生成找到的step candidate的函数。

state_number=size(step_position,1)+1;

total_data_number=size(time_series,1);

fitted_candidate=zeros(total_data_number,1);

step_position_with_end=[1;step_position;total_data_number];

for i=1:state_number
    
    fitted_candidate(step_position_with_end(i):step_position_with_end(i+1))=mean(time_series(step_position_with_end(i):step_position_with_end(i+1)));
    
end




end

