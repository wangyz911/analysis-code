data = cell(3,1);
%% ����txt�ļ�������һ������д��
fileID = fopen('city_name.txt','w');
% ��ȡ��������
N = length(data);
% �ı����ļ�ͷ���м�Ĺ����ʣ�Ҫ���ַ���������˫���ţ�ʹ��\"��Ҫ���뵥���ţ�ʹ��''�����������ţ�
HEAD = '\"MC\"=';
END = 'OR';
% ��ʼ��˳��ѭ��д��
for i=1:N

    fprintf(fileID,HEAD);
    fprintf(fileID,'''');
    fprintf(fileID,strcat(data{i}));
    fprintf(fileID,'''');
    % ���һ��������к�Ͳ�����OR��
    if i~=N
    fprintf(fileID,END);
    end
end