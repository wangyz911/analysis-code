% ���ű��������ɷ���Gephi ������ʽ������

% ��������node���Ļ��Ͳ��Լ������ˣ�����ֱ����excel ��ġ�
% �������ɵ���Ҫ�����ݼ�������Ҫ�����ݣ�edges��

%% ���Ƚ�����ճ������

data = [];
N = size(data,1);
% Ȼ���� source target weight ��˳��д��txt �ļ���
fileID = fopen('data for Gephi edges.txt','w');
fprintf(fileID,'%s; %s; %s\r\n','source','target','weight');
for i = 2:N
    for j = 1:(i-1)
        fprintf(fileID,'%d; %d; %4.4f\r\n',i,j,data(i,j));
    end
end
fclose(fileID);
