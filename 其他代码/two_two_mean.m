%% ��һ�����½�һ������ unnamed �ѱ��ƽ�ȥ��
% unnamed �Ǵ���������Ϊʡ�ݣ�����������Ϊ��ݵ�����Դ����
trade = unnamed;
% ��ȡ���Ĵ�С
trade_size = size(trade,1);
year_num = size(trade,2);
% ����������������������N��ʡ�������м������
trade_array = zeros(nchoosek(trade_size,2)*year_num,1);
k=1;
for y = 1:year_num
% ������ĳ�ʼ���

% ��ż����ֵ����ľ���
trade_mean = zeros(trade_size);

% �����ֵ
for i=1:(trade_size-1)
    for j = (i+1):trade_size
        trade_mean(i,j)=(trade(i,y)+trade(j,y))/2;
    end

end
% ���һ��
for i = 2:(trade_size)
    for j = 1:(i-1)
        trade_array(k,1) = trade_mean(j,i);
        k=k+1;
    end
end
end
