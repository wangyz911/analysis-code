% �����������ڼ���GDP��Ȩ�ĵ��������Ʊ���

% ���ȵ����ʡGDP�����Ծ���
GDP = unnamed;
language_distance = unnamed1;
prov_num = length(GDP);

% �������ǻ��������Ǿ�����������������������, ���������Ǿ����������ת�þ��󼴿�
language_distance = language_distance +language_distance';
% Ȼ����� ���Ծ�����������Ӧ�������GDP��ֵ����,�൱�ڵõ�����Ͷ���ʽ��ÿһ������
lang_vs_GDP = zeros(size(language_distance));

for i = 1:prov_num
    lang_vs_GDP (:,i)=language_distance(:,i)./GDP;
end
% ȫ������֮��ʣ�µľ��ǼӺ��ˣ����磬AB��ֵ����A �������������Ծ������GDP��ֵ���ܺͣ���ȥ���к�B�Ĳ��֡�
result = zeros(size(language_distance));
for i = 1:prov_num
    for j = 1:prov_num
        result (j,i) = sum(lang_vs_GDP(:,i))-lang_vs_GDP(j,i);
    end
end
% �Խ�����A��A�Լ���ó�׼�Ȩ�����ֵ��Ϊ0����û��ʲô���壨�������������������������ÿ��԰�����ɾ��
for i = 1:prov_num
    result(i,i)=0;
end

% Ԥ�����ô�Ž���ľ���
A_array = zeros(nchoosek(prov_num,2),1);
B_array = zeros(size(A_array));
p = 1;


for i = 2: prov_num
    for j = 1:(i-1)
        A_array(p) = result(i,j);
        B_array(p) = result(j,i);
        p = p+1;
    end
end

    
    
