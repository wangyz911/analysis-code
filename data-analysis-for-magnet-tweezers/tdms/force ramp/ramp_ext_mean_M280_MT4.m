function [ ext_curve, force_i ] = ramp_ext_mean_M280_MT4( data_ramp,zmag_ramp,zmag_start,zmag_end,force_stepsize,zmag_shift,MT_NO )
%��������������ramp������ÿһ�׶ε�extension �ľ�ֵ��
% ������ֵ��ͨ��zmag���������������΢С���ۼ�������ÿ�ε�force_start �����Ǽ򵥵���һ������step,
% ����ɸö�zmag��Ӧ��ֵ�ľ�ȷֵ����step����������ܱ�����һ���ķ�Χ�ڡ�
% 2017��1��27����ǰ��MT2�ϲ��T1������У׼������Ҫ������
%�Բ���Ϊѭ��������
    force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
    force_start = force_zmag_m280(zmag_start,MT_NO,zmag_shift);
    force_end = force_zmag_m280(zmag_end,MT_NO,zmag_shift);
    step = floor((force_end-force_start)/force_stepsize+1);
    ext_curve = zeros(step,1);
    force_i = zeros(step,1);

for i =1:step
    data_seq = abs(force_ramp-force_start)< 0.02;
    ext_curve(i)= mean(data_ramp(data_seq));
     force_i(i) = force_start;
    % ����Ĳ�����Ϊ�˵õ���ȷ����ֵ���ֲ�Ӱ�����ݶε�ѡȡ
%     force_i(i) = force_zmag_m280(median(zmag_ramp(data_seq)),4.1,zmag_shift);
    force_start = force_start + force_stepsize;

end
end
