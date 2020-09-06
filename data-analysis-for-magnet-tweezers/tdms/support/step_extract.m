function step_extract(data_ramp,zmag_ramp,force_stepsize,zmag_start,zmag_end,filefolder,name_save)
%������������ȡÿ��̨�׵����ݲ���ͼ�ͱ������ݣ���������һ���ļ���
%% ���ȴ������ļ���
new_file_name=strcat(filefolder,name_save,'step_extract','_',date,'\');
mkdir(new_file_name);                                                      %�½��ļ���
cd(new_file_name);                                                         %�ı䵱ǰ·����
MT_NO = 4.1;
zmag_shift = 0.3;
%% ����FR ��ȡ����
force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
force_start = force_zmag_m280(zmag_start,MT_NO,zmag_shift)+force_stepsize; % ������һ��̨�ף�������ѡ����һ��̨��ĩβ����������
force_end = force_zmag_m280(zmag_end,MT_NO,zmag_shift);
step = floor((force_end-force_start+0.001)/force_stepsize+1);

for i =1:step
    data_seq = abs(force_ramp-force_start)< 0.02;
    data_step = data_ramp(data_seq);
    zmag_step = zmag_ramp(data_seq);
    N = 1:size(data_step,1);
    time = (N./100)';
    figure;
    plot (time,data_step*1000,'MarkerSize',4,'Marker','.',...
        'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
    hold on
    data_denoised = wdenoise(data_step,5, ...
        'Wavelet', 'sym6', ...
        'DenoisingMethod', 'Bayes', ...
        'ThresholdRule', 'Soft', ...
        'NoiseEstimate', 'LevelIndependent');
    plot(time,data_denoised*1000,'LineWidth',2,'Color',[1 0 0]);
    xlabel('Time/s');ylabel('Ext./nm');
    axes1 = gca;
hold(axes1,'on');
box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
real_shift = 0.3;
real_force = force_zmag_m280(median(zmag_step),MT_NO,real_shift);

    title_name = strcat('F = ',num2str(real_force),'pN');
    title(title_name);
    fig_name = strcat('Force=',num2str(real_force),'.fig');
    h = gcf;
    saveas(h, fig_name,'fig');
    close;
    new_step_name=strcat('data_',num2str(real_force),'.mat');
    %         new_data_name_y=strcat('data_y',num2str(step_number),'.mat');
    
    
    save(new_step_name,'data_step','zmag_start','data_denoised','force_start');                                                %ͬʱ����������Z��Ϣ��С���˲���Z��Ϣ
    %�洢��������д�룬������������΢��Ĳ��
    % ����Ĳ�����Ϊ�˵õ���ȷ����ֵ���ֲ�Ӱ�����ݶε�ѡȡ
    %     force_i(i) = force_zmag_m280(median(zmag_ramp(data_seq)),4.1,zmag_shift);
    force_start = force_start + force_stepsize;
    
end
end

