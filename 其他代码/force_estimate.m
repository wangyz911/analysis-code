function [ force ] = force_estimate( data_y,z)
%%首先对y方向数据做傅里叶变换，得到其频率谱

%   得到基本的参数
N=size(data_y,2);
Fs=60;                                                                     %相机采样频率
W=1/65;                                                                    %窗口时间，数值有待考证。
 data_y=data_y-mean(data_y);                                                %均值修正
data_y2=data_y.^2;                                                          %直接给出y^2，没有负值的时候ifft好像挺正常。
%做傅里叶变换
% figure;
% plot(data_y2);
% title('原始信号');

y_fft=fft(data_y2);
y_abs=abs(y_fft);                                                          %对数据做傅里叶变换，并取其模长。
 iy_fft1=abs(ifft(y_abs));

% figure;
% plot(abs(iy_fft1));
% title('原始信号复原')
% figure;
% plot(y_abs);
% title('变换信号');

% N=ceil(N/2);                                                             %折半取整
% y_abs_modi=y_abs./(N_2);                                                         %换算成实际的幅度
% y_abs_modi(1)=y_abs(1)/2;
F=(1:N)*Fs/N;                                                            %换算成实际的频率值
F=F(1:N);
% figure;
% plot(F(1:N),y_abs(1:N));                                               %实际频率作图
% title('实际变换信号');
plot(log(F(1:N)),log(y_abs(1:N)));                                                  %实际频率对数作图结果
% axis([0, 5,-30,-10]);
Power_y=y_abs;
% Power_y=y_abs.^2;                                                          %得到功率谱
% % 复原测试
% iy_fft2=ifft(Power_y);                                                     
% figure;
% plot(abs(iy_fft2));
% title('原始信号复原2')

%% 得到功率谱后，开始对频域信号进行修正
omega=2*pi*F(1:N);                                                          %频率换算为圆频率 ,注意这里是频率，是F！，和功率谱一毛钱关系都没有
motion_blur=(sin(omega(1:N).*(W/2))./(omega(1:N).*(W/2))).^2;                            %设定motion blur 窗口函数（的功率谱） 
Power_y_modi=Power_y(1:N)./motion_blur(1:N);                                  %消除motion blur 的影响；
% figure;
% plot(log(F(1:N)),log(Power_y_modi(1:N)));
% hold on
% plot(log(F(1:N)),log(y_abs(1:N)),'r');   
% title('频谱（红）及其motion blur 修正（蓝）');

% % %% 对修正的功率谱进行拟合，得到截止频率，以及拟合出来的函数。
% % [fitresult, gof] = spectrum_Fit1(F, Power_y_modi);                         %用理论上的功率谱做拟合，系数A为乘积因子，系数C为洛伦兹角频率
% % A=fitresult.a;
% % fc=fitresult.c;                                                            %提取拟合参数
% % func_fit=@(F)A./(1+(F./fc).^2);                                                %所用的拟合方程
% % tao_b=1/(2*pi*fc);                                                         %由fc得到的系统弛豫时间，竟然达到百秒级别，一定是参数有问题……
% ifunc=ifft(Power_y_modi);
% figure;
% plot(abs(ifunc(5:N_2-5)));
% figure;
% plot(abs(Power_y_modi));


%% 对拟合出来的函数做逆变换，在计算出方差，得出的结果等于y^2,再利用反向摆公式计算力值
DNA_length=1.034;                                                           %定义L，轮廓长度，单位是微米
Kb_multi_T=1.3806504e-2*(26.0+273.15);                                     %k_B*T, 换成了pN*nm之后数量级降到-2，结果为4.128pN*nm
% y2=integral(func_fit,0,inf);
% Power_y_modi(1)=Power_y_modi(1)*4;
% Power_y_modi=Power_y_modi.*(N/2)^2;

y2_ifft=abs(ifft(Power_y_modi));
y2=sum(y2_ifft(5:N-5))/(N-10);                                             %方差的正确算法
                                                                           %除以1000，单位换算，最后单位是纳米，F单位是pN,为什么+1.4(1.4是2.8微米的球的半径，加上之后才是摆长)
if nargin ==1
    func_force=@(y)Kb_multi_T*(DNA_length+0.5)*1.0e-3/y;
else if nargin == 2
    func_force=@(y)Kb_multi_T*(z)*1.0e-3/y; 
    end
end
    
            
force1=func_force(y2);                                              %这是窗口修正后的力值F

y2_2_ifft=abs(ifft(Power_y(1:N)));

y2_2=sum(y2_2_ifft(5:N-5))/(N-10);
force2=func_force(y2_2);                            %仅仅经过的傅里叶变换的参考力值
force3=func_force(var(data_y));                     %直接用原始数据计算的参考力值
FFT_error=force3/force2;
force=force1*FFT_error;

        

end

