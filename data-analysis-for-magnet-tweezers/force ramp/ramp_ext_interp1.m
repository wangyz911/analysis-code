function [ ext_curve,zmag_i ] = ramp_ext_interp1( data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize, interp_num )
% 在计算FE时，平衡态实验的数据如果按台阶进行平均，会忽略掉很多跃变的特性，其FE图像难以反映真实变化，
% 因此需要对台阶进行大量的插值，来增加采样点数，从而展示出来回跃变的特点，本函数就是插值版本的extension计算函数。
% 输入：ext 原始数据 data ramp，zmag 起点和终点zmag_start, zmag_end,用于计算步数的stepsize,
% 每一个台阶的插值数 interpl_num
% 计算方法：有时候需要跨台阶取值，否则数据会有断裂的趋势。
% 输出：插值后的zmag_i, 以及对应数量的ext_i.
%   具体计算方法如下 (本方法不好)
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

