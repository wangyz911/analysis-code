function [force_i] = force_zmag_pico(z_mag)

% ����������picotwist�õ������ݼ�����ֵ����force_zmag_che �������汾

    A1 = 20.38;
    b1 = 3.52;
    force_i = A1 * exp( z_mag.*b1) ;



end

