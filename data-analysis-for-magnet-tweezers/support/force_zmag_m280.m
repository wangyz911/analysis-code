function [ force_i ] = force_zmag_m280( z_mag,MT_NO,offset )
%本函数利用3μm长的双链DNA进行拉伸测量，校准后得到力值结果，然后利用已有的力值结果和zmag值进行插值
%对于任何给定的zmag值，函数返回插值得到的力值。
%  我们根据磁镊拉伸DNA的数据，用指数函数拟合了F vs Zmag，并通过拟合函数反而给出力值。
%  由于目前有多台磁镊，每台磁铁有所不同，因此需要输入磁镊编号来采用对应的参数进行拟合

%% 按照磁镊的编号来选择参数进行拟合。
if MT_NO == 4
    
    A1 = 142.6;
    b1 = -1.436;
    force_i = A1 * exp( (z_mag+offset).*b1) ;
elseif MT_NO == 4.1 % 这是MT4 新采用的lambda DNA 拟合的拉力，20190129开始在磁镊上采用
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

