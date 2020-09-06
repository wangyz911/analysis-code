function [ force ] = force_estimate( data_y,z)
%%���ȶ�y��������������Ҷ�任���õ���Ƶ����

%   �õ������Ĳ���
N=size(data_y,2);
Fs=60;                                                                     %�������Ƶ��
W=1/65;                                                                    %����ʱ�䣬��ֵ�д���֤��
 data_y=data_y-mean(data_y);                                                %��ֵ����
data_y2=data_y.^2;                                                          %ֱ�Ӹ���y^2��û�и�ֵ��ʱ��ifft����ͦ������
%������Ҷ�任
% figure;
% plot(data_y2);
% title('ԭʼ�ź�');

y_fft=fft(data_y2);
y_abs=abs(y_fft);                                                          %������������Ҷ�任����ȡ��ģ����
 iy_fft1=abs(ifft(y_abs));

% figure;
% plot(abs(iy_fft1));
% title('ԭʼ�źŸ�ԭ')
% figure;
% plot(y_abs);
% title('�任�ź�');

% N=ceil(N/2);                                                             %�۰�ȡ��
% y_abs_modi=y_abs./(N_2);                                                         %�����ʵ�ʵķ���
% y_abs_modi(1)=y_abs(1)/2;
F=(1:N)*Fs/N;                                                            %�����ʵ�ʵ�Ƶ��ֵ
F=F(1:N);
% figure;
% plot(F(1:N),y_abs(1:N));                                               %ʵ��Ƶ����ͼ
% title('ʵ�ʱ任�ź�');
plot(log(F(1:N)),log(y_abs(1:N)));                                                  %ʵ��Ƶ�ʶ�����ͼ���
% axis([0, 5,-30,-10]);
Power_y=y_abs;
% Power_y=y_abs.^2;                                                          %�õ�������
% % ��ԭ����
% iy_fft2=ifft(Power_y);                                                     
% figure;
% plot(abs(iy_fft2));
% title('ԭʼ�źŸ�ԭ2')

%% �õ������׺󣬿�ʼ��Ƶ���źŽ�������
omega=2*pi*F(1:N);                                                          %Ƶ�ʻ���ΪԲƵ�� ,ע��������Ƶ�ʣ���F�����͹�����һëǮ��ϵ��û��
motion_blur=(sin(omega(1:N).*(W/2))./(omega(1:N).*(W/2))).^2;                            %�趨motion blur ���ں������Ĺ����ף� 
Power_y_modi=Power_y(1:N)./motion_blur(1:N);                                  %����motion blur ��Ӱ�죻
% figure;
% plot(log(F(1:N)),log(Power_y_modi(1:N)));
% hold on
% plot(log(F(1:N)),log(y_abs(1:N)),'r');   
% title('Ƶ�ף��죩����motion blur ����������');

% % %% �������Ĺ����׽�����ϣ��õ���ֹƵ�ʣ��Լ���ϳ����ĺ�����
% % [fitresult, gof] = spectrum_Fit1(F, Power_y_modi);                         %�������ϵĹ���������ϣ�ϵ��AΪ�˻����ӣ�ϵ��CΪ�����Ƚ�Ƶ��
% % A=fitresult.a;
% % fc=fitresult.c;                                                            %��ȡ��ϲ���
% % func_fit=@(F)A./(1+(F./fc).^2);                                                %���õ���Ϸ���
% % tao_b=1/(2*pi*fc);                                                         %��fc�õ���ϵͳ��ԥʱ�䣬��Ȼ�ﵽ���뼶��һ���ǲ��������⡭��
% ifunc=ifft(Power_y_modi);
% figure;
% plot(abs(ifunc(5:N_2-5)));
% figure;
% plot(abs(Power_y_modi));


%% ����ϳ����ĺ�������任���ڼ��������ó��Ľ������y^2,�����÷���ڹ�ʽ������ֵ
DNA_length=1.034;                                                           %����L���������ȣ���λ��΢��
Kb_multi_T=1.3806504e-2*(26.0+273.15);                                     %k_B*T, ������pN*nm֮������������-2�����Ϊ4.128pN*nm
% y2=integral(func_fit,0,inf);
% Power_y_modi(1)=Power_y_modi(1)*4;
% Power_y_modi=Power_y_modi.*(N/2)^2;

y2_ifft=abs(ifft(Power_y_modi));
y2=sum(y2_ifft(5:N-5))/(N-10);                                             %�������ȷ�㷨
                                                                           %����1000����λ���㣬���λ�����ף�F��λ��pN,Ϊʲô+1.4(1.4��2.8΢�׵���İ뾶������֮����ǰڳ�)
if nargin ==1
    func_force=@(y)Kb_multi_T*(DNA_length+0.5)*1.0e-3/y;
else if nargin == 2
    func_force=@(y)Kb_multi_T*(z)*1.0e-3/y; 
    end
end
    
            
force1=func_force(y2);                                              %���Ǵ������������ֵF

y2_2_ifft=abs(ifft(Power_y(1:N)));

y2_2=sum(y2_2_ifft(5:N-5))/(N-10);
force2=func_force(y2_2);                            %���������ĸ���Ҷ�任�Ĳο���ֵ
force3=func_force(var(data_y));                     %ֱ����ԭʼ���ݼ���Ĳο���ֵ
FFT_error=force3/force2;
force=force1*FFT_error;

        

end

