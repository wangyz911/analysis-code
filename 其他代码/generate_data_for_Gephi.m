% 本脚本用于生成符合Gephi 分析格式的数据

% 数据名（node）的话就不自己生成了，可以直接用excel 里的。
% 以下生成的主要是数据间连线需要的数据（edges）

%% 首先将数据粘贴进来

data = [];
N = size(data,1);
% 然后按照 source target weight 的顺序写入txt 文件；
fileID = fopen('data for Gephi edges.txt','w');
fprintf(fileID,'%s; %s; %s\r\n','source','target','weight');
for i = 2:N
    for j = 1:(i-1)
        fprintf(fileID,'%d; %d; %4.4f\r\n',i,j,data(i,j));
    end
end
fclose(fileID);
