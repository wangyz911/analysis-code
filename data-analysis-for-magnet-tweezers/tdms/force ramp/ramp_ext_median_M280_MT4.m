function [ ext_curve, force_i ] = ramp_ext_median_M280_MT4( data_ramp,zmag_ramp,zmag_start,zmag_end,force_stepsize,zmag_shift,MT_NO,ex_num )
%本函数用来计算ramp数据中每一阶段的extension 的均值。
% 由于力值是通过zmag函数计算而来，有微小的累计误差，所以每次的force_start 不再是简单的上一个数加step,
% 而变成该段zmag对应力值的精确值加上step，这样误差总保持在一步的范围内。
% 2017年1月27日以前在MT2上测的T1的数据校准有误，需要修正。
%以步数为循环次数，
    force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
    force_start = force_zmag_m280(zmag_start,MT_NO,zmag_shift)+force_stepsize; % 往后推一个台阶，免得鼠标选到第一个台阶末尾，采样点少
    force_end = force_zmag_m280(zmag_end,MT_NO,zmag_shift);
    step = floor((force_end-force_start)/force_stepsize+ex_num);
    ext_curve = zeros(step*ex_num,1);
    force_i = zeros(step*ex_num,1);

for i =1:ex_num:step*ex_num
    data_seq = abs(force_ramp-force_start)< 0.01;
    data_step = data_ramp(data_seq);
    sub_seq_n = floor(max(size(data_step))/ex_num);
    %增加一个ex_num参数，
    for j=1:ex_num
     ext_curve(i+j-1)= median(data_step((sub_seq_n*(j-1)+1):(sub_seq_n*j)));
%      force_i(i+j-1) = force_start+force_stepsize/ex_num*(j-1);
     real_shift = 0.3;
     force_i(i+j-1) = force_zmag_m280(median(zmag_ramp(data_seq)),4.1,real_shift)+force_stepsize/ex_num*(j-1);
    end

    % 下面的操作是为了得到正确的力值，又不影响数据段的选取
    % real shift 随槽子厚度改变

    force_start = force_start + force_stepsize;

end
end
