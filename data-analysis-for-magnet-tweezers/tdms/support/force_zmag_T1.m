function [ force_i ] = force_zmag_T1( z_mag, MT_NO )
%本函数利用3μm长的双链DNA进行拉伸测量，校准后得到力值结果，然后利用已有的力值结果和zmag值进行插值
%对于任何给定的zmag值，函数返回插值得到的力值。
%  我们根据磁镊拉伸DNA的数据，用指数函数拟合了F vs Zmag，并通过拟合函数反而给出力值。
%  力值的计算是依据功率谱分析得出，考虑了各种修正，结果十分可靠。
%  指数拟合公式如下： y = A1*exp(-x/t1) + y0

%%  单指数拟合
if MT_NO == 2
    
    a1 = 18.04;
    b1 = -1.5;
    force_i = a1 * exp( z_mag.*b1) ;
elseif MT_NO == 3
    a1 = 18.04;
    b1 = -1.5;
    force_i = a1 * exp( z_mag.*b1) ;
    
end


    
end


