% 数据两两相减并取绝对值，如果存在缺省值（已标记为-1），就继续缺省
% load data_12years
year = unique(cell2mat(data1(:,2)));
id = cell2mat(data1(:,1));
val = cell2mat(data1(:,6));
N = size(data1,1)/size(year,1);

minus =zeros(nchoosek(N,2)*size(year,1),4);
k=1;
for y = 1:size(year,1)
    offset = N * (y-1);
for i = (1+offset):((N-1)+offset)
    for j = ((i+1):N+offset)
        minus(k,3) = year(y);
        minus(k,1) = id(i);
        minus(k,2) = id(j);
        if ((val(i)>0)&&(val(j)>0))
        minus(k,4) = abs(val(i)-val(j));
        else
            minus(k,4) = -1;
        end
        k = k+1;
    end
    
end
% 
% save_name = strcat('机械率_',num2str(year(y)),'.mat');
% save(save_name,'minus');
end

xlswrite('for老公2.xlsx',minus(:,1),4,'A2:A1043975');
xlswrite('for老公2.xlsx',minus(:,2),4,'B2:B1043975');
xlswrite('for老公2.xlsx',minus(:,3),4,'C2:C1043975');
xlswrite('for老公2.xlsx',minus(:,4),4,'D2:D1043975');