% �ýű��������ɺ��ʴ�С�����ݾ����C���԰汾
image_name = 'test00.tif';   % ͼ����
image =  imread(strcat('E:\analysis code\simulink\QI simulink\',image_name));%����һ��ͼ��

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

%% c�����㷨�汾ͬ����֤��
