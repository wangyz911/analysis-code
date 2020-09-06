%���ű�����������G4 DNA��ƽ��̬force ramp�����ݽ��зֶΣ�������ֵ��ͼ������step�ϵ���ϣ�����¼��break point ��λ��


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
[ ~,~,~,DNA_z_position ] = read_pico3( fid );
% %һά����������Z��
% [ DNA_z_position ] = read_pico1( fid );

% ��ȡ�ο�С���XYZ��Ϣ
disp('---------------������ȡ�ο�С��XYZ�����ݣ�-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','λ�������ļ�');                      %��׼�Ĵ��ļ��Ի��򣬵�һ����Ϊ�ļ���ʽ���ڶ�����Ϊ�Ի���������
file=strcat(PathName2,FileName2);                                            %����·�������ļ�����Ϊ������׼����
fid=fopen(file, 'r');                                                      %��ȡ�ļ����ļ�����·�����ϡ�

[ ~,~,~,ref_DNA_z_position ] = read_pico3( fid );

% [ ref_DNA_z_position ] = read_pico1( fid );

%��ȡ��������
disp('---------------������ȡ����z�����ƶ������ݣ�--------------------------')
[FileName3,PathName3] = uigetfile('.gr','�����ƶ��������ļ�');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
% ��ȡ�����˶��ļ�������˳��ֱ��ǣ�֡���У�����λ�ã���ת����ƽ�档
[ ~,magnet_z_position,~,~ ] = read_pico3( fid );

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
name_save=FileName(1:name_length-3);
figure('Name',name_save);


%% eliminate the effects of drifting.
DNA_z_position_modi=DNA_z_position - ref_DNA_z_position;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
% ���Ƴ�ref��Ĺ켣�������ж�Ծ��Ŀɿ��ԡ�
DNA_z_ref = sigDEN5(ref_DNA_z_position);
subplot(2,1,1);
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number)*1000,'k');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number)*1000,'r');
plot(time(start_number:end_number),ref_DNA_z_position(start_number:end_number)*1000,'g');
xlabel('Time(min)');ylabel('Ext.(nm)');
hold off
subplot(2,1,2);
force_ramp = (force_zmag_m280(magnet_z_position(start_number:end_number)));
% semilogy(time(start_number:end_number),force_clamp);
plot(time(start_number:end_number),force_ramp);
xlabel('Time(min)');ylabel('Force(pN)');
%%  ����find�����ҳ�force ramp ��������ݣ����ҷֶ�
disp('�Ƿ�ֶ�')
segment_yes = input('�ֶΣ�','s');
if segment_yes == '1'
    
    
    
    %�ҳ� force_ramp ̬, ע��zmagֵ���Ǹ��ģ�Ҫ�üӺ�
    %����̬���꣬���޸�
    ramp_start = -1.998 ;
    stepsize= 0.002;
    step_num = 900;
    %�ҳ�������ramp���ֵ���ϵĲ��֣���ramp����
    tension_index = find(magnet_z_position(start_number:end_number) - ramp_start > 0);
    
    %��ramp���ֽ��в�֣������������1���������ǲ�ͬ����Ķϵ�
    diff_tension_index = diff(tension_index);
    %�õ��ϵ����꣬ע�������Ƕ�diff�����꣬��diff��break_point������zmag�е�����
    break_point = find(diff_tension_index>10);
    %��ȡÿһ�εĳ���
    segment_length = zeros(size(break_point,1),1);
    segment_length(1) = break_point(1);
    segment_length(2:end) = diff(break_point);
    %�õ��ֶ�����Ԥ�ƽ������
    segment_number = size(break_point,1) + 1;
    start_end_number = zeros(segment_number,2);
    %�Ա���̬�����ݽ��зֶΣ��ֶε������յ㱣����start_end_number������
    for i = 1:segment_number
        if i ==1
            start_end_number(i,1) = tension_index(1) + start_number;
            start_end_number(i,2) = start_end_number(i,1) + segment_length(i);
            %�Ե�һ����˵�����������㣬�յ��ǵ�һ��diff�㣨diff�����Զ�ʹ�ý����������һλ��
            
        elseif i<segment_number
            %���м�Σ���i�ε�����ǵ�i-1���յ���϶�Ӧ��diffֵ,�յ��ǵ�i�ε���������һ�εĳ���diff(break_point)
            start_end_number(i,1) = start_end_number(i-1,2) + diff_tension_index(break_point(i-1));
            start_end_number(i,2) = start_end_number(i,1)+ segment_length(i);
        else
            start_end_number(i,1) = start_end_number(i-1,2) + diff_tension_index(break_point(i-1));
            start_end_number(i,2) = tension_index(end) + start_number;
        end
    end
    %��ȥ��β���ɸ��㣬����һЩ�񵴲����Ļ���
    start_end_number(:,1) = start_end_number(:,1)-20;
    start_end_number(:,2) = start_end_number(:,2)-10;
    % �趨�������ͼ�����,���ﱣ��Ծ��λ�õ�Zֵ��Fֵ����ʱԾ�����������������*24ȷ���㹻�Ŀռ䡣
    z_rupture_num = zeros(segment_number,1);
    ext_curve = zeros(segment_number,step_num);
    % �������ж������켣�ļ�������
    trajectory_count = 0;
    
    
    loading_rate = '0.2pN';
    %% �ֱ��ÿ��ramp���̽��д���
    %ѯ���Ƿ���force ramp ����
    disp('�Ƿ���� force ramp ���ߣ�')
    yes_ramp = input('�ǻ��߷�','s');
    if yes_ramp == '1'
        
        %��ѡ��ӵڼ��ο�ʼ����
        disp('�ӵڼ��ο�ʼ���з�����(��һ��ֻ�ܴ�ͷ��ʼ)')
        yes_segment = input('�ڼ��� = ','s');
        
        start_segment_num = round(str2double(yes_segment));
        
        trajectory_count = 0;
        %figure �������棬�������Ҫ�ر�ͼ��ҳ�������
        figure;
        for i = start_segment_num : segment_number
            %��zmag����������Z�Ĺ켣
            data_ramp = DNA_z_position_modi(start_end_number(i,1):start_end_number(i,2));
            data_ref = ref_DNA_z_position(start_end_number(i,1):start_end_number(i,2));
            N = size(data_ramp,1);
            % ����ramp��ʱ��̶ȣ���Ϊʱ�䲽�����Ͷ�Ϊ��ɡ�
            ramp_time =(1:N)/60;
            %����������λ�ã���ת��Ϊ��ֵ
            zmag_ramp = magnet_z_position(start_end_number(i,1):start_end_number(i,2));
            % �˴����ó�ʦ�ֵ���ֵУ׼���ݣ���Ϊ���������Գ�ʦ�ֵı�������趨��
            force_ramp = force_zmag_m280(zmag_ramp);
            %��С���˲�ƽ������
            data_ramp_d = sigDEN5(data_ramp);
            data_ref_d = sigDEN5(data_ref);
            %�����������ͼ��ͬʱ���²������ֵ
            subplot(2,1,1)
            plot(ramp_time,data_ramp,ramp_time,data_ramp_d);
            hold on
            plot(ramp_time,data_ref_d);
            hold off
            subplot(2,1,2)
            plot(ramp_time,force_ramp);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %��ͼ�����Ƿ���ƣ����ͼ�񲻺þ�����������ý��й���
            %��Ҫ��һ���Ƿ�����ܿ���
            disp(num2str(i))
            disp('good data ? ��')
            ramp_NO = num2str(i);
            fig_name = strcat(name_save,ramp_NO,'.fig');
            
            good_data = input('good or bad','s');
            if good_data =='1'
                % ���ȱ���ͼƬ��tif ��ʽ
                saveas(gcf,fig_name);
                %Ȼ����ÿһ�������Ƿ��¼
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %��ȡչ������
                
                %                 yes_or_no = input('�м���չ�� ','s');
                %                 n = round(str2double(yes_or_no));
                %                 %��չ������ͳ�Ƶ�������
                %                 z_rupture_num = n;
                %                 trajectory_count = trajectory_count+1;
                % �����ֵ����extension curve

                zmag_start=magnet_z_position(start_number);
                zmag_end = magnet_z_position(end_number);
                ext_curve(i,:) = ramp_ext_mean(data_ramp,zmag_ramp,zmag_start,zmag_end,stepsize);
                force_curve = force_zmag_m280(zmag_start:stepsize:zmag_end);
                figure;
                plot(ext_curve,force_curve);
                %����һ����;�˳�����
            elseif strcmp(yes_or_no,'exit')
                break;
            end
            
        end
        
    end
    
    %% ��ȡ��һ�����ݵ����н���󣬱�����
    %����0Ԫ�أ��������õĽ����
    
    
    
    force_ramp_name = strcat('force_ramp_MeCP2_24NC_',name_save);
    save(strcat(force_ramp_name,'.mat'), 'ext_curve');
    
end
close all;


