% ���ű���������ʡ�������Ծ��� 20190314

%% ���ȸ�����������������֮�����ľ���
xiangsidu = [];
data = zeros(1);

% �����ƶ�����ճ�����������ɵľ���xiangsidu�
%�ٽ������������������data �ע���Ҽ�ѡ��paste excel data
% ���湹�����ƶȾ����Ա�ʾ�����������������������Ƴ̶ȡ�
fyq_num = 15;   % �����������������޸�
xsdu_p2p = zeros(fyq_num); % ����������������ƶȾ���
N = size(xiangsidu,1);
k=1;
%��������ƥ���ϵ�������ƶȣ�������1
for i= 1:N
    xsdu_p2p(xiangsidu(i,1),xiangsidu(i,2)) = xiangsidu(i,3);
    xsdu_p2p(xiangsidu(i,2),xiangsidu(i,1)) = xiangsidu(i,3);
    k = k+1;
end
for j = 1:fyq_num
    xsdu_p2p(j,j) = 1;
end

% ͳ��ÿ��ʡ�ķ����������˿ڱ���, Ϊ�˺����ƶȾ����ܹ���ˣ�ÿ��ʡҲ��Ϊ15���������������ڵķ���������Ϊ0
pro = unique(data(:,1));
pro_yuyan_arrays = zeros(size(pro,1),15);
for i = 1:size(pro,1)
    range = find(data(:,1)==pro(i));
    fyq_inpro = unique(data(range,2));
    for j = 1:size(fyq_inpro,1)
        data_inpro = data(range,:);
        fyq_range = find(data_inpro(:,2)==fyq_inpro(j));
        pro_sum = sum(data_inpro(:,3));
        pro_yuyan_arrays(i,fyq_inpro(j)) = sum(data_inpro(fyq_range,3))/pro_sum;
    end
end
% ����ÿ��ʡ֮������Ծ���
yuyanjuli_pro = zeros(size(pro,1));
for i = 1:size(pro,1)
    for j =i:size(pro,1)
        yuyanjuli_pro(i,j) = 1-pro_yuyan_arrays(i,:)*xsdu_p2p*pro_yuyan_arrays(j,:)';
    end
end

% �ų�����
yuyan_pro_array = zeros(nchoosek(size(pro,1),2)+size(pro,1),3);
k = 1;
for j = 1:size(pro,1)
    for i = 1:j
        yuyan_pro_array(k,1) = pro(i);
        yuyan_pro_array(k,2) = pro(j);
        yuyan_pro_array(k,3) = yuyanjuli_pro(i,j);
        k=k+1;
    end
end



