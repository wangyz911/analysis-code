unnamed = zeros(1);
%������ճ�������Ͼ����У�ÿһ���Ŵ���ͬһ���ʡ�Ĵ���������ͬ���Ŵ���ͬ���
%�������趨ʡ����������������������23��ʡ12��
prov_num = 23;
year_num = 12;
%�Զ���һ����ת����ÿ��һ�У����ں���ķ���
prov_year = zeros(23,12);
m = 1;
for i = 1:12
    prov_year(:,i)=unnamed(m:prov_num*i);
    m = m + prov_num;
end


%Ԥ���ý���������ڱ�����
PD_year = zeros(sum(1:prov_num),year_num);
PD_year_ln = zeros(sum(1:prov_num),year_num);
for year = 1:year_num
    %��ȡ��year��Ĵ������ݣ����з���
    patent = prov_year(:,year);
    [DI,DI2] = D(patent);
    [ DI_ln,DI_ln2 ] = logD(patent);
    %�õ�����󣬱�����괴�½��
    PD_year(:,year) = DI2;
    PD_year_ln(:,year) = DI_ln2;
end
    