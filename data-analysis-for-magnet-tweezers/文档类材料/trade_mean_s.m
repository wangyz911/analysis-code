%% ��һ�����½�һ������ unnamed �ѱ��ƽ�ȥ��
trade = unnamed;
% ��ȡ���Ĵ�С
trade_size = size(trade,1);
% ����������������������N��ʡ�������м������
trade_array = zeros(nchoosek(trade_size,2),1);
% ������ĳ�ʼ���
k=1;
% ��ż����ֵ����ľ���
trade_mean = zeros(size(trade));
% �����ֵ
for i=1:(trade_size-1)
    for j = (i+1):trade_size
        trade_mean(i,j)=(trade(i,j)+trade(j,i))/2;
    end
    
end
% ���һ��
for i = 2:(trade_size)
    for j = 1:(i-1)
        trade_array(k) = trade_mean(j,i);
        k=k+1;
    end
end

        
        