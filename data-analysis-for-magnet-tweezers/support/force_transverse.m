function [force_real] = force_transverse(force)

%����������������force_zmag_che����ֵ�߹������⣬�����㷨�������÷���������ش���λ�ã�������ȷ�Ĺ�ʽ��������
y0 = 0.3474;
A1 = 46.24946;
t1 = 0.22238;
% T  = 31.5;
% force_i = y0 + A1 * exp( (z_mag+length_cor)./t1) ;
% force_i = force_i .*(273.15 + T) /(273.15 + 31.5);
zmag = t1*log((force-y0)/A1);

force_real = force_zmag_pico(zmag);

end

