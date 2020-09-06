function [ force_curve,dr ] = ramp_force_mean( ext_curve,y_pos_ramp,zmag_ramp,zmag_start,zmag_end,stepsize )
%本函数用来计算ramp数据中每一阶段force 的均值。
%以步数为循环次数，注意要输入正确的步长，我认为水平振动的方差应该是xy两方向合并的方差，这样更加解释的通。
kBT = 4.13;
step = floor((zmag_end-zmag_start)/stepsize+1);
force_curve = zeros(step,1);
dr = zeros(step,1);
for i =1:step
%     r_pos_ramp = sqrt(x_pos_ramp.^2 + y_pos_ramp.^2);
% %      dx1 = var_correction(x_pos_ramp(abs(zmag_ramp-zmag_start)< 0.002)*1000,27);
% %      dy1 = var_correction(y_pos_ramp(abs(zmag_ramp-zmag_start)< 0.002)*1000,27);
% %      dr(i) = dx1+dy1;

     dr(i) = var_correction(y_pos_ramp(abs(zmag_ramp-zmag_start)< 0.002)*1000,27);
    force_curve(i)=kBT*ext_curve(i)/dr(i);
    zmag_start = zmag_start + stepsize;
end
% for i =1:46
% %      dx1 = var(x_pos_ramp(abs(zmag_ramp-zmag_start)< 0.002)*1000);
% %     dx(i) = var_correction(x_pos_ramp(abs(zmag_ramp-zmag_start)< 0.002)*1000,27);
%     force_curve(i)=kBT*ext_curve(i)./dx(i); 
% % zmag_start = zmag_start + stepsize;
% end
end

