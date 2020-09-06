clc;
%% �趨�����ʣ���ֵ��Χ
stepsize = 0.002;
z_start=-2;
z_end=-0.3;
wait_time=1;

% ����
step_number=floor((z_end-z_start)/stepsize);
zmag_series = z_start:stepsize:z_end;

%����������,�˴���λΪ������ע��
%����ͣ��ʱ��
delay_press=10;

delay_step=wait_time*1000;
delay_form=60000;

delay_press_str=num2str(delay_press);
delay_step_str=num2str(delay_step);
delay_form_str=num2str(delay_form);

fileID = fopen('constant_step_code.txt','w');
%ע��������


for i=1:step_number+1
    %ÿ�θ�ֵǰ��ע�ͱ�����Ŀ��ֵ
    z_mag_temp_str=sprintf('%.3f',zmag_series(i));
    fprintf(fileID,strcat('//',z_mag_temp_str,'\r\n'));
    %���������
    fprintf(fileID,'LeftClick 1\r\n');
    %������ͣ��
    fprintf(fileID,strcat('Delay',32,delay_press_str,'\r\n'));
    %�˸�
    fprintf(fileID,'KeyPress "BackSpace", 7\r\n');
    %������ͣ��
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
