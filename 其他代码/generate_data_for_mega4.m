% ���ű��������������ݱ�� Mega4 ����Ҫ�����ݸ�ʽ��

%% ���ȴ���һ�����󣬰�����ճ������
data = unnamed;
% ����һ�����������ɳ�������
data_name = cell(1,1);
% Ȼ�󴴽�һ��txt �ļ�,
fileID = fopen('data_for_mega4.txt','w');
fileID2 = fopen('index_name_for_mega4.txt','w');
% ͳ�ƾ���Ĵ�С��Ϊѭ������
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


        
        