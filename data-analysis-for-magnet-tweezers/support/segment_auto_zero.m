function [data_out] = segment_auto_zero(segment)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

data = segment(:,2);
data_out = data- min(median(data(1:10)));


end

