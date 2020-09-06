
% ���ű����ڴ���ƽ��̬�켣�����Լ���פ��ʱ��ֲ��Լ�
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
name_save=strtok(file_name,'.');
% % �ҵ���ԥ�����䣬������
% relax_pos = find(magnet_z_position == -1.998);

%% data show

% shift ֵ��ֻ������ͼʱ����
DNA_z_shift =0;
DNA_z_position_modi = DNA_z_position_modi + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
DNA_z_wavelet = DNA_z_wavelet';

number=size(DNA_z_position_modi,1);
time=(1:number)./3600;                                                   %ʱ�䵥λ��֡ת��������

plot(DNA_z_position_modi);
% �ڳ�ԥ��λ��������ǣ�����ѡ������
% hold on
% relax_marker = zeros(size(relax_pos,1),1);
% plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
% hold off

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


%% �������޸ĺ�׺��ʡ�ı������ݺ�һ������
    ramp_th = '_1';
    name_save = strcat(name_save,ramp_th);
%% ����ͳ�Ʒ���

disp('---------------��Ҫ������ͳ����0-����Ҫ��1-��Ҫ')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %�����˾ͻ�ͼ��û����Ͳ���
    new_file_name=strcat(Data_Path,name_save,'chi_hist','_','\');
    mkdir(new_file_name);                                                      %�½��ļ���
    subplot(2,1,1);
    plot(DNA_z_position_modi(start_number:end_number),'DisplayName','DNA_z_position','YDataSource','DNA_z_position');grid on;
    hold on
    plot(DNA_z_wavelet(start_number:end_number),'r');
    ylabel('z');
    hold off
    subplot(2,1,2);
    plot(magnet_z_position(start_number:end_number),'LineWidth',1,'DisplayName','magnet_z_position','YDataSource','DNA_z_position');grid on;
    ylabel('magnet_z_position');
    %ylim([-1.1 -0.9]);
 
    deal_number=1;
    DNA_y_position_modi=DNA_y_position-ref_DNA_y_position;                     %������������²��䶨��y
    DNA_x_position_modi=DNA_x_position-ref_DNA_x_position;                     %����x
    
    %�����������¶�
    T = input('T = ','s');
    T = str2double(T);
    
    %���ֺ÷�������㣬�յ㣬����
            disp('---------------��������ͳ�Ƶ������յ�');
        yes_or_no_string2=input('judge1=','s');                                    %*
        if yes_or_no_string2=='1'                                                  %�˴��Ǳ�Ҫ��ͣ�٣�����ȡ�㺯�����������ջ�����ͼ�ϣ�����ֻ������ͼ��ȡ��
            [step_data_x,~] = ginput(2);
            %�õ���ѡ�����յ��ֵ��xֵ����Ҫ��
            step_first_y=magnet_z_position(floor(step_data_x(1,1))+start_number);                           %��ȡ���ͼ���������0��ʼ����Ҫ��ȡ�������������ϵ����кţ���Ҫ����start_number���ܶ�ȡ��ȷ�źš�
            step_end_y=magnet_z_position(floor(step_data_x(2,1))+start_number);
            %��ʼ����λ�õ�������y����
            mean_mag = step_first_y(1,1);
        end
            %���ò���
            stepsize = 0.02;
             %Ԥ������ֵ���ߵľ��󣬴�С�ɷ��������̨�״�С����
            force_curve=zeros(ceil((step_end_y-step_first_y)/stepsize),4);            %��ֵ���ߣ��ֱ��������棬��ֵ��У׼���ȵ���ֵ�����ȡ�
   %Ԥ�����ͼ�ͼ���ĸ��ֲ���         
    fig=3;                                                                     %�趨ͼ���ź���ͼ���
    subfig=1;
    force_number=1;                                                                  %����ţ���ֵ������Ҫ��
    DNA_length=1.034;                                                           %����L���������ȣ���λ��΢��
    Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, ������pN*nm֮������������-2�����Ϊ4.128pN*nm
    %%% �˴� mean_mag == step_end_y�Ĳ���δ������,����һ��С��ʹ�����һ�ο��Ա�����
    while mean_mag < (step_end_y+0.001)                                                        %�����ֶΣ�ֱ������
            %�õ�һ��̨�׵����
            step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %��С��ע�⵽�����ʱ�������λ����0.01���0.009
            %�õ���Ŷ�Ӧ��data_z, data_y ,����λ��
            step_mag = step_mag(step_mag >start_number&step_mag <end_number);

            data_z=DNA_z_position_modi(step_mag);                             %ͬʱ��ȡ������Z��Ϣ��С���˲���Z��Ϣ
            [data_d,step_info]=find_step(data_z);                                                       %ָ���3��С���˲������ڽ����ļ��к��һʱ�佫sigDEN�����ļ��������ļ��С�,�弶�˵�̫���ˣ�ͳ��ͼ���ѿ���
            data_y=DNA_y_position_modi(step_mag)';                           %�õ�y����Ĳ������ݣ���һ���ݲ����˲�

            
            %������ֵ
            data_z_mean=mean(data_d);           %Z�����ֵ����L

            %         deviation_y=var(data_y);
            %         %y�����׼��^2=����,�ĳ��˷����,�����ϵ�force_estimate��
            %             force=force_estimate(data_y,data_cal_mean); 
%             force=Kb_multi_T*data_z_mean*1.0e-3/var_correction(data_y,T);    %��ֵ���㣬���жԷ�������˻���ʱ������
            %����1000����λ���㣬���λ�����ף�F��λ��pN,Ϊʲô+1.4(1.4��2.8΢�׵���İ뾶������֮����ǰڳ�)
            force = force_zmag_che(mean_mag);                                  %��force zmag�Ĺ�ϵ��ӵõ�force����Ϊ���������㲻׼��
            force_curve(force_number,1)=force_number;                      %force_curve��1�б������
            force_curve(force_number,2)=data_z_mean;                       %force_curve ��2������Zֵ��Ҳ����extension
            force_curve(force_number,3)=force;                             %��3��������������ֵ����force
            force_curve(force_number,4)=mean_mag;                          %��4������Zmag
            
            % data_input(:,2)=data_4_analysis;                                           %�������ݣ���һ�ֺ��вο���ֵ��д������һ��Ϊ��ţ��ڶ���Ϊ����
            % data_input(:,1)=(1:size(data_4_analysis,1))';
            title_name=strcat('F=',num2str(force),'length=',num2str(data_z_mean),'Z=',num2str(mean_mag),'NO_',num2str(deal_number));  %������źʹ���λ�ã������Ӧ���ҡ�
            new_data_name=strcat('data_',num2str(deal_number),'.mat');
            new_data_name_y=strcat('data_y',num2str(deal_number),'.mat');
            new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');
            cd(new_file_name);                                                         %�ı䵱ǰ·����
            figure(fig)
            subplot(4,2,subfig);
            plot(step_mag,data_z,'b');hold on;
            plot(step_mag,data_d,'r');
            title(title_name);
            subplot(4,2,subfig+1);
            histogram(data_d);
            subfig=subfig+2;
            if subfig==9
                fig=fig+1;
                subfig=1;
            end
            
            save(new_data_name,'data_z');                                                %ͬʱ����������Z��Ϣ��С���˲���Z��Ϣ
            save(new_data_d_name,'data_d');                                            %�洢��������д�룬������������΢��Ĳ��
%             save(new_data_name_y,'data_y');
            % clear data_4_analysis;
            % clear data_input;
            deal_number=deal_number+1;
            force_number=force_number+1;
            mean_mag = mean_mag + stepsize;


    end
    save('force_extension.mat','force_curve');                                     %������ֵ-������Ϣ
%���õ���F-E������ͼ
force_line = force_curve(:,3);
extension_line = force_curve(:,2);
%����δ��ֵ��Ϊ��ĵ�
force_line(force_line==0)=[];
extension_line(extension_line==0)=[];
%��ͼ
    figure;
    plot(force_line,extension_line,'*');
    title('force-extension');
    ylabel('extension');
    xlabel('force');
end
end

%[data, indexes,lijst,properties,initval]=Steps_Find(new_file_name);
%disp('�������ŵ�̨�ײ�����');
%step_number_string=input('step_number=','s');
%step_number=str2double(step_number_string);
%dummy=Steps_Evaluate(data,indexes,lijst,properties,initval,step_number);


