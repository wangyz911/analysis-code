function [ ssDNA_length ] = ssDNA_length2( nt_number, f )
% 本函数是严洁老师采用的一个新的计算公式，与他之前的工作用的公式不同，也许能算出更为满意的结果
%% 设定一些公式的参数
%碱基数,nm
n = nt_number;
%每单位碱基的轮廓长度，对ssDNA,nm/nt
l_0 = 0.56;
%kuhn 片段,nm
b = 1;
%经验参数 ,pN
f0 = 800;
% 其他参量
kBT = 4.1;

%%  公式主体
ssDNA_length = n*l_0*( coth(f*b/kBT)-kBT./(f*b) ).*(1+f/f0);
xlabel('force/pN');
ylabel('extension/nm');


end

