% 该脚本用于生成合适大小的数据矩阵的C语言版本
image_name = 'test00.tif';   % 图像名
image =  imread(strcat('E:\analysis code\simulink\QI simulink\',image_name));%读入一张图像

fileID = fopen('matrix1.txt','w');

fprintf(fileID,'img_mat = {');
m_size = size(image,1);
for i = 1:m_size
    for j = 1:m_size
       elem = num2str(image(i,j));
       fprintf(fileID,strcat(elem,','));
    end
    fprintf(fileID,'\r\n');
end
fprintf(fileID, '};');

sum(sum(image));

%% c语言算法版本同步认证；
