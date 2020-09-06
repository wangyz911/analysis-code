dy=data_y-mean(data_y);
num=size(dy,2);
vry=sum(dy.^2)/(num-1);                                                    %用原理计算方差， 结果和系统函数一样
fty=fft(dy);
fty_abs=abs(fty);
ifty=ifft(fty_abs);                                                        %FFT,abs,iFFT,完全恢复，正负都有。
Fs=60;
num_2=floor(num/2);
F_num=(1:num-1)*Fs/num;                                                            %换算成实际的频率值
F_num=F_num(1:num_2);

ifty2=abs(ifft(fty_abs(1:num_2)));                                         %序列减半后逆转回来方差变成两倍，说明变换回来后N/2在时域也成了N/2。因为离散傅里叶变换中，有多少个采样点，转换过来就有多少个采样点

fty_half=fty_abs./2;
ifty_half=ifft(fty_half);                                                  %幅值减半后，逆变换回来方差缩减4倍，说明幅值减半后变换回来幅值也减半了（再加上平方）

ftyP=abs(fft(dy)).^2;

ifyP=sqrt(abs(ifft(ftyP)));                                                %傅里叶变换，将频谱变成功率谱，再逆变换然后开方，得出的

dy2=dy.^2;                                                                 %y方向数据先平方，再做FFT，直接得到功率谱，然后逆变换回来，采用方差的原理公式进行计算，方差出现轻微的变化，去掉边界值可以略微减轻变化。
fty_2=abs(fft(dy2));
ifty_2=abs(ifft(fty_2));
vry2=sum(dy2)/(num-1);
ivry2=sum(ifty_2)/(num-1);
