% nucleosome data analysis
%% -------------------------��ȡ�����ļ�---------------------------
close all;clear;
disp('###########################�����������############################')
disp('---------------һ����ȡС��XYZ�����ݣ�-------------------------------')
[FileName,PathName] = uigetfile('.gr','λ�������ļ�');
file=strcat(PathName,FileName);
fid=fopen(file, 'r');
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
DNA_x_position_array=textscan(fid,'%f%f');
frame_seriels=DNA_x_position_array{1,1};
DNA_x_position=DNA_x_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');  
end
fgetl(fid);
DNA_y_position_array=textscan(fid,'%f%f');
DNA_y_position=DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');  
end
fgetl(fid);
DNA_z_position_array=textscan(fid,'%f%f');
DNA_z_position=DNA_z_position_array{1,2};  
disp('---------------������ȡ����z�����ƶ������ݣ�--------------------------')
[FileName2,PathName2] = uigetfile('.gr','�����ƶ��������ļ�');
file=strcat(PathName2,FileName2);fid=fopen(file, 'r');
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
magnet_z_position_array=textscan(fid,'%f%f');
frame_seriels_magnet=magnet_z_position_array{1,1};
frame_seriels_magnet_all=size(frame_seriels_magnet);
magnet_z_position=magnet_z_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
magnet_z_rotation_array=textscan(fid,'%f%f');
magnet_z_rotation=magnet_z_rotation_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!'); 
end
fgetl(fid);
magnet_focus_array=textscan(fid,'%f%f');
magnet_focus=magnet_focus_array{1,2};
%%data show
number_array=size(DNA_z_position);
number=number_array(1,1);
time=(1:number)./60./60;
plot(DNA_z_position);
name_length=size(FileName,2);
name_save=FileName(13:name_length-3);
figure('Name',name_save);
subplot(2,3,1);
plot(time,DNA_x_position);
xlabel('time(min)');ylabel('x');
subplot(2,3,2);
plot(time,DNA_y_position,'m');
xlabel('time(min)');ylabel('y');
title(name_save);
subplot(2,3,3);
plot(time,DNA_z_position);
xlabel('time(min)');ylabel('z');
subplot(2,3,4);
plot(time,magnet_focus);
xlabel('time(min)');ylabel('focus');
subplot(2,3,5);
plot(time,magnet_z_rotation);
xlabel('time(min)');ylabel('rotation');
subplot(2,3,6);
plot(time,magnet_z_position);
xlabel('time(min)');ylabel('magnet');
saveas(gcf,strcat(name_save,'_origin','_',date,'.fig'));
saveas(gcf,strcat(name_save,'_origin','_',date,'.tiff'),'tiffn');
save (strcat('varible_',name_save,'_origin',date));
%%
data_count=1;
close all;
figure;
subplot(2,1,1);
plot(DNA_z_position);
subplot(2,1,2);
plot(magnet_z_position);
disp('---------------��Ҫȷ������λ����0-����Ҫ��1-��Ҫ')
yes_or_no_string1=input('judge1=','s');
yes_or_no1=str2double(yes_or_no_string1);
while yes_or_no1==1 
    yes_or_no2=1;
    count=0;
    while yes_or_no2==1
        count=count+1;
        disp('---------------�������ݵ������յ��������');
        [step_data_x,step_data_y] = ginput(2);
        data_first(count)=floor(step_data_x(1,1));
        data_end(count)=floor(step_data_x(2,1));
        disp('---------------����Ҫ��������0-�����㣻1-����')
        yes_or_no_string2=input('judge2=','s');
        yes_or_no2=str2double(yes_or_no_string2);
    end
    yes_or_no1=0;
end
save (strcat('varible_',name_save,'_data_chosen_',num2str(data_count),'_',date));
magnet_z_position_part=magnet_z_position(data_first:data_end);
DNA_z_position_part=DNA_z_position(data_first:data_end)-(DNA_z_position_fix(data_first:data_end)-DNA_z_position_fix(data_first));
number=size(magnet_z_position_part,1);
% �����⼸����Ϊ���ҵ������ƶ���ʱ���
test=magnet_z_position_part(2:number)-magnet_z_position_part(1:(number-1));
test2=abs(test);
test3=test2;
test3(find(test2))=1;
a=find(test3==1);
number_step1=size(a,1);
count=1;
a2(1)=a(1);
step_first=0;
step_end=0;
% �����������step���֡������20������Ϊ����Ч��һ����
for i=1:number_step1-1
    if(a(i+1)-a(i)>20)
        count=count+1;
        a2(count)=a(i+1);
    end;
end;
% �õ���Ч����step2
number_step2=size(a2,2);
step_first(1)=1;
step_end(1)=a2(1)-10;
% ��β����ȥ10֡
for i=2:number_step2
    step_first(i)=a2(i-1)+10;
    step_end(i)=a2(i)-10;
end
step_first(number_step2+1)=a2(i)+10;
step_end(number_step2+1)=size(magnet_z_position_part,1);
save (strcat('varible_',name_save,'_magnet_position',date));   
%% �������ͳ���
system_temperature=27+273;
Kb_multi_T=1.3806504e-2*system_temperature;
step_magnet=size(step_first,2);
DNA_z_calibration=DNA_z_position-(DNA_z_position_fix-DNA_z_position_fix(1));
for i=1:step_magnet;
    extension_mean(i)=mean(DNA_z_calibration(step_first(i):step_end(i)));
    deviation_x=std(DNA_x_position(step_first(i):step_end(i)))^2;
    force_x(i)=Kb_multi_T*(extension_mean(i))/deviation_x*1.0e-3;
    deviation_y=std(DNA_y_position(step_first(i):step_end(i)))^2;
    force_y(i)=Kb_multi_T*(extension_mean(i))/deviation_y*1.0e-3; 
    magnet_position(i)=magnet_z_position(step_first(i));
end
save (strcat('varible_',name_save,'_force',date));
figure;
plot(extension_mean,force_x);hold on;
plot(extension_mean,force_y)
figure;
plot(magnet_position,force_x);hold on;
plot(magnet_position,force_y);
save varible_force_calculation;































