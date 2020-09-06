function [data_out] = segment_auto_zero(segment)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

data = segment(:,2);
data_out = data- min(median(data(1:10)));


end

