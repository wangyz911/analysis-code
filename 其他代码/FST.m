% ���ű����ڼ���FST��Ļ������
% ���ݸ�ʽΪm*n �ľ���mΪ���������nΪ��λ������
% data2 = [];
% sample = [];
% city_id = [];
s = 2;
%% ���û�������
L = size(data2,2);
population = size(data2,1);

%% ������ֲ���
data= data2./10000;
Fst = zeros(population);
% ���ȼ���ͬ���Ժ�������
H_temp = data'; % ת�ã���˷���Ȼ����ͼ��ɵõ���
H_j = sum(H_temp.^2); %ͬ����
h_j = 1.- H_j;         %������
% Ȼ�����Ƶ�ʾ�ֵ
for i = 1:population
    for j = i:population
     p_i_bar =(data(i,:)+data(j,:))/s;
     weighing_p_i_bar =(data(i,:).*sample(i)+data(j,:).*sample(j))./(sample(i)+sample(j));

h = 1-sum(weighing_p_i_bar.^2);
h_s = (h_j(i)*sample(i)+h_j(j)*sample(j))/(sample(i)+sample(j));
Fst(i,j) = (h-h_s)/h;
    end
end

%%  �������FST�������
% var_pi  = zeros(population, L);
% for k = 1:population
%     var_pi(k,:) = (data(k,:)-weighing_p_i_bar).^2;
% end
% D = zeros(population);
% for i = 1:population
%     for j = i:population
%         
%         n_bar = (sample(i)+sample(j))/s;
%         b = 2*(sample(i)*h_j(i)+sample(j)*h_j(j))/(s*(2*n_bar-1));
%         n_asterisk = n_bar*s/(s-1)-(sample(i)^2+sample(j)^2)/(n_bar*s*(s-1));
% 
%         a_b= (sample(i)*sum(var_pi(i,:))+sample(j)*sum(var_pi(j,:)))/(n_asterisk*(s-1))+(2*n_asterisk-1)*b/(2*n_asterisk);
%         
%         theta_hat = (a_b-b)/a_b;
%         
%         D(i,j) = -log(1-theta_hat);
%     end
% end
% 
% �ų�����
Fst_array = zeros(nchoosek(population,2)+population,3);
k = 1;
for j = 1:population
    for i = 1:j
        Fst_array(k,1) = city_id(i);
        Fst_array(k,2) = city_id(j);
        Fst_array(k,3) = Fst(i,j);
        k=k+1;
    end
end



    

