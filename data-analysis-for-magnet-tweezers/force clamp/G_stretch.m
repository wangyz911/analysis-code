function [ G_stretch ] = G_stretch(  fc,nt )
% 已知force,critical force，求DNA构象转变过程force做的拉伸功G_stretch,单位是pN·nm。

% 依据如下公式计算G4构象的拉伸功，x_G4( f ) = l_0*coth( f*l0/kBT) ? kBT/f. 
l_0 = 1.7;

kBT = 1.3806504e-2*293; 
x_G4 = @(f)l_0*coth(f*l_0./kBT) - kBT./f;


%依据ssDNA的经验公式计算ssDNA构象的拉伸功
% % 半经验公式
% h =0.34;
% K=0.1;  %K+ 浓度, 单位为mol
% a1=0.21;   a2=0.34;   a3=2.1*log(K/0.0025)/log(0.15/0.0025);
% f1=0.0037;  f2=2.9;
% f3=8000;
% % bp = 21;
% ssDNA_length =@(f) bp*h*(a1*log(f/f1)/(1+a3*exp(-f/f2))-a2-f/f3);
%% 基于FJC模型的公式
%h = 0.34 nm, a1 = 0.21, a2 = 0.34, f1 = 0.0037 pN, f2 = 2.9 pN, and f3 = 8000 pN
n = nt;
h = 0.34;
a1 = 0.21;
a2 = 0.34;
f1 = 0.0037;
f2 = 2.9;
f3 = 8000;
a3 = 2.1*log(0.1/0.0025)/log(0.15/0.0025);
%kuhn 片段,nm


%  公式主体
ssDNA_length2 =@(f) n*h*( a1*log(f/f1)/(1+a3*exp(-f/f2))-a2-f/f3);
%% 计算拉伸功
G_G4 = integral(x_G4,0,fc);
G_ss = integral(ssDNA_length2,0,fc);
%计算势能
G_stretch =(G_ss - G_G4);



end

