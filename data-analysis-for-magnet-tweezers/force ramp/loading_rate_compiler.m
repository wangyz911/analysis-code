clc;
%% 设定加载率，力值范围
loading_rate_step=0.1;
force_max=15;
force_min=1;
delay_time=0.5;
% 每秒加载率等于每步加载率除以每步等待时间
loading_rate = loading_rate_step/delay_time;


% 步数
step_number=floor((force_max-force_min)/loading_rate);


force_series=(0:step_number)*loading_rate + force_min;
force_series=force_series';

%拟合公式中按等force输出z值
z_mag_series_origin=0.22238*log((force_series-0.3474)/46.24946);%这是我拟合的一个公式，可能以后还会拟合出其他公式的说

z_mag_series=round(z_mag_series_origin*500)/500;   %因为据说z_mag的最小有效位数是0.002


%数据输入间隔,此处单位为毫秒请注意
delay_press=10;
delay_step=delay_time*1000;
delay_form=60000;

delay_press_str=num2str(delay_press);
delay_step_str=num2str(delay_step);
delay_form_str=num2str(delay_form);

fileID = fopen('temp_code.txt','w');
%注明加载率
fprintf(fileID,strcat('//r=',num2str(loading_rate),'pN/s','\r\n'));

for i=1:step_number+1
    %每次改值前用注释表明下目标值
    z_mag_temp_str=sprintf('%.3f',z_mag_series(i));
    fprintf(fileID,strcat('//',z_mag_temp_str,'\r\n'));
    %点击鼠标代码
    fprintf(fileID,'LeftClick 1\r\n');
    %操作间停顿
    fprintf(fileID,strcat('Delay',32,delay_press_str,'\r\n'));
    %退格
    fprintf(fileID,'KeyPress "BackSpace", 7\r\n');
    %操作间停顿
    fprintf(fileID,strcat('Delay',32,delay_press_str,'\r\n'));
    
    for j=1:6
        fprintf(fileID,strcat('KeyPress "',z_mag_temp_str(j),'", 1\r\n'));
    end
    
    fprintf(fileID,strcat('Delay',32,delay_press_str,'\r\n'));
    fprintf(fileID,'KeyPress "Enter", 1\r\n');
    fprintf(fileID,strcat('Delay',32,delay_press_str,'\r\n'));
    
    fprintf(fileID,strcat('Delay',32,delay_step_str,'\r\n'));
    
    
    fprintf(fileID,'\r\n');
end
