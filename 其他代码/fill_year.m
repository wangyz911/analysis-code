% 先运行这句话，创建一个变量，把年份数据粘贴进去（拆分单元格之后再粘），空白会默认用0补上

year_data = [];

year_data_cut = year_data(:,4:(end));
%  后面直接执行到%%%%%%%%%%%
y_size = size(year_data_cut,2);
p_size = size(year_data_cut,1);
year_new = zeros(p_size,y_size);
for j = 1:p_size
    
for i = 1:y_size
    if year_data_cut(j,i)
        value = year_data_cut(j,i);
    end
        year_new(j,i) = value;
end
end

%%%%%%%%%%%%%%%%%%%%

% 创建一个元胞，把年份前面的东西按顺序写进去，比如GDP什么的，注意粘的时候点右键，选择粘贴excel数据
str = cell(10,1);
% 写好str后可以删掉上面这句，另存为str后用 load str；
% 后面的一口气执行就行惹
final = cell(p_size,y_size);
y = year_new(1,1);
j=1;
for p = 1:p_size
    
    for i = 1:y_size
        
        if year_new(p,i)==y
            if j>size(str,1)
                continue;
            end
            final{p,i}=strcat(str(j),num2str(year_new(p,i)));
            j=j+1;
        else
            j=1;
            final{p,i}=strcat(str{j},num2str(year_new(p,i)));
            y = year_new(p,i);
            j=j+1;
        end
       
    end
end



    