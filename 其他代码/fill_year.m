% ��������仰������һ�����������������ճ����ȥ����ֵ�Ԫ��֮����ճ�����հ׻�Ĭ����0����

year_data = [];

year_data_cut = year_data(:,4:(end));
%  ����ֱ��ִ�е�%%%%%%%%%%%
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

% ����һ��Ԫ���������ǰ��Ķ�����˳��д��ȥ������GDPʲô�ģ�ע��ճ��ʱ����Ҽ���ѡ��ճ��excel����
str = cell(10,1);
% д��str�����ɾ��������䣬���Ϊstr���� load str��
% �����һ����ִ�о�����
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



    