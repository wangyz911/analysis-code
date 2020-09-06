%首先创建一个矩阵用来粘贴excel数据
% unnamed = zeros(1);
%转置一下变成下三角矩阵
gene = unnamed';
%得到矩阵的行列数，用于循环
num = size(gene,1);
% 后面就是创建txt 文件，写入，然后关闭，都不要鹏，唯一需要修改的就是紫颜色的字里的参数。
fileID = fopen('gene.txt','w');% 比如这里的gene.txt就是文件名，某人要写其他的基因距离的话最好改一下名字，免得覆盖之前的文件
for i = 1:num
    for j = 1:i
        if i==j
            fprintf(fileID,'%9f\r\n',gene(i,j)); 
            %这里的9还有下面的9表示写入的数值的位数，某人可以运行一遍之后看每个数之间隔几个空格，然后通过增加和减少这个值使得每个数之间保持一个空格的距离
        else
        fprintf(fileID,'%9f',gene(i,j));
        end
    end
end
fclose(fileID);

