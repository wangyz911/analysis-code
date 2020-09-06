function parameter_fit = Dudko_fit_unfold( F,rate,parameter)
%本函数用于已知反应速率随力值的变化，求反应势垒dG 和反应距离x，注意正向和反向计算时负号不一样
%思路：主要是最小二乘法的非线性函数拟合，函数很复杂，可能写起来比较麻烦。


%% 设定初始参数
% v = 2/3;
% k0 = parameter(1);
% dG = parameter(2);
% dx = parameter(3);
% K = F/z_mean;

%% 拟合函数主体
xdata = F;
ydata = rate';%注意这里input的data 实际是ln(k0)，与拟合函数对数形式保持一致。
%拟合函数主体，其中p(1) = lnk0，p(2)=dG,p(3)=dx
    function y = D_fit(p,xdata)
        y = p(1)+log((1 + xdata.*p(3)^2/(3*p(2)*1.3) - 2*xdata.*p(3)/(3*p(2)) .* (1+ xdata.*p(3)^2/(6*p(2)*1.3)) ))/2 ...
            +(p(2) * (1-(1+xdata.*p(3)^2/(3*p(2)*1.3) - 2*xdata.*p(3)/(3*p(2)) .* (1+ xdata.*p(3)^2/(6*p(2)*1.3)) ).^(1.5)));
    end
p = parameter;     %first guess

p_fit = nlinfit(xdata,ydata,@D_fit,p);


parameter_fit = p_fit;

%% 拟合结果作图
figure;
plot(xdata,ydata,'b*',xdata,D_fit(p_fit,xdata),'r');



end

