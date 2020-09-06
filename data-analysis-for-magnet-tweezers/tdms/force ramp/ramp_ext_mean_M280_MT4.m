function [ ext_curve, force_i ] = ramp_ext_mean_M280_MT4( data_ramp,zmag_ramp,zmag_start,zmag_end,force_stepsize,zmag_shift,MT_NO )
%本函数用来计算ramp数据中每一阶段的extension 的均值。
% 由于力值是通过zmag函数计算而来，有微小的累计误差，所以每次的force_start 不再是简单的上一个数加step,
% 而变成该段zmag对应力值的精确值加上step，这样误差总保持在一步的范围内。
% 2017年1月27日以前在MT2上测的T1的数据校准有误，需要修正。
%以步数为循环次数，
    force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
    force_start = force_zmag_m280(zmag_start,MT_NO,zmag_shift);
    force_end = force_zmag_m280(zmag_end,MT_NO,zmag_shift);
    step = floor((force_end-force_start)/force_stepsize+1);
    ext_curve = zeros(step,1);
    force_i = zeros(step,1);

for i =1:step
    data_seq = abs(force_ramp-force_start)< 0.02;
    ext_curve(i)= mean(data_ramp(data_seq));
     force_i(i) = force_start;
    % 下面的操作是为了得到正确的力值，又不影响数据段的选取
%     force_i(i) = force_zmag_m280(median(zmag_ramp(data_seq)),4.1,zmag_shift);
    force_start = force_start + force_stepsize;

end
end
