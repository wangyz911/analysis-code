% ʹ�ò�ֽ����㷨�����������f = @(x,y) -20.*exp(-0.2.*sqrt((x.^2+y.^2)./2))-exp((cos(2.*pi.*x)+cos(2.*pi.*y))./2)+20+exp(1) ������[-4,4]�ϵ���Сֵ
% ����������Сֵ����(0,0)
% �о�����㷨��ǿ������ѧϰһ��

N = 20; %������Ⱥ����
F = 0.5; %���ò����������
P_cr = 0.5; %���ý������
T = 300; %��������������
f = @(x,y) -20.*exp(-0.2.*sqrt((x.^2+y.^2)./2))-exp((cos(2.*pi.*x)+cos(2.*pi.*y))./2)+20+exp(1); %����Ŀ�꺯��

%��Ⱥ��ʼ��
population = -4 + rand(N,2).*8;
t = 0; %������ʼ��
%��ʼ����
while t < T
    %����
    H_pop = [];
    for i = 1:N
        index = round(rand(1,3).*19)+1;
        add_up = population(index(1),:) + F.*(population(index(2),:)-population(index(3),:));
        H_pop = [H_pop; add_up];
    end
    %����
    V_pop = H_pop;
    for i = 1:N
        for j = 1:2
            if rand > P_cr
                V_pop(i,j) = population(i,j);
            end
        end
    end
    %ѡ��
    for i = 1:N
        f_old = f(population(i,1),population(i,2));
        f_new = f(V_pop(i,1),V_pop(i,2));
        if f_new < f_old
            population(i,:) = V_pop(i,:);
        end
    end
    %����tֵ
    t = t + 1;
end
population
% ��������������������������������
% ��Ȩ����������ΪCSDN������NULL_M����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/weixin_42528077/article/details/82779819