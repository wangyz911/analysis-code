% G4 data analysis
% �ýű��Ĺ����ǽ�ĳ�����ʵ��������߼������ֵ������FE ���ߡ�

close all;

%% -------------------------��ȡ�����ļ�---------------------------
clear;
close all;
disp('###########################�����������############################')

% ��ȡ���������Ϣ
disp('---------------һ����ȡС��XYZ�����ݣ�-------------------------------')
[FileName,PathName] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName,FileName);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�
%��ά�������������ֱ��ǣ�֡���У�x��y,z��
[ ~,x_pos,y_pos,DNA_z_position ] = read_pico3( fid );
% %һά����������Z��
% [ DNA_z_position ] = read_pico1( fid );

% % ��ȡ�ο�С���XYZ��Ϣ
% disp('---------------������ȡ�ο�С��XYZ�����ݣ�-------------------------------')
% [FileName2,PathName2] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
% file=strcat(PathName2,FileName2);                                            %����·�������ļ�����Ϊ������׼����
% fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�
% 
% [ ~,x_pos_ref,y_pos_ref,ref_DNA_z_position ] = read_pico3( fid );
% 
% % [ ref_DNA_z_position ] = read_pico1( fid );

%��ȡ��������
disp('---------------������ȡ����z�����ƶ������ݣ�--------------------------')
[FileName3,PathName3] = uigetfile('.gr','�����ƶ��������ļ�');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
% ��ȡ�����˶��ļ�������˳��ֱ��ǣ�֡���У�����λ�ã���ת����ƽ�档
[ ~,magnet_z_position,~,~ ] = read_pico3( fid );
% �ҵ���ԥ�����䣬������
relax_pos = find(magnet_z_position == -1.998);
% %һά����������magnet position��
% [ DNA_z_position ] = read_pico1( fid );

%%data show
number_array=size(DNA_z_position);
number=number_array(1,1);
time=(1:number)./60./60;                                                   %ʱ�䵥λ��֡ת��������
plot(DNA_z_position);
[start_number,start_y]=ginput(1);
start_number=floor(start_number);
if start_number<1
    start_number=1;
end
[end_number,end_y]=ginput(1);                                          %���ȡ�����öϵ�  ��
end_number=floor(end_number);                                          %����ȡ��
if end_number>number
    end_number=number;
end
name_length=size(FileName,2);
name_save=FileName(13:name_length-3);
figure('Name',name_save);


%% eliminate the effects of drifting.
% DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
% DNA_x_modi = x_pos - x_pos_ref;
% DNA_y_modi = y_pos - y_pos_ref;

DNA_z_position_modi=DNA_z_position;
DNA_x_modi = x_pos;
DNA_y_modi = y_pos;

DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number),'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number),'r');
xlabel('time(min)');ylabel('z_position_modi');
hold off
subplot(2,1,2);
plot(time(start_number:end_number),magnet_z_position(start_number:end_number));
xlabel('time(min)');ylabel('magnet');
% subplot(3,1,3)
% plot(time(start_number:end_number),fit_DNA(start_number:end_number));
% xlabel('time(min)');ylabel('z_position_filt');



clear;
close all;
disp('###########################�����������############################')

% ��ȡ���������Ϣ
disp('---------------һ����ȡС��XYZ�����ݣ�-------------------------------')
[FileName,PathName] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName,FileName);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�
data = read_picoN( fid ,6);