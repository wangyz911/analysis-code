% ���ű������ж����д����й��ϲ��������Ǳ�������
% data = [];
% ���ȿ������ݵ�data �ڣ���һ�г���ID���ڶ��г��о��ȣ������г���γ�ȡ�
city_id = data(:,1);
lati = data(:,3);
N_or_S = zeros(size(data,1),1);
% qinl_huaih = 32-34

for i = 1:size(data,1)
    if lati(i)>30
        N_or_S(i) = 1;
    elseif lati(i)<30
        N_or_S(i) = -1;
    end
end

% ����ƥ�䣬��֤�Ƿ���ͬһ��
% ����ÿ��ʡ֮������Ծ���
same_side = zeros(size(data,1));
for i = 1:size(data,1)
    for j =i:size(data,1)
        same_side(i,j) = N_or_S(i)*N_or_S(j);
    end
end
same = find(abs(same_side-1)<1E-5);
dif = find(abs(same_side+1)<1E-5);

same_side(same) = 0;
same_side(dif) = 1;


% �ų���
same_side_array = zeros(nchoosek(size(data,1),2),3);
k = 1;
for j = 1:size(data,1)
    for i = 1:j-1
        same_side_array(k,1) = city_id(i);
        same_side_array(k,2) = city_id(j);
        same_side_array(k,3) = same_side(i,j);
        k=k+1;
    end
end

scatter(data(N_or_S>0,2),data(N_or_S>0,end));
hold on
scatter(data(N_or_S<0,2),data(N_or_S<0,end));