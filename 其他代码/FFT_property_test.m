dy=data_y-mean(data_y);
num=size(dy,2);
vry=sum(dy.^2)/(num-1);                                                    %��ԭ����㷽� �����ϵͳ����һ��
fty=fft(dy);
fty_abs=abs(fty);
ifty=ifft(fty_abs);                                                        %FFT,abs,iFFT,��ȫ�ָ����������С�
Fs=60;
num_2=floor(num/2);
F_num=(1:num-1)*Fs/num;                                                            %�����ʵ�ʵ�Ƶ��ֵ
F_num=F_num(1:num_2);

ifty2=abs(ifft(fty_abs(1:num_2)));                                         %���м������ת����������������˵���任������N/2��ʱ��Ҳ����N/2����Ϊ��ɢ����Ҷ�任�У��ж��ٸ������㣬ת���������ж��ٸ�������

fty_half=fty_abs./2;
ifty_half=ifft(fty_half);                                                  %��ֵ�������任������������4����˵����ֵ�����任������ֵҲ�����ˣ��ټ���ƽ����

ftyP=abs(fft(dy)).^2;

ifyP=sqrt(abs(ifft(ftyP)));                                                %����Ҷ�任����Ƶ�ױ�ɹ����ף�����任Ȼ�󿪷����ó���

dy2=dy.^2;                                                                 %y����������ƽ��������FFT��ֱ�ӵõ������ף�Ȼ����任���������÷����ԭ��ʽ���м��㣬���������΢�ı仯��ȥ���߽�ֵ������΢����仯��
fty_2=abs(fft(dy2));
ifty_2=abs(ifft(fty_2));
vry2=sum(dy2)/(num-1);
ivry2=sum(ifty_2)/(num-1);
