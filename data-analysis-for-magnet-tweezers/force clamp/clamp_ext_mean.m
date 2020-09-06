function [ ext_curve, zmag_i ] = clamp_ext_mean( data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize,ex_num )
%本函数用来计算ramp数据中每一阶段的extension 的均值。
%以步数为循环次数，
step = floor((zmag_end-zmag_start)/stepsize+1);
ext_curve = zeros(step*ex_num,1);
zmag_i = zeros(step*ex_num,1);
for i =1:ex_num:step*ex_num
    data_seq = abs(zmag_ramp-zmag_start)< 0.002;
    data_step = data_ramp(data_seq);
    sub_seq_n = floor(size(data_step,2)/ex_num);
     for j=1:ex_num
     ext_curve(i+j-1)= median(data_step((sub_seq_n*(j-1)+1):(sub_seq_n*j)));
     zmag_i(i+j-1) = zmag_start+stepsize/ex_num*(j-1);
    end
zmag_start = zmag_start + stepsize;
end
end

