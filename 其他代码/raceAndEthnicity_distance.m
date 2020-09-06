% ���ű����ڼ���������룬�乫ʽΪED=sqrt(sum((e(i,k)-e(j,k))^2));

%% ���ȴ���������ճ���������ݣ�����Ӧ�ú���Ϊ����ֲ�������Ϊ����
data = zeros(1);
% ��ȡ��������
city_num = size(data,1);
% ��ȡ��������������˵�����������
race_num = size(data,2);

% Ԥ���ý�����󣬱߳�Ϊ����������
ED = zeros(city_num);
id_A = zeros(city_num);
id_B = zeros(city_num);
% ���о���ļ���
for i = 1:city_num
    for j = i:city_num
        id_A(i,j)=i;
        id_B(i,j)=j;
        ED(i,j) = sqrt(sum((data(i,:)-data(j,:)).^2));
    end
end

%% ���������ϳ����У��ֱ��ǳ���A����ţ�B����ţ��Լ��������
% ���ȴ������󣬴�СΪ���������������

ED_column = zeros(nchoosek(city_num,2)+city_num,3);
k = 1;
for i = 1:city_num
    for j = i:city_num
        ED_column(k,1) = i;
        ED_column(k,2) = j;
        ED_column(k,3) = ED(i,j);
        k=k+1;
    end
end
















