% G4 data analysis  �ȿ�������Ч���û���
%% -------------------------��ȡ�����ļ�---------------------------
clear;close all;
disp('###########################������������############################')
disp('---------------һ����ȡС��XYZ�����ݣ�-------------------------------')
[FileName,PathName] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName,FileName);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�
standard_string='abcd';      %ΪʲôҪ�ĸ��ַ�
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';                                 %4��һ�����ζ�ȡ�ļ��е��ַ�����strcmp��������ж�������ʼ��'-a!'
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);                                                                %ȥ���ַ�ͷ����ʼ��ȡ����
DNA_x_position_array=textscan(fid,'%f%f');                                 %��ʼ��ȡ����,����һ���������������ɵ�Ԫ�����󣬵�һ����������֡���У��ڶ�����λ����Ϣ
frame_seriels=DNA_x_position_array{1,1};                                   %��ȡDNAx����֡����
DNA_x_position=DNA_x_position_array{1,2};                                  %��ȡx����λ����Ϣ
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
DNA_y_position_array=textscan(fid,'%f%f');                                 %ͬ������ȡy������Ϣ
DNA_y_position=DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
DNA_z_position_array=textscan(fid,'%f%f');                                 %��ȡz��������
DNA_z_position=DNA_z_position_array{1,2};
% ��ȡ�ο�С���XYZ��Ϣ
disp('---------------������ȡ�ο�С��XYZ�����ݣ�-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName2,FileName2);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�
standard_string='abcd';      %ΪʲôҪ�ĸ��ַ�
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';                                 %4��һ�����ζ�ȡ�ļ��е��ַ�����strcmp��������ж�������ʼ��'-a!'
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);                                                                %ȥ���ַ�ͷ����ʼ��ȡ����
ref_DNA_x_position_array=textscan(fid,'%f%f');                                 %��ʼ��ȡ����,����һ���������������ɵ�Ԫ�����󣬵�һ����������֡���У��ڶ�����λ����Ϣ
ref_frame_seriels=ref_DNA_x_position_array{1,1};                                   %��ȡDNAx����֡����
ref_DNA_x_position=ref_DNA_x_position_array{1,2};                                  %��ȡx����λ����Ϣ
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
ref_DNA_y_position_array=textscan(fid,'%f%f');                                 %ͬ������ȡy������Ϣ
ref_DNA_y_position=ref_DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
ref_DNA_z_position_array=textscan(fid,'%f%f');                                 %��ȡz��������
ref_DNA_z_position=ref_DNA_z_position_array{1,2};
%��ȡ��������
disp('---------------������ȡ����z�����ƶ������ݣ�--------------------------')
[FileName3,PathName3] = uigetfile('.gr','�����ƶ��������ļ�');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
magnet_z_position_array=textscan(fid,'%f%f');                              %��ȡ������z�����ƶ������ݣ�����֡������Ϣ��
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
magnet_z_rotation_array=textscan(fid,'%f%f');                              %��ȡ������Z����Ťת������
magnet_z_rotation=magnet_z_rotation_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
magnet_focus_array=textscan(fid,'%f%f');                                   %��ȡ������ƽ��λ�õ�����
magnet_focus=magnet_focus_array{1,2};                                      %���Ϲ��̸���Ƶ�������Խ������ݲ���д�ɺ����ļ���
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
% subplot(2,3,1);
% plot(time(1:end_number),DNA_x_position(1:end_number));
% xlabel('time(min)');ylabel('x');
% subplot(2,3,2);
% plot(time(1:end_number),DNA_y_position(1:end_number),'m');
% xlabel('time(min)');ylabel('y');
% title(name_save);
% subplot(2,3,3);
% plot(time(1:end_number),DNA_z_position(1:end_number));
% xlabel('time(min)');ylabel('z');
% subplot(2,3,4);
% plot(time(1:end_number),magnet_focus(1:end_number));
% xlabel('time(min)');ylabel('focus');
% subplot(2,3,5);
% plot(time(1:end_number),magnet_z_rotation(1:end_number));
% xlabel('time(min)');ylabel('rotation');
% subplot(2,3,6);
% plot(time(1:end_number),magnet_z_position(1:end_number));
% xlabel('time(min)');ylabel('magnet');
% saveas(gcf,strcat(name_save,'_origin','_',date,'.fig'));
% saveas(gcf,strcat(name_save,'_origin','_',date,'.tiff'),'tiffn');
% save (strcat('varible_',name_save,'_origin',date));

%% eliminate the effects of drifting.
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);

subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
force_clamp = (force_zmag_che(magnet_z_position(start_number:end_number)));
semilogy(time(start_number:end_number),force_clamp);
xlabel('Time(min)');ylabel('Force(pN)');
% subplot(3,1,3)
% plot(time(start_number:end_number),fit_DNA(start_number:end_number));
% xlabel('time(min)');ylabel('z_position_filt');
%% ����ͳ�Ʒ���

disp('---------------��Ҫ������ͳ����0-����Ҫ��1-��Ҫ')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %�����˾ͻ�ͼ��û����Ͳ���
    new_file_name=strcat(PathName,name_save,'new','_',date,'\');
    mkdir(new_file_name);                                                      %�½��ļ���
    cd(new_file_name);                                                         %�ı䵱ǰ·����
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
    
%     deal_number=1;
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
    force_number=1;                                                                  %����ţ���ֵ������Ҫ��
%     DNA_length=1.034;                                                           %����L���������ȣ���λ��΢��
%     Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, ������pN*nm֮������������-2�����Ϊ4.128pN*nm

    %%% �˴� mean_mag == step_end_y�Ĳ���δ������,����һ��С��ʹ�����һ�ο��Ա�����
    while mean_mag < (step_end_y +0.001)                                                        %�����ֶΣ�ֱ������
        %�õ�һ��̨�׵����
        step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %��С��ע�⵽������ʱ�������λ������0.01���0.009
        %�õ���Ŷ�Ӧ��data_z, data_y ,����λ��
        step_mag = step_mag(step_mag >start_number&step_mag <end_number);
        
        data_z=DNA_z_position_modi(step_mag);                             %ͬʱ��ȡ������Z��Ϣ��С���˲���Z��Ϣ
        data_d=sigDEN5(data_z);                                                       %ָ���3��С���˲������ڽ����ļ��к��һʱ�佫sigDEN�����ļ��������ļ��С�,�弶�˵�̫���ˣ�ͳ��ͼ���ѿ���
        data_y=DNA_y_position_modi(step_mag)';                           %�õ�y����Ĳ������ݣ���һ���ݲ����˲�
        %             data_x=DNA_x_position_modi(step_mag)';
        % data_cal=data+(DNA_length-mean(data_d));
        
        %������ֵ
        data_z_mean=mean(data_d);           %Z�����ֵ����L
        
        %         deviation_y=var(data_y);
        %         %y�����׼��^2=����,�ĳ��˷����,�����ϵ�force_estimate��
        %             force=force_estimate(data_y,data_cal_mean);
        %             force=Kb_multi_T*data_z_mean*1.0e-3/var_correction(data_y,T);    %��ֵ���㣬���жԷ�������˻���ʱ������
        %����1000����λ���㣬���λ�����ף�F��λ��pN,Ϊʲô+1.4(1.4��2.8΢�׵���İ뾶������֮����ǰڳ�)
        
        %%%% ��ֵ��������ʱ��ʦ�ֵ�У׼����
        force = force_zmag_che(mean_mag);                                  %��force zmag�Ĺ�ϵ��ӵõ�force����Ϊ���������㲻׼��
        force_curve(force_number,1)=force_number;                      %force_curve��1�б������
        force_curve(force_number,2)=data_z_mean;                       %force_curve ��2������Zֵ��Ҳ����extension
        force_curve(force_number,3)=force;                             %��3��������������ֵ����force
        force_curve(force_number,4)=mean_mag;                          %��4������Zmag
        
        % data_input(:,2)=data_4_analysis;                                           %�������ݣ���һ�ֺ��вο���ֵ��д������һ��Ϊ��ţ��ڶ���Ϊ����
        % data_input(:,1)=(1:size(data_4_analysis,1))';
        title_name=strcat('F=',num2str(force),'length=',num2str(data_z_mean),'Z=',num2str(mean_mag),'NO.',num2str(force_number));  %������źʹ���λ�ã������Ӧ���ҡ�
%         new_data_name=strcat('data_',num2str(deal_number),'.mat');
%         new_data_name_y=strcat('data_y',num2str(deal_number),'.mat');
%         new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');
          new_hist_name = strcat('hist','_',num2str(force_number));
        % ��ͼ
        figure(3);
        % ��ֱ��ͼ����һ��ͼ�ϻ�����������һ�ε�ͼ��
        hold off
        h = histogram(data_d);
        title(title_name);
        hold on
        h.Normalization = 'probability';
        ext = h.BinEdges(2:end);
        P = h.Values;
        h = gcf;
        saveas(h, new_hist_name,'fig');
        force_clamp = ones(1,size(P,2)) * force;
        figure(1);
        %��ֱ��ͼ����һ��3Dͼ�У�������֮ǰ��ͼ��
        plot3(ext,force_clamp,P);
        hold on
%         save(new_data_name,'data_z');                                                %ͬʱ����������Z��Ϣ��С���˲���Z��Ϣ
%         save(new_data_d_name,'data_d');                                            %�洢��������д�룬������������΢��Ĳ��
        %           save(new_data_name_y,'data_y');
        % clear data_4_analysis;
%         % clear data_input;
%         deal_number=deal_number+1;
        force_number=force_number+1;
        mean_mag = mean_mag + stepsize;
        
    end
    save('force_extension.mat','force_curve');                                     %������ֵ-������Ϣ
    figure(1);
    view(-23.1,66.8);
    h = gcf;
    saveas(h, 'ext_probability','fig');
%     %���õ���F-E������ͼ
%     force_line = force_curve(:,3);
%     extension_line = force_curve(:,2);
%     %����δ��ֵ��Ϊ��ĵ�
%     force_line(force_line==0)=[];
%     extension_line(extension_line==0)=[];
%     %��ͼ
%     figure;
%     plot(force_line,extension_line,'*');
%     title('force-extension');
%     ylabel('extension');
%     xlabel('force');
end


%[data, indexes,lijst,properties,initval]=Steps_Find(new_file_name);
%disp('�������ŵ�̨�ײ�����');
%step_number_string=input('step_number=','s');
%step_number=str2double(step_number_string);
%dummy=Steps_Evaluate(data,indexes,lijst,properties,initval,step_number);






plot3(0,0,0);
hold on
histogram(data_z);










