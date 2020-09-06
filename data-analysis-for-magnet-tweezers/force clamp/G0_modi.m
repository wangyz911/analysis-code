function [ G0,G0_uf,nt ] = G0_modi( lnK,F,T,dx_uf)
%本函数用来消除计算出的势垒中外力拉伸功的影响， 得到自然情况下的能量势垒值。
% 参数说明：K为k_f/k_u，F伪对应的力值向量，nt为单链的核苷酸数（结构的核苷酸数？），T为温度
%% 首先进行拟合
kBT = 1.3806504e-2*( T+273.15 ); 
dx = 8; % 暂且将dx设为8nm，寻求更为客观的方法
% dx = dx_u - dx_f，有没有道理？


p = polyfit(F,lnK,1);
% fit_line = p(1).*F + p(2);
% 计算两状态间的自由能差
LNK = @(F)p(1)*F + p(2);
F_0 = fzero(LNK,0);
    disp('请输入G4结构nt数');
    nt = input('nt = ','s');
    nt = str2double(nt);

G0 = (F_0*dx - G_stretch(F_0, nt))/kBT;
G0_uf = (F_0*dx_uf - G_stretch(F_0, nt))/kBT;
    


end

