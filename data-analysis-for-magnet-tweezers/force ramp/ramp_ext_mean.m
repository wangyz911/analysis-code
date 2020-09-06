function [ ext_curve, force_i ] = ramp_ext_mean( data_ramp,zmag_ramp,zmag_start,zmag_end,force_stepsize )
%��������������ramp������ÿһ�׶ε�extension �ľ�ֵ��
% ������ֵ��ͨ��zmag���������������΢С���ۼ�������ÿ�ε�force_start �����Ǽ򵥵���һ������step,
% ����ɸö�zmag��Ӧ��ֵ�ľ�ȷֵ����step����������ܱ�����һ���ķ�Χ�ڡ�
% 2017��1��27����ǰ��MT2�ϲ��T1������У׼������Ҫ������
%�Բ���Ϊѭ��������
    force_ramp = force_zmag_T1_newMT(zmag_ramp,0);
    force_start = force_zmag_T1_newMT(zmag_start,0);
    force_end = force_zmag_T1_newMT(zmag_end,0);
    step = floor((force_end-force_start)/force_stepsize+1);
    ext_curve = zeros(step,1);
    force_i = zeros(step,1);

for i =1:step
    data_seq = abs(force_ramp-force_start)< 0.02;
    ext_curve(i)= mean(data_ramp(data_seq));
    zmag =  -log(force_start/32.36)/1.523;
    force_i(i) = force_zmag_T1( zmag, 2 );
force_start = mean(force_zmag_T1_newMT(zmag_ramp(data_seq),0)) + force_stepsize;

end
end

