%ִ��פ��ʱ��ͳ�ƵĽű���˳�������פ��ʱ����صĲ�����

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
fgetl(fid);                                      
%ȥ���ַ�ͷ����ʼ��ȡ����
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


%% eliminate the effects of drifting.
DNA_y_position_modi = DNA_y_position - ref_DNA_y_position;
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position-0.5;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
xlabel('Time (min)');ylabel('Ext. (nm)');
hold off
subplot(2,1,2);
force_clamp = force_zmag_pico(magnet_z_position(start_number:end_number));
semilogy(time(start_number:end_number),force_clamp);
xlabel('Time (min)');ylabel('Force (pN)');
% subplot(3,1,3)
% plot(time(start_number:end_number),fit_DNA(start_number:end_number));
% xlabel('time(min)');ylabel('z_position_filt');
%% ����ͳ�Ʒ���

disp('---------------��Ҫ������&פ��ʱ��ͳ����0-����Ҫ��1-��Ҫ')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %�����˾ͻ�ͼ��û����Ͳ���
    new_file_name=strcat(PathName,name_save,'dwelltime2','_',date,'\');
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
 
    deal_number=1;
    DNA_y_position_modi=DNA_y_position-ref_DNA_y_position;                     %������������²��䶨��y
    DNA_x_position_modi=DNA_x_position-ref_DNA_x_position;                     %����x
    
%�����������¶�
    T = input('T = ','s');
    T = str2double(T);
    
%���ֺ÷�������㣬�յ㣬����
            disp('---------------����פ��ʱ������������յ�');
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
    s = input('�����벽��','s');
    stepsize = str2double(s);

     %Ԥ���ñ����������ľ��󣬴�С�ɷ��������̨�״�С����
    dwell_time_curve=zeros(ceil((step_end_y-step_first_y)/stepsize),7);            %��ֵ���ߣ��ֱ���������zmag����ֵ��k_unfold,k_fold��       
    time_number=1;                                                                  %����ţ���ֵ������Ҫ��
    DNA_length=1.034;                                                           %����L���������ȣ���λ��΢��
    Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, ������pN*nm֮������������-2�����Ϊ4.128pN*nm
    
    %% �˴� mean_mag == step_end_y�Ĳ���δ������,����һ��С��ʹ�����һ�ο��Ա�����   
    %������������txt�ĵ�

fileID = fopen('step_and_std.txt','a');
fileID2 = fopen('time_domination.txt','a');
fprintf(fileID,'%8s %12s\n','step','step_std');
fprintf(fileID2,'%6s %12s %12s\n','fold','mid','unfold');
non = [];

    while mean_mag < (step_end_y+0.001)                                                        %�����ֶΣ�ֱ������
            %�õ�һ��̨�׵����
            step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %��С��ע�⵽������ʱ�������λ������0.01���0.009
            %�õ���Ŷ�Ӧ��data_z, data_y ,����λ��
            step_mag = step_mag(step_mag >start_number&step_mag <end_number);

            data_z=DNA_z_position_modi(step_mag);                             %ͬʱ��ȡ������Z��Ϣ��С���˲���Z��Ϣ
            data_y=DNA_y_position_modi(step_mag);
            % ��data_z����step-detect ������������ں���ķ�����
            step_position = J_search(data_z,0.7);
            length_check = 5;
            step_check = 0.002;%�˳��Ƚ�С������step
            % �� data_z���в�����������ȡ����ϲ���
            [ data_d,step,step_std,~,good1] = step_modulation( data_z,step_position,step_check,length_check);
            if good1==1

            % ����ͼ������ϱ���ͼ��
            
            step_fig_name = strcat('step',num2str(time_number),'.fig');
            h = gcf;
            saveas(h, step_fig_name,'fig');
            fprintf(fileID,'%6.8f \t',step);
            fprintf(fileID,'%6.8f \t',step_std);
            fprintf(fileID,'%f\r\n',non);
            % �� data_z����פ��ʱ���������ȡ����ϲ���

            [k_unfold,k_mid,k_fold,good,time_domination] = dwell_time_count(data_z,step_position,step_check,length_check);
            time_fig_name = strcat('dwelltime',num2str(time_number),'.fig');
            h = gcf;
            saveas(h, time_fig_name,'fig');
            % ���down����0��˵��û��������һ�η�������ִ�к����������0,��������һѭ����
            % �õ���Ͻ���󣬵�����Ͻ����������k_fold and k_unfold
            if good ==1

            
            fprintf(fileID2,'%6.8f %12.8f %12.8f\r\n',time_domination);
            %������ֵ
            data_z_mean=mean(data_d);           %Z�����ֵ����L
%         deviation_y=var(data_y);
%         %y�����׼��^2=����,�ĳ��˷����,�����ϵ�force_estimate��
%         force=force_estimate(data_y,data_cal_mean); 
%         force=Kb_multi_T*data_z_mean*1.0e-3/var_correction(data_y,T);    %��ֵ���㣬���жԷ�������˻���ʱ������
                                                                           %����1000����λ���㣬���λ�����ף�F��λ��pN,Ϊʲô+1.4(1.4��2.8΢�׵���İ뾶������֮����ǰڳ�)
% ���������
            force = force_zmag_che(mean_mag,0.015);                                  %��force zmag�Ĺ�ϵ��ӵõ�force����Ϊ���������㲻׼��
            dwell_time_curve(time_number,1)=time_number;                      %time_curve��1�б������
            dwell_time_curve(time_number,2)=data_z_mean;                       %time_curve ��2������Zֵ��Ҳ����extension
            dwell_time_curve(time_number,3)=force;                             %��3��������������ֵ����force
            dwell_time_curve(time_number,4)=mean_mag;                          %��4������Zmag
            dwell_time_curve(time_number,5)=k_unfold;
            dwell_time_curve(time_number,6)=k_fold;
            dwell_time_curve(time_number,7)=k_mid;
%����ԭʼ����
            new_data_name=strcat('data_',num2str(deal_number),'.mat');
            new_data_name_y=strcat('data_y',num2str(deal_number),'.mat');
            new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');

            save(new_data_name,'data_z');                                                %ͬʱ����������Z��Ϣ��С���˲���Z��Ϣ
            save(new_data_d_name,'data_d');                                            %�洢��������д�룬������������΢��Ĳ��
            save(new_data_name_y,'data_y');
            % clear data_4_analysis;
            % clear data_input;
            end
            end
% ������һѭ��������+1��������һ��            
            deal_number=deal_number+1;
            time_number=time_number+1;
            mean_mag = mean_mag + stepsize;


    end
    fclose(fileID);
    save('dwell_time_data.mat','dwell_time_curve','time_domination');     

    % ѭ����ɣ��ر��ļ���
                                %������ֵ-������Ϣ
   %% %���²���ר�ŷ�����̬���̣�����д��һ�����������뺯����dwell_time_curve;

   disp('how many states are the system ? ');
   states =str2double(input('states = ? ','s'));
   if states==2
       T = 31;
       [ dx_f,dG0_f,dx_u,dG0_u,k0_u,k0_f,G0,G0_u_minus_f,G0_uf,nt,Feq,keq,teq] = FC_calculate_2( dwell_time_curve,T );
       % ��Ҫ������������
       
   elseif states ==3
       [ dx_f,dG0_f,dx_u,dG0_u,k0_u,k0_f,G0,G0_u_minus_f,G0_uf,~] = FC_calculate_3( dwell_time_curve,T );
       
   else
       
   end
   
% force_line = dwell_time_curve(:,3);
% k_unfold_line = dwell_time_curve(:,5);
% k_fold_line = dwell_time_curve(:,6);
% %����δ��ֵ��Ϊ��ĵ�
% force_line(force_line==0)=[];
% k_unfold_line(k_unfold_line==0)=[];
% k_fold_line(k_fold_line==0)=[];
% k_u_log = log(k_unfold_line);
% k_f_log = log(k_fold_line);
% % �Է�Ӧ������������ϵõ�dx �� dG������������Ϊ��Ȼ�����dGO��.
% [fit_fold,s_f] = polyfit(force_line,k_f_log,1);
% [fit_unfold,s_u]= polyfit(force_line,k_u_log,1);
% Kb_T = 1.3806504e-2*(T+273.15); 
% % ���շ������
% dx_f = fit_fold(1)*Kb_T;
% dG0_f = -fit_fold(2);
% k0_f = exp(-dG0_f);
% dx_u = fit_unfold(1)*Kb_T;
% dG0_u = -fit_unfold(2);
% k0_u = exp(-dG0_u);
% % �����ܻ���Ҫ��ȥ���������������ܺ�G4���������ܵȵȣ�ͳ��G_stretch
% lnK = k_u_log./k_f_log;
% dx_uf = dx_u-dx_f;
% [G0,G0_uf] = G0_modi(lnK,force_line,T,dx_uf);
% %��һ�ַ����������G0
% G0_u_minus_f = dG0_u - dG0_f;
% 
% 
% save('dwell_time_results.mat','dx_f','dG0_f','dx_u','dG0_u','k0_u','k0_f','G0','G0_u_minus_f','G0_uf','s_u','s_f');
% %��ͼ
%     figure;
%     hold on;
%     plot(force_line,k_u_log,'*');
%     plot(force_line,polyval(fit_unfold,force_line),'b');
%     plot(force_line,k_f_log,'o');
%     plot(force_line,polyval(fit_fold,force_line),'r');
%     title('rate-force');
%     ylabel('lnk');
%     xlabel('force/pN');
%     legend('ku(f)','fit ku(f)','kf(f)','fit kf(f)')
%     h = gcf;
%     saveas(h,'k_vs_force','fig');
end
