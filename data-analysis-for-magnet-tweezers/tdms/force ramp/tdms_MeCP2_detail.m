% ���ű���ר�������MeCP2 �յ���Ⱦɫ����ά�ṹչ��ʮ��Ѹ�ٵ���������ڽ�չ��˲��Ŵ󣬲�������չ�����ߵ���һ��۲���ɵġ�
% ���ܸ�׼ȷһЩ�����ǻ��ʵ�ʼ��� zmag ���һЩ���ѣ������û��ǲ��õ�ָ����ϡ�
close all;

clear;
%% ��ȡ�⺯����ͷ�ļ�
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
 NI_TDM_DLL_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %��ȡ������
%     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
 NI_TDM_H_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% ��ָ��TDMS �ļ�
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% �� bead trajectories �ļ�(�Դ������ļ�)
[ DNA_x_modi,DNA_y_modi,DNA_z_position_modi,magnet_z_position] = read_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);

% �ҵ���ԥ������Ͷ��㣬������ǣ�Ϊ�ָ�ͼ�����ο�
relax_pos = find(magnet_z_position == max(magnet_z_position));
end_pos = find(magnet_z_position == min(magnet_z_position));
%% data show

% shift ֵ��ֻ������ͼʱ����
DNA_z_shift =0;
DNA_z_position_modi = DNA_z_position_modi + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
DNA_z_wavelet = DNA_z_wavelet';

number=size(DNA_z_position_modi,1);
time=(1:number)./12000;                                                   %ʱ�䵥λ��֡ת��������,200Hzʱ��12000֡��ע�⣡

plot(DNA_z_position_modi);
% �ڳ�ԥ��λ��������ǣ�����ѡ������
hold on
relax_marker = zeros(size(relax_pos,1),1);
end_marker = zeros(size(end_pos,1),1);
plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
plot(end_pos,end_marker,'k','LineStyle','none','Marker','o');
hold off

%% ѡ����������
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
name_save=strtok(file_name,'.');

%% �������޸ĺ�׺��ʡ�ı������ݺ�һ�����ģ�F����forward, R����reverse
    ramp_th = '_4R';
    name_save = strcat(name_save,ramp_th);
    
%% ����Խ�ȡ��Ƭ�ν��л�ͼ������������
%% force-extension �����׶�
% ��ȡ������ֵ��Ҫ����������, ����Ƿ���ģ�������Ҳ������,ע�� start ��end ��ҲҪ�ߵ�һ�£�����˳���λ
    disp('Forward or Reverse?');
    forward = str2double(input('1=forward, 0 = reverse ','s'));
    if forward ==0
        data_ramp = flipud(DNA_z_position_modi(start_number:end_number))*1000;
        zmag_ramp = flipud(magnet_z_position(start_number:end_number));
        zmag_start=magnet_z_position(end_number);
        zmag_end = magnet_z_position(start_number);

    else
        data_ramp = DNA_z_position_modi(start_number:end_number)*1000;
        zmag_ramp = magnet_z_position(start_number:end_number);
        zmag_start=magnet_z_position(start_number);
        zmag_end = magnet_z_position(end_number);

    end
    save_name = strcat(name_save,'_detail',ramp_th,'.mat');
save(save_name,'data_ramp','zmag_ramp','name_save','ramp_th','forward');


 
end
