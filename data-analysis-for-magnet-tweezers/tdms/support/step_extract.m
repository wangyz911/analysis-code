function step_extract(data_ramp,zmag_ramp,force_stepsize,zmag_start,zmag_end,filefolder,name_save)
%本函数用于提取每个台阶的数据并作图和保存数据，单独建立一个文件夹
%% 首先创建新文件夹
new_file_name=strcat(filefolder,name_save,'step_extract','_',date,'\');
mkdir(new_file_name);                                                      %新建文件夹
cd(new_file_name);                                                         %改变当前路径至
MT_NO = 4.1;
zmag_shift = 0.3;
%% 按照FR 提取数据
force_ramp = force_zmag_m280(zmag_ramp,MT_NO,zmag_shift);
force_start = force_zmag_m280(zmag_start,MT_NO,zmag_shift)+force_stepsize; % 往后推一个台阶，免得鼠标选到第一个台阶末尾，采样点少
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
% 设置其余坐标区属性
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
    
    
    save(new_step_name,'data_step','zmag_start','data_denoised','force_start');                                                %同时保存修正的Z信息和小波滤波的Z信息
    %存储并不等于写入，在载入上有着微妙的差别
    % 下面的操作是为了得到正确的力值，又不影响数据段的选取
    %     force_i(i) = force_zmag_m280(median(zmag_ramp(data_seq)),4.1,zmag_shift);
    force_start = force_start + force_stepsize;
    
end
end

