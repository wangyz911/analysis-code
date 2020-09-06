function [force_i] = force_zmag_pico(z_mag)

% 本函数是用picotwist得到的数据计算力值，是force_zmag_che 的修正版本

    A1 = 20.38;
    b1 = 3.52;
    force_i = A1 * exp( z_mag.*b1) ;



end

