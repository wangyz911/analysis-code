function [ DI_ln,DI_ln2 ] = logD(patent)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   ��ʼ��������
patent_ln = log(patent);
t1 = size(patent_ln,1);
DI_ln = zeros(t1);
%���������ר����
for X = 1:t1
    for Y = X:t1
DI_ln(X,Y)=abs(patent_ln(X)-patent_ln(Y));
    end
DI_ln2 = zeros(sum(1:(t1-1)),1);
m = 1;
for i=2:t1
    DI_ln2(m:(m+i-2)) =DI_ln(1:(i-1),i);
    m = m+i-1;
end
end