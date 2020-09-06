function [ ext_curve,zmag_i ] = ramp_ext_interp1( data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize, interp_num )
% �ڼ���FEʱ��ƽ��̬ʵ������������̨�׽���ƽ��������Ե��ܶ�Ծ������ԣ���FEͼ�����Է�ӳ��ʵ�仯��
% �����Ҫ��̨�׽��д����Ĳ�ֵ�������Ӳ����������Ӷ�չʾ������Ծ����ص㣬���������ǲ�ֵ�汾��extension���㺯����
% ���룺ext ԭʼ���� data ramp��zmag �����յ�zmag_start, zmag_end,���ڼ��㲽����stepsize,
% ÿһ��̨�׵Ĳ�ֵ�� interpl_num
% ���㷽������ʱ����Ҫ��̨��ȡֵ���������ݻ��ж��ѵ����ơ�
% �������ֵ���zmag_i, �Լ���Ӧ������ext_i.
%   ������㷽������ (����������)
step = floor((zmag_end-zmag_start)/stepsize+1);
ext_curve = zeros(step*interp_num,1);
zmag_i = zmag_start:((zmag_end-zmag_start)/step*interp_num):zmag_end;
for i =1:step
    ext_step = (data_ramp(abs(zmag_ramp-zmag_start)< 0.002))*1000;
    ext_choose = ext_step(10000:20000);
    sample_start = floor(10000/interp_num);
    ext_sample = zeros(interp_num,1);
    for j = 1:interp_num
        ext_sample(j) = mean(ext_choose(1+(j-1)*sample_start:((j-1)*sample_start+20)));
    end
    ext_curve((1+(i-1)*interp_num):i*interp_num) = ext_sample;
    zmag_start = zmag_start + stepsize;
end





end

