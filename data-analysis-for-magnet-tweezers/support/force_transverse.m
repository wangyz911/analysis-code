function [force_real] = force_transverse(force)

%本函数是用来修正force_zmag_che中力值高估的问题，具体算法就是先用反函数计算回磁铁位置，再用正确的公式来计算力
y0 = 0.3474;
A1 = 46.24946;
t1 = 0.22238;
% T  = 31.5;
% force_i = y0 + A1 * exp( (z_mag+length_cor)./t1) ;
% force_i = force_i .*(273.15 + T) /(273.15 + 31.5);
zmag = t1*log((force-y0)/A1);

force_real = force_zmag_pico(zmag);

end

