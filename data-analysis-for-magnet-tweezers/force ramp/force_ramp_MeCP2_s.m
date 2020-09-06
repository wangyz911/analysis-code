%���ű�����������G4 DNA��ƽ��̬force ramp�����ݽ��зֶΣ�������ֵ��ͼ������step�ϵ���ϣ�����¼��break point ��λ��
% ���ű����ڴ���MeCP2�ļ��װ汾

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
% %��ά�������������ֱ��ǣ�֡���У�x��y,z��
% [ ~,~,~,DNA_z_position ] = read_pico3( fid );
%һά����������Z��
[ DNA_z_position ] = read_pico1( fid );

% ��ȡ�ο�С���XYZ��Ϣ
disp('---------------������ȡ�ο�С��XYZ�����ݣ�-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName2,FileName2);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�

% [ ~,~,~,ref_DNA_z_position ] = read_pico3( fid );

[ ref_DNA_z_position ] = read_pico1( fid );

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
% ����Ư��, ��ȷ��Z��0�㣬��ǰ5000:15000����ľ�ֵ��ȷ��Zֵ���, Ҫȷ����ԥʱ���֡���������ֵ��
DNA_z_position_no_shift=DNA_z_position - ref_DNA_z_position;
% zero_point_index = find(magnet_z_position(1:20000) == -1.998);
% zero_point_size = size(zero_point_index,1)-50;
% zero_point = mean(DNA_z_position_no_shift(zero_point_index(zero_point_size:end)));
% shift ֵ��ֻ������ͼʱ����
DNA_z_shift = 0;
DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);

number_array=size(DNA_z_position_modi);
number=number_array(1,1);
time=(1:number)./3600;                                                   %ʱ�䵥λ��֡ת��������
plot(DNA_z_position_modi);
% % �ڳ�ԥ��λ��������ǣ�����ѡ������
% hold on
% relax_marker = zeros(size(relax_pos,1),1);
% plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
% hold off
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
    ramp_th = '_1F';
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

%����������λ�ã���ת��Ϊ��ֵ
zmag_ramp = magnet_z_position(start_number:end_number);
% �˴����ó�ʦ�ֵ���ֵУ׼���ݣ���Ϊ���������Գ�ʦ�ֵı�������趨�ģ�280������280��myOne������zmag_che
force_ramp = force_zmag_che(zmag_ramp,0.016);
% semilogy(time(start_number:end_number),force_clamp);
plot(time(start_number:end_number),force_ramp);
xlabel('Time(min)');ylabel('Force(pN)');

%% ѡ��һ��ramp���̽��д���
%ѯ���Ƿ���force ramp ����
disp('�Ƿ���� force ramp ���ߣ�')
yes_ramp = input('�ǻ��߷�','s');
if yes_ramp == '1'
    % ���ȱ���ͼƬ��tif ��ʽ
    fig_name = strcat(name_save,'.fig');
    saveas(gcf,fig_name);
    % ��������
    stepsize= 0.002;
    zmag_start=magnet_z_position(start_number);
   

    %��zmag����������Z�Ĺ켣
    data_ramp = DNA_z_position_modi(start_number:end_number);
    % ����ramp��ʱ��̶ȣ���Ϊʱ�䲽�����Ͷ�Ϊ��ɡ�

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��ȡչ������
    % �����ֵ����extension curve
    zmag_end = magnet_z_position(end_number);
    ext_curve = clamp_ext_mean(data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);
    force_curve = force_zmag_m280(zmag_start:stepsize:zmag_end, 0.01);

    
    figure;
    plot_size = min(size(ext_curve,1),size(force_curve,2));
    ext_curve = ext_curve(1:plot_size);
    force_curve = force_curve(1:plot_size)';
    plot(ext_curve*1000,force_curve,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title(name_save);
    FE_name = strcat(name_save,'_FE.fig');
    saveas(gcf,FE_name);
    force_ramp_name = strcat('new',name_save);
    save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve');

    
end

end

