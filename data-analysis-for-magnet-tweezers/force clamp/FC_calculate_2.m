function [ dx_f,dG0_f,dx_u,dG0_u,k0_u,k0_f,G0,G0_u_minus_f,G0_uf,nt,Feq,keq,teq] = FC_calculate_2( dwell_time_curve,T )
% 计算二态系统的力值，反应速率的关系，以及其他重要参数。
%   Detailed explanation goes here
force_line = dwell_time_curve(:,3);
k_unfold_line = dwell_time_curve(:,5);
k_fold_line = dwell_time_curve(:,6);
%   消除未赋值而为零的点
force_line(force_line==0)=[];
k_unfold_line(k_unfold_line==0)=[];
k_fold_line(k_fold_line==0)=[];
k_u_log = log(k_unfold_line);
k_f_log = log(k_fold_line);
% 对反应速率做线性拟合得到dx 和 dG（还需修正成为自然情况下dGO）.
[fit_fold] = polyfit(force_line,k_f_log,1);
[fit_unfold]= polyfit(force_line,k_u_log,1);
Kb_T = 1.3806504e-2*(T+273.15); 
% 计算平衡态的反应速率和dwelltime，这两个量反映了两个态间势垒的高度。
fun_eq = @(f)(fit_fold(1)-fit_unfold(1))*f+fit_fold(2)-fit_unfold(2);
Feq = fzero(fun_eq,2);
keq = exp(polyval(fit_fold,Feq));
teq = 1/keq;
% 最终分析结果
dx_f = fit_fold(1)*Kb_T;
dG0_f = -fit_fold(2);
k0_f = exp(-dG0_f);
dx_u = fit_unfold(1)*Kb_T;
dG0_u = -fit_unfold(2);
k0_u = exp(-dG0_u);
% 自由能还需要减去单链的拉伸自由能和G4拉伸自由能等等，统称G_stretch
lnK = k_u_log - k_f_log;
dx_uf = dx_u-dx_f;
[G0,G0_uf,nt] = G0_modi(lnK,force_line,T,dx_uf);
%另一种方法计算出的G0
G0_u_minus_f = dG0_u - dG0_f;
% 将拟合曲线的力值细化，方便寻找平衡点。

save('dwell_time_results.mat','dx_f','dG0_f','dx_u','dG0_u','k0_u','k0_f','G0','G0_u_minus_f','G0_uf','nt','T','Feq','keq','teq');

%作图
fit1 = polyfit(force_line,log(k_unfold_line),1);
fit2 = polyfit(force_line,log(k_fold_line),1);
err1 = 0.05*force_line;
force = 0:0.05:15;
% 创建 figure
figure;

    semilogy(force,exp(polyval(fit1,force)),'b');
    hold on;
    % 使用 errorbar 的矩阵输入创建多个误差条

    errorbar(force_line,k_unfold_line,err1,'horizontal','*');
    semilogy(force,exp(polyval(fit2,force)),'r');
    errorbar(force_line,k_fold_line,err1,'horizontal','o');
%     ylabel('k(s^{-1})');
%     xlabel('Force(pN)');

% 创建 ylabel
xlabel('Force(pN)','FontWeight','bold','FontName','Arial');

% 创建 xlabel
ylabel('k(s^{-1})','FontWeight','bold','FontName','Arial');

%     view(90,-90);
    hold off
    h = gcf;
    saveas(h,'k_vs_force','fig');


end

