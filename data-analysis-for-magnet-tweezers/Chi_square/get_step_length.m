function [ step_length, state_value, state_std] = get_step_length( time_series,step_position )
%这是一个得到每一步step大小的函数，顺便输出每个平台的均值，注意平台数比台阶数大1.

step_number=size(step_position,1);
state_number=step_number+1;

total_data_number=size(time_series,1);
step_position_with_end=[1;step_position;total_data_number];

step_length=zeros(step_number,1);
state_value=zeros(state_number,1);
state_std=zeros(state_number,1);


for i=1:state_number
    
    state_value(i)=mean(time_series(step_position_with_end(i):step_position_with_end(i+1)));
    state_std(i)=std(time_series(step_position_with_end(i):step_position_with_end(i+1)));
    
end

for i=1:step_number
    
    step_length(i)=state_value(i+1)-state_value(i);


end

end

