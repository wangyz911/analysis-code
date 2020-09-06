% �ýű��Ĺ����ǽ�ĳ�����ʵ��������߼������ֵ������FE ���ߡ�

close all;
%��ƽ��̬���������ڶ�̬���ݣ�ͳ��G4�ṹ������������ʱ�䣩
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
[ ~,x_pos_ramp,y_pos_ramp,DNA_z_position ] = read_pico3( fid );
% %һά����������Z��
% [ DNA_z_position ] = read_pico1( fid );

% ��ȡ�ο�С���XYZ��Ϣ
disp('---------------������ȡ�ο�С��XYZ�����ݣ�-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName2,FileName2);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�

[ ~,x_pos_ramp_ref,y_pos_ramp_ref,ref_DNA_z_position ] = read_pico3( fid );

% [ ref_DNA_z_position ] = read_pico1( fid );

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

%% data show
x_pos_ramp_modi = x_pos_ramp - x_pos_ramp_ref;
y_pos_ramp_modi = y_pos_ramp - y_pos_ramp_ref;

% ����Ư��, ��ȷ��Z��0�㣬��ǰ5000:15000����ľ�ֵ��ȷ��Zֵ���, Ҫȷ����ԥʱ���֡���������ֵ��
DNA_z_position_no_shift=DNA_z_position - ref_DNA_z_position;
% zero_point_index = find(magnet_z_position(1:20000) == -1.998);
% zero_point_size = size(zero_point_index,1)-5000;
% zero_point = mean(DNA_z_position_no_shift(zero_point_index(zero_point_size:end)));
% shift ֵ��ֻ������ͼʱ����
DNA_z_shift =0;
% DNA_z_position_modi = DNA_z_position_no_shift - zero_point + DNA_z_shift;
DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);

number=size(DNA_z_position_modi,1);

time=(1:number)./3600;                                                   %ʱ�䵥λ��֡ת��������
plot(DNA_z_position_modi);
% �ڳ�ԥ��λ��������ǣ�����ѡ������
hold on
relax_marker = zeros(size(relax_pos,1),1);
plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
hold off
disp('��ѡ����ʵ�����')
if input('����1ѡ������','s')=='1'
    disp('�����ͣ��~');

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
% name_save=FileName(13:name_length-3);
name_save=FileName(5:(name_length-3));


%% �������޸ĺ�׺��ʡ�ı������ݺ�һ������
    ramp_th = '_1';
    name_save = strcat(name_save,ramp_th);
 

%% eliminate the effects of drifting.
figure('Name',name_save);

% ���Ƴ�ref��Ĺ켣�������ж�Ծ��Ŀɿ��ԡ�
DNA_z_ref = sigDEN5(ref_DNA_z_position);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'k');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
plot(time(start_number:end_number),(ref_DNA_z_position(start_number:end_number)-0.1)*1000,'g');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
% �����������˶��켣
plot(time(start_number:end_number),magnet_z_position(start_number:end_number),'k');
zmag_ramp = magnet_z_position(start_number:end_number);
xlabel('Time (min)');ylabel('Zmag (mm)');

%% ѡ��һ��ramp���̽��д���
%ѯ���Ƿ���force ramp ����
disp('�Ƿ���� force ramp ���ߣ�')
yes_ramp = input('�ǻ��߷�','s');
if yes_ramp == '1'
    % ���ȱ���ͼƬ��tif ��ʽ
    fig_name = strcat(name_save,'.fig');
    saveas(gcf,fig_name);
%     %%%%%%%%%%%% ���̶������İ汾
%     % ����㶨�����ʵ�zmagλ������
%     load z_mag_series.mat;
%     % ���������������ԣ���0.002��Ϊ����
%     z_mag_series = z_mag_series+0.002;
%     data_ramp = DNA_z_position_modi(start_number:end_number);
%     ext_curve = zeros(size(z_mag_series));
%     % �����ֵ����extension curve
%     for i =1:size(z_mag_series,1)
%         ext_curve(i)= mean(data_ramp(abs(zmag_ramp-z_mag_series(i))< 0.0015))*1000;
%         
%     end
% 
%     force_curve = force_zmag_che(z_mag_series, 0.016);
    %%%%%%%%%%% �̶������İ汾
    % ��������
    stepsize= 0.002;
    zmag_start=magnet_z_position(start_number);
    zmag_end = magnet_z_position(end_number);
    % ����DNA���ӳ��ȣ�����Zֵ�ϵ�����
    disp('please input the length of DNA (um)');
    DNA_length = input('DNA length = ','s');
    DNA_Z_shift = str2double(DNA_length) - max(DNA_z_position_modi(start_number:end_number));
    
    data_ramp = DNA_z_position_modi(start_number:end_number) + DNA_Z_shift;   
    
    %��ȡչ������
    % �����ֵ����extension curve,��ֵ��Ч�����ã����Ƕ��Щ�㡣
%     interp_num = 20;
    [ ext_curve,zmag_i ] = ramp_ext_mean( data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);
    bead_r = 0.5; % ����뾶0.5΢��
    ext_curve_F = ext_curve+bead_r;
    [force_curve_y,dy2] = ramp_force_mean( ext_curve_F,y_pos_ramp_modi,zmag_ramp,zmag_start,zmag_end,stepsize );
    [force_curve_x,dx2] = ramp_force_mean( ext_curve_F,x_pos_ramp_modi,zmag_ramp,zmag_start,zmag_end,stepsize );


%% ��ͼ�뱣������
    figure;
    plot_size = min(size(ext_curve,1),size(force_curve_y,1));
    ext_curve = ext_curve(1:plot_size);
    force_curve_y = force_curve_y(1:plot_size)';
    plot(ext_curve,force_curve_y,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title(name_save);
    FE_name = strcat(name_save,'_FE.fig');
    saveas(gcf,FE_name);
    force_ramp_name = strcat('force_ramp_2G4_',name_save);
    save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve_x','force_curve_y','zmag_i','dy2','dx2');

    
end


end