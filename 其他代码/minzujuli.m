% ���ű������ж����е�������룬������������������30%���������������壬����������ľ���Ϊ1
% data = [];
% ���ȿ������ݵ�data �ڣ���һ�г���ID���ڶ��г��о��ȣ������г���γ�ȡ�
city_id = data(:,1);
ethnicity = data(:,2);
same_or_dif = zeros(size(data,1));
% qinl_huaih = 32-34

for i = 1:size(data,1)
    for j =i:size(data,1)
        same_or_dif(i,j) = ethnicity(i)||ethnicity(j);
    end
end

% �ų�����
array = zeros(nchoosek(size(data,1),2),3);
k = 1;
for j = 1:size(data,1)
    for i = 1:j-1
        array(k,1) = city_id(i);
        array(k,2) = city_id(j);
        array(k,3) = same_or_dif(i,j);
        k=k+1;
    end
end