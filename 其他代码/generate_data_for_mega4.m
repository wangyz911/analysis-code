% 本脚本用来将矩阵数据变成 Mega4 所需要的数据格式。

%% 首先创建一个矩阵，把数据粘贴进来
data = unnamed;
% 创建一个矩阵来容纳城市名称
data_name = cell(1,1);
% 然后创建一个txt 文件,
fileID = fopen('data_for_mega4.txt','w');
fileID2 = fopen('index_name_for_mega4.txt','w');
% 统计矩阵的大小作为循环次数
N = size(data,1);

for i = 1:N 
    fprintf(fileID,'[%d]',i);
    fprintf(fileID2,'[%d] ',i);
    if i==1
        fprintf(fileID2,'#%s\r\n',data_name{i});
    else
        fprintf(fileID2,'#%s\r\n',data_name{i});
    for j = 1:(i-1)
        fprintf(fileID,'%4.4f ',data(i,j));
    end
    end
    fprintf(fileID,'\r\n');
end
fclose(fileID);
fclose(fileID2);


        
        