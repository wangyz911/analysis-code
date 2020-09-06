% G4 data analysis  比卡方估计效果好还快
%% -------------------------读取数据文件---------------------------
clear;close all;
disp('###########################程序处理的流程############################')
disp('---------------一、读取小球XYZ的数据：-------------------------------')
[FileName,PathName] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName,FileName);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
standard_string='abcd';      %为什么要四个字符
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';                                 %4个一组依次读取文件中的字符，与strcmp结合用来判断数据起始点'-a!'
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);                                                                %去掉字符头，开始读取数据
DNA_x_position_array=textscan(fid,'%f%f');                                 %开始读取数据,生成一个两个列向量构成的元胞矩阵，第一个列向量是帧序列，第二个是位置信息
frame_seriels=DNA_x_position_array{1,1};                                   %读取DNAx方向帧序列
DNA_x_position=DNA_x_position_array{1,2};                                  %读取x方向位置信息
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
DNA_y_position_array=textscan(fid,'%f%f');                                 %同理，读取y方向信息
DNA_y_position=DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
DNA_z_position_array=textscan(fid,'%f%f');                                 %读取z方向数据
DNA_z_position=DNA_z_position_array{1,2};
% 读取参考小球的XYZ信息
disp('---------------二、读取参考小球XYZ的数据：-------------------------------')
[FileName2,PathName2] = uigetfile('.gr','位置数据文件');                      %标准的打开文件对话框，第一参数为文件格式，第二参数为对话框名……
file=strcat(PathName2,FileName2);                                            %连接路径名，文件名，为调用做准备。
fid=fopen(file, 'r');                                                      %读取文件，文件名及路径如上。
standard_string='abcd';      %为什么要四个字符
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';                                 %4个一组依次读取文件中的字符，与strcmp结合用来判断数据起始点'-a!'
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);                                                                %去掉字符头，开始读取数据
ref_DNA_x_position_array=textscan(fid,'%f%f');                                 %开始读取数据,生成一个两个列向量构成的元胞矩阵，第一个列向量是帧序列，第二个是位置信息
ref_frame_seriels=ref_DNA_x_position_array{1,1};                                   %读取DNAx方向帧序列
ref_DNA_x_position=ref_DNA_x_position_array{1,2};                                  %读取x方向位置信息
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
ref_DNA_y_position_array=textscan(fid,'%f%f');                                 %同理，读取y方向信息
ref_DNA_y_position=ref_DNA_y_position_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
ref_DNA_z_position_array=textscan(fid,'%f%f');                                 %读取z方向数据
ref_DNA_z_position=ref_DNA_z_position_array{1,2};
%读取磁铁数据
disp('---------------三、读取磁铁z方向移动的数据：--------------------------')
[FileName3,PathName3] = uigetfile('.gr','磁铁移动的数据文件');
file=strcat(PathName3,FileName3);fid=fopen(file, 'r');
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
magnet_z_position_array=textscan(fid,'%f%f');                              %读取磁铁在z方向移动的数据，包括帧序列信息。
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
magnet_z_rotation_array=textscan(fid,'%f%f');                              %读取磁铁在Z方向扭转的数据
magnet_z_rotation=magnet_z_rotation_array{1,2};
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
magnet_focus_array=textscan(fid,'%f%f');                                   %读取磁镊焦平面位置的数据
magnet_focus=magnet_focus_array{1,2};                                      %以上过程复用频繁，可以讲读数据部分写成函数文件。
%%data show
number_array=size(DNA_z_position);
number=number_array(1,1);
time=(1:number)./60./60;                                                   %时间单位由帧转换到分钟
plot(DNA_z_position);
[start_number,start_y]=ginput(1);
start_number=floor(start_number);
if start_number<1
    start_number=1;
end
[end_number,end_y]=ginput(1);                                          %鼠标取点设置断点  ？
end_number=floor(end_number);                                          %向下取整
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
%% 步长统计分析

disp('---------------需要做步长统计吗？0-不需要；1-需要')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不画
    new_file_name=strcat(PathName,name_save,'new','_',date,'\');
    mkdir(new_file_name);                                                      %新建文件夹
    cd(new_file_name);                                                         %改变当前路径至
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
    DNA_y_position_modi=DNA_y_position-ref_DNA_y_position;                     %跳过算力情况下补充定义y
    DNA_x_position_modi=DNA_x_position-ref_DNA_x_position;                     %定义x
    
    %请输入试验温度
    T = input('T = ','s');
    T = str2double(T);
    
    %划分好分析的起点，终点，步长
    disp('---------------请点击步长统计的起点和终点');
    yes_or_no_string2=input('judge1=','s');                                    %*
    if yes_or_no_string2=='1'                                                  %此处是必要的停顿，否则取点函数会锁定到刚画出的图上，我们只能在总图上取点
        [step_data_x,~] = ginput(2);
        %得到所选起点和终点的值（x值不重要）
        step_first_y=magnet_z_position(floor(step_data_x(1,1))+start_number);                           %截取后的图像新坐标从0开始，而要读取的数据沿用了老的序列号，需要加上start_number才能读取正确信号。
        step_end_y=magnet_z_position(floor(step_data_x(2,1))+start_number);
        %初始磁铁位置等于起点的y坐标
        mean_mag = step_first_y(1,1);
    end
    %设置步长
    stepsize = 0.02;
    %预设置力值曲线的矩阵，大小由分析区间和台阶大小决定
    force_curve=zeros(ceil((step_end_y-step_first_y)/stepsize),4);            %力值曲线，分别用来保存，力值，校准长度的力值，长度。
    %预设好作图和计算的各种参数
    force_number=1;                                                                  %总序号，力值曲线需要用
%     DNA_length=1.034;                                                           %定义L，轮廓长度，单位是微米
%     Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, 换成了pN*nm之后数量级降到-2，结果为4.128pN*nm

    %%% 此处 mean_mag == step_end_y的部分未被分析,加上一个小量使得最后一段可以被分析
    while mean_mag < (step_end_y +0.001)                                                        %反复分段，直到分完
        %得到一个台阶的序号
        step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %最小误差，注意到马达有时候会有移位出错，0.01变成0.009
        %得到序号对应的data_z, data_y ,磁铁位置
        step_mag = step_mag(step_mag >start_number&step_mag <end_number);
        
        data_z=DNA_z_position_modi(step_mag);                             %同时提取修正的Z信息和小波滤波的Z信息
        data_d=sigDEN5(data_z);                                                       %指令化的3级小波滤波，须在建立文件夹后第一时间将sigDEN函数文件拷到该文件夹。,五级滤掉太多了，统计图很难看。
        data_y=DNA_y_position_modi(step_mag)';                           %得到y方向的波动数据，这一数据不能滤波
        %             data_x=DNA_x_position_modi(step_mag)';
        % data_cal=data+(DNA_length-mean(data_d));
        
        %计算力值
        data_z_mean=mean(data_d);           %Z方向均值，即L
        
        %         deviation_y=var(data_y);
        %         %y方向标准差^2=方差,改成了方差函数,已整合到force_estimate中
        %             force=force_estimate(data_y,data_cal_mean);
        %             force=Kb_multi_T*data_z_mean*1.0e-3/var_correction(data_y,T);    %力值计算，其中对方差进行了积分时间修正
        %除以1000，单位换算，最后单位是纳米，F单位是pN,为什么+1.4(1.4是2.8微米的球的半径，加上之后才是摆长)
        
        %%%% 力值方面用暂时车师兄的校准曲线
        force = force_zmag_che(mean_mag);                                  %用force zmag的关系间接得到force，因为短链的力算不准。
        force_curve(force_number,1)=force_number;                      %force_curve第1列标明序号
        force_curve(force_number,2)=data_z_mean;                       %force_curve 第2列输入Z值，也就是extension
        force_curve(force_number,3)=force;                             %第3列输入计算出的力值，即force
        force_curve(force_number,4)=mean_mag;                          %第4列输入Zmag
        
        % data_input(:,2)=data_4_analysis;                                           %输入数据（是一种很有参考价值的写法）第一列为序号，第二列为数据
        % data_input(:,1)=(1:size(data_4_analysis,1))';
        title_name=strcat('F=',num2str(force),'length=',num2str(data_z_mean),'Z=',num2str(mean_mag),'NO.',num2str(force_number));  %增加序号和磁镊位置，方便对应查找。
%         new_data_name=strcat('data_',num2str(deal_number),'.mat');
%         new_data_name_y=strcat('data_y',num2str(deal_number),'.mat');
%         new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');
          new_hist_name = strcat('hist','_',num2str(force_number));
        % 作图
        figure(3);
        % 让直方图总在一个图上画，并覆盖上一次的图。
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
        %让直方图画在一个3D图中，不覆盖之前的图像。
        plot3(ext,force_clamp,P);
        hold on
%         save(new_data_name,'data_z');                                                %同时保存修正的Z信息和小波滤波的Z信息
%         save(new_data_d_name,'data_d');                                            %存储并不等于写入，在载入上有着微妙的差别
        %           save(new_data_name_y,'data_y');
        % clear data_4_analysis;
%         % clear data_input;
%         deal_number=deal_number+1;
        force_number=force_number+1;
        mean_mag = mean_mag + stepsize;
        
    end
    save('force_extension.mat','force_curve');                                     %保存力值-长度信息
    figure(1);
    view(-23.1,66.8);
    h = gcf;
    saveas(h, 'ext_probability','fig');
%     %将得到的F-E曲线作图
%     force_line = force_curve(:,3);
%     extension_line = force_curve(:,2);
%     %消除未赋值而为零的点
%     force_line(force_line==0)=[];
%     extension_line(extension_line==0)=[];
%     %作图
%     figure;
%     plot(force_line,extension_line,'*');
%     title('force-extension');
%     ylabel('extension');
%     xlabel('force');
end


%[data, indexes,lijst,properties,initval]=Steps_Find(new_file_name);
%disp('请输入大概的台阶步数：');
%step_number_string=input('step_number=','s');
%step_number=str2double(step_number_string);
%dummy=Steps_Evaluate(data,indexes,lijst,properties,initval,step_number);






plot3(0,0,0);
hold on
histogram(data_z);











