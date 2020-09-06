function [ ext_curve, force_i ] = ramp_ext_median_M280_MT4( data_ramp,zmag_ramp,zmag_start,zmag_end,force_stepsize,zmag_shift,MT_NO,ex_num )
%��������������ramp������ÿһ�׶ε�extension �ľ�ֵ��
% ������ֵ��ͨ��zmag���������������΢С���ۼ�������ÿ�ε�force_start �����Ǽ򵥵���һ������step,
% ����ɸö�zmag��Ӧ��ֵ�ľ�ȷֵ����step����������ܱ�����һ���ķ�Χ�ڡ�
% 2017��1��27����ǰ��MT2�ϲ��T1������У׼������Ҫ������
%�Բ���Ϊѭ��������
    force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
    force_start = force_zmag_m280(zmag_start,MT_NO,zmag_shift)+force_stepsize; % ������һ��̨�ף�������ѡ����һ��̨��ĩβ����������
    force_end = force_zmag_m280(zmag_end,MT_NO,zmag_shift);
    step = floor((force_end-force_start)/force_stepsize+ex_num);
    ext_curve = zeros(step*ex_num,1);
    force_i = zeros(step*ex_num,1);

for i =1:ex_num:step*ex_num
    data_seq = abs(force_ramp-force_start)< 0.01;
    data_step = data_ramp(data_seq);
    sub_seq_n = floor(max(size(data_step))/ex_num);
    %����һ��ex_num������
    for j=1:ex_num
     ext_curve(i+j-1)= median(data_step((sub_seq_n*(j-1)+1):(sub_seq_n*j)));
%      force_i(i+j-1) = force_start+force_stepsize/ex_num*(j-1);
     real_shift = 0.3;
     force_i(i+j-1) = force_zmag_m280(median(zmag_ramp(data_seq)),4.1,real_shift)+force_stepsize/ex_num*(j-1);
    end

    % ����Ĳ�����Ϊ�˵õ���ȷ����ֵ���ֲ�Ӱ�����ݶε�ѡȡ
    % real shift ����Ӻ�ȸı�

    force_start = force_start + force_stepsize;

end
end
