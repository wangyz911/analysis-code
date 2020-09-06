% ���ű����ϴ����ϵ�����������F-E

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
[ ~,DNA_x_pos,DNA_y_pos,DNA_z_pos ] = read_pico3( fid );
% %һά����������Z��
% [ DNA_z_position ] = read_pico1( fid );

% ��ȡ�ο�С���XYZ��Ϣ
disp('---------------������ȡ�ο�С��XYZ�����ݣ�-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName2,FileName2);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�

[ ~,ref_DNA_x_pos,ref_DNA_y_pos,ref_DNA_z_pos ] = read_pico3( fid );

% [ ref_DNA_z_pos ] = read_pico1( fid );

%��ȡ��������
disp('---------------������ȡ����z�����ƶ������ݣ�--------------------------')
[FileName3,PathName3] = uigetfile('.gr','�����ƶ��������ļ�');
file=strcat(PathName3,FileName3);
fid=fopen(file, 'r');
% ��ȡ�����˶��ļ�������˳��ֱ��ǣ�֡���У�����λ�ã���ת����ƽ�档
[ ~,magnet_z_position,~,~ ] = read_pico3( fid );

% %һά����������magnet position��
% [ DNA_z_position ] = read_pico1( fid );

%% data show

DNA_x_pos_modi = DNA_x_pos - ref_DNA_x_pos;
DNA_y_pos_modi = DNA_y_pos - ref_DNA_y_pos;
DNA_z_pos_modi = DNA_z_pos - ref_DNA_z_pos;


% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;


number=size(DNA_z_pos_modi,1);
time=(1:number)./3600;                                                   %ʱ�䵥λ��֡ת��������

plot(DNA_z_pos_modi);
% �ڳ�ԥ��λ��������ǣ�����ѡ������
% hold on
% relax_marker = zeros(size(relax_pos,1),1);
% plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
% hold off

disp('��ѡ����ʵ�����')

if input('����1ѡ������','s')=='1'

[start_number,~]=ginput(1);
start_number=floor(start_number);
if start_number<1
    start_number=1;
end

[end_number,~]=ginput(1);                                          %���ȡ�����öϵ�  ��
end_number=floor(end_number);                                          %����ȡ��
if end_number>number
    end_number=number;
end

% name_save=FileName(13:name_length-3);
% �����������ֱ�ӽ�ȡ�ļ�������Ҫ���֣�ȥ����׺�����ȼ��ַ�����������
name_save=strtok(FileName,'.');

%% �������޸ĺ�׺��ʡ�ı������ݺ�һ������
    ramp_th = '_test';
    name_save = strcat(name_save,ramp_th);
    

%% force-extension �����׶�
% shift ֵ �����ڽ�������������Ϊ�������ֵ�ϣ�
mol_length = 3;
bead_r = 0.5;
DNA_z_shift = mol_length + bead_r - max(DNA_z_pos_modi(start_number:end_number));
DNA_z_pos_modi = DNA_z_pos_modi + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_pos_modi);
DNA_z_wavelet = DNA_z_wavelet';
% ��ȡ������ֵ��Ҫ����������
data_ramp = DNA_z_pos_modi(start_number:end_number);
x_pos_ramp = DNA_x_pos_modi(start_number:end_number);
y_pos_ramp = DNA_y_pos_modi(start_number:end_number);
% y_pos_ramp_modi = y_pos_ramp/0.059*0.072;
zmag_ramp = magnet_z_position(start_number:end_number);
% �Ȼ����켣ͼ�� ��Ӧ�����켣��ѯ���Ƿ�Ҫ��F-E ������
figure('Name',name_save);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_pos_modi(start_number:end_number)*1000,'k');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
plot(time(start_number:end_number),zmag_ramp);
xlabel('Time(min)');ylabel('Zmag(mm)');
% ѯ���Ƿ���� F-E ����
disp('�Ƿ���� force ramp ���ߣ�')
yes_ramp = input('�ǻ��߷�','s');
if yes_ramp == '1'
    % ���ȱ���ͼƬ��tif ��ʽ
    fig_name = strcat(name_save,'.fig');
    saveas(gcf,fig_name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��������
    stepsize= 0.002;
    zmag_start=magnet_z_position(start_number);
    zmag_end = magnet_z_position(end_number);
    % ����ramp��ʱ��̶ȣ���Ϊʱ�䲽�����Ͷ�Ϊ��ɡ�
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��ȡչ������
    % �����ֵ����extension curve
    ext_curve = ramp_ext_mean(data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);


    [force_curve,dr] = ramp_force_mean( ext_curve,x_pos_ramp,y_pos_ramp,zmag_ramp,zmag_start,zmag_end,stepsize );
    
    figure;
    plot_size = min(size(ext_curve,1),size(force_curve,1));
    ext_curve = ext_curve(1:plot_size);
    force_curve = force_curve(1:plot_size);
    plot(ext_curve,force_curve,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title(name_save);
    FE_name = strcat(name_save,'_FE.fig');
    saveas(gcf,FE_name);
    force_ramp_name = strcat('force_ramp_MeCP2_24NC_',name_save);
    save(strcat(force_ramp_name,'.mat'), 'name_save','ext_curve','force_curve','dr');

    
end

end

