function [ step_position_bool ] = mixed_chi_square(time_series,n)
%mixed_chi_square is a mixed method searching for potential steps existing in the data
%of G4 series.
%n是一个参数，调节拟合的程度……


%获取数据的大小
data_size_array=size(time_series);
data_size=data_size_array(1,1);

global STEP_POSITION_UPDATING; %建立一个全局的变量，用来储存step的位置，有step的后一个数据点为1，其余为0。

STEP_POSITION_UPDATING=zeros(data_size,1);

data_std=std(time_series);




local_search_step(time_series,1,data_std/n);




step_position_bool=STEP_POSITION_UPDATING;

end


function local_search_step(time_series_temp,start_point,sigma)
%一个用于递归的子函数。先找到一个位置，然后把数据分为两段，对前面一段与后面一段均调用自身。

global STEP_POSITION_UPDATING;


temp_size_array=size(time_series_temp);
temp_size=temp_size_array(1,1);

evaluation_last=0;

if temp_size==1;
    step_existence=0;%如果只有一个点，结束。
elseif temp_size>=2
        
        mean_whole_temp=mean(time_series_temp);
        evaluation_last=sum((time_series_temp-mean_whole_temp).^2);
        step_existence=0;
        
        for i=2:temp_size;
            mean_forward_temp=mean(time_series_temp(1:(i-1)));
            mean_backward_temp=mean(time_series_temp(i:temp_size));
            evaluation_forward_temp=sum((mean_forward_temp-time_series_temp(1:(i-1))).^2);
            evaluation_backward_temp=sum((mean_backward_temp-time_series_temp(i:temp_size)).^2);
            evaluation_temp=evaluation_forward_temp+evaluation_backward_temp+9*sigma^2;%估计每个位置的评价。
            
            if evaluation_temp<evaluation_last;
                step_existence=1;
                step_position_temp=i;
                evaluation_last=evaluation_temp;%判断估计的位置是否是全局最优。
            end
        end  
        
        if step_existence==1

        STEP_POSITION_UPDATING(start_point+step_position_temp-1)=1;
        
        local_search_step(time_series_temp(1:step_position_temp-1),start_point,sigma);
        local_search_step(time_series_temp(step_position_temp:temp_size),start_point+step_position_temp-1,sigma);
        %如果找到step，则对前后两段分别递归。
        end
        
        
end







end
