function  [p_fit]  = evans_model( F,counts,c,total )
%该函数是Evans model，用force ramp过程中结构打开的力值F的记录分布拟合出无力值时的反应速率k 和反应长度x
%% 设定Evans model中的一些常量

% 按照Evans model 写出函数，其中待定系数c(1)=展开速率k0_u, c(2)=dx，反应距离，令常数加载率r=0.2pN/s
% ，kBT= 4.1
    function y = evans(c,F)
       y = log(c(1)) - log(0.2) + F.*c(2)./4.1 + c(1)*4.1/(c(2)*0.2) * (1 - exp( F.*c(2)./4.1 ) );

%        y = 5*c(1) * exp(F.*c(2)./4.1 + c(1)*4.1/(c(2)*0.2) * (1 - exp( F.*c(2)./4.1 ) ));
    end
ydata = counts./total;

ydata_log = log(ydata);
xdata = F;
p_fit = nlinfit(xdata,ydata_log,@evans,c);
%% 拟合结果作图
figure;
plot(xdata,ydata_log,'b*',xdata,evans(p_fit,xdata),'r');

end

