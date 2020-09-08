data = cell(3,1);
%% 创建txt文件，按照一定规则写入
fileID = fopen('city_name.txt','w');
% 提取城市总数
N = length(data);
% 文本的文件头和中间的关联词，要在字符串中输入双引号，使用\"，要输入单引号，使用''（两个单引号）
HEAD = '\"MC\"=';
END = 'OR';
% 开始按顺序循环写入
for i=1:N

    fprintf(fileID,HEAD);
    fprintf(fileID,'''');
    fprintf(fileID,strcat(data{i}));
    fprintf(fileID,'''');
    % 最后一次输入城市后就不输入OR了
    if i~=N
    fprintf(fileID,END);
    end
end