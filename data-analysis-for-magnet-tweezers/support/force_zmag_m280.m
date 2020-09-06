function [ force_i ] = force_zmag_m280( z_mag,MT_NO,offset )
%����������3��m����˫��DNA�������������У׼��õ���ֵ�����Ȼ���������е���ֵ�����zmagֵ���в�ֵ
%�����κθ�����zmagֵ���������ز�ֵ�õ�����ֵ��
%  ���Ǹ��ݴ�������DNA�����ݣ���ָ�����������F vs Zmag����ͨ����Ϻ�������������ֵ��
%  ����Ŀǰ�ж�̨������ÿ̨����������ͬ�������Ҫ���������������ö�Ӧ�Ĳ����������

%% ���մ����ı����ѡ�����������ϡ�
if MT_NO == 4
    
    A1 = 142.6;
    b1 = -1.436;
    force_i = A1 * exp( (z_mag+offset).*b1) ;
elseif MT_NO == 4.1 % ����MT4 �²��õ�lambda DNA ��ϵ�������20190129��ʼ�ڴ����ϲ���
    A1 = 102.7;
    b1 = -1.184;
    force_i = A1 * exp( (z_mag+offset).*b1) ;
elseif MT_NO == 3
    A1 = 131.5;
    b1 = -1.309;
    force_i = A1 * exp( (z_mag+offset).*b1) ;


elseif MT_NO == 0 % pico
    A1 = 109.5;
    b1 = -2.906;
    force_i = A1 * exp( (z_mag+offset).*b1) ;
end




%      
end

