function [ force_i ] = force_zmag_T1_newMT( z_mag, ~ )
%����������3��m����˫��DNA�������������У׼��õ���ֵ�����Ȼ���������е���ֵ�����zmagֵ���в�ֵ
%�����κθ�����zmagֵ���������ز�ֵ�õ�����ֵ��
%  ���Ǹ��ݴ�������DNA�����ݣ���ָ�����������F vs Zmag����ͨ����Ϻ�������������ֵ��
%  ��ֵ�ļ��������ݹ����׷����ó��������˸������������ʮ�ֿɿ���
%  ָ����Ϲ�ʽ���£� y = A1*exp(-x/t1) + y0

%%  ��ָ�����

    A1 = 32.36;
    b1 = -1.523;
    force_i = A1 * exp( z_mag.*b1) ;

    
end

