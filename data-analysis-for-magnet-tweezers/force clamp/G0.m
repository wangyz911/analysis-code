% 该脚本是已知在不同力下展开态和折叠态驻留时间的指数拟合结果，即特征时间t1, t2，求两种状态的势能差G0.
% 该函数系早期版本，功能已被整合到dwell_time_analysis.
% 使用前需要根据数据特性调整驻留时间统计函数滤除小步长的阈值。
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
disp('---------------一、读取参考小球XYZ的数据：-------------------------------')
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
disp('---------------二、读取磁铁z方向移动的数据：--------------------------')
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
plot(time(start_number:end_number),DNA_z_position_modi(start_number:end_number),'b');
hold on
plot(time(start_number:end_number),DNA_z_wavelet(start_number:end_number),'r');
xlabel('time(min)');ylabel('z_position_modi');
hold off
subplot(2,1,2);
plot(time(start_number:end_number),magnet_z_position(start_number:end_number));
xlabel('time(min)');ylabel('magnet');
%% landscape 分析
% 第一步 作图，划分出分析范围
disp('---------------需要做landscape统计吗？0-不需要；1-需要')
yes_or_no_string1=input('judge1=','s');
if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不画
    
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 第二步：划分范围，设定参数

    %请输入试验温度
    T = input('T = ','s');
    T = str2double(T);
    %设置步长
    stepsize = 0.01;
    %预设好作图和计算的各种参数
    Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, 换成了pN*nm之后数量级降到-2，结果为4.128pN*nm
    %初始化循环次数
    deal_number=1;
    
    %划分好分析的起点，终点，步长
    disp('---------------请点击landscape统计的起点和终点');
    yes_or_no_string2=input('judge1=','s');                                    %*
    if yes_or_no_string2=='1'                                                  %此处是必要的停顿，否则取点函数会锁定到刚画出的图上，我们只能在总图上取点
        [step_data_x,~] = ginput(2);
        %得到所选起点和终点的值（x值不重要）
        step_first_y=magnet_z_position(floor(step_data_x(1,1))+start_number);                           %截取后的图像新坐标从0开始，而要读取的数据沿用了老的序列号，需要加上start_number才能读取正确信号。
        step_end_y=magnet_z_position(floor(step_data_x(2,1))+start_number);
        %初始磁铁位置等于起点的y坐标
        mean_mag = step_first_y(1,1);
    end
    %反应速率的结果矩阵
    lnK=zeros(round((step_end_y-step_first_y)/stepsize),2); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    % 第三步，进行分析，并作图

%     %首先创建一个图像供landscape使用，免得覆盖其他图像
%     figure;
    while mean_mag < step_end_y                                                        %反复分段，直到分完
        %得到一个台阶的序号
        step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %最小误差，注意到马达有时候会有移位出错，0.01变成0.009
        step_mag = step_mag(step_mag >start_number&step_mag <end_number);
        %得到序号对应的data_z, data_y ,磁铁位置
        %计算力值
        force = force_zmag(mean_mag);                                  %用force zmag的关系间接得到force，因为短链的力算不准。
        data_z=DNA_z_position_modi(step_mag);                             %同时提取修正的Z信息和小波滤波的Z信息
        data_d=sigDEN(data_z);
        data_z_mean=mean(data_d);           %Z方向均值，即L
%% 前面都属于一个框架，功能是载入数据，减掉参考，然后按照zmag把z轴数据切成一个个平衡态片段，后面的代码将对片段data_z做处理。
% 第一步 得到各个态的驻留时间统计
[ down, up ] = dwell_time_count( data_z);
%提取出特征驻留时间
t_fold = down.mu;
t_unfold = up.mu;
%结构折叠的速率等于从展开到折叠的时间的倒数，也就是展开态平均寿命的倒数
k_fold = 1/t_unfold;
%结构展开的速率等于从折叠到展开的时间的倒数，也就是折叠态平均寿命的倒数
k_unfold = 1/t_fold;
%计算反应速率的对数，它和力值force成线性关系。
lnK(deal_number,1) = log(k_fold/k_unfold);       
lnK(deal_number,2) = force; 
lnK(deal_number,3) = t_fold;
lnK(deal_number,4) = t_unfold;

        %% 这里属于框架尾部，不要改动，否则循环会出错
        deal_number = deal_number + 1;
        mean_mag = mean_mag + stepsize;
    end
    %% 框架结束，后面是循环处理之后的进一步处理
        %lnK 和force的数据都收集完毕，进行拟合并找到0点，此处可以画个图
    fit_lnk_F1 = fit(lnK(:,2),lnK(:,1),'poly1');

    %提取出拟合系数，拟合公式为fit_lnk_F(x) = p1*x + p2
    p1 = fit_lnk_F1.p1;
    p2 = fit_lnk_F1.p2;
    F1 = lnK(:,2);
    fitline_lnk_F1 = p1.*F1 + p2;
    

    
    %$$$$$$$$$$$$$$$$$$$$$$$$ 2G4处理方法$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%     %lnK 和force的数据都收集完毕，进行拟合并找到0点，此处可以画个图
%    fit_lnk_F1 = fit(lnK(1:9,2),lnK(1:9,1),'poly1');
% 
%     %提取出拟合系数，拟合公式为fit_lnk_F(x) = p1*x + p2
%     p1 = fit_lnk_F1.p1;
%     p2 = fit_lnk_F1.p2;
%     F1 = lnK(1:9,2);
%     fitline_lnk_F1 = p1.*F1 + p2;
%     
%      %lnK 和force的数据都收集完毕，进行拟合并找到0点，此处可以画个图
%      fit_lnk_F2 = fit(lnK(10:end,2),lnK(10:end,1),'poly1');
% 
%     %提取出拟合系数，拟合公式为fit_lnk_F(x) = p1*x + p2
%     p12 = fit_lnk_F2.p1;
%     p22 = fit_lnk_F2.p2;
%     F2= lnK(10:end,2);
%     fitline_lnk_F2 = p12.*F2 + p22;
%     %作图
%     figure;
%     plot(F,lnK(:,1),'*');
%     hold on;
%     plot(F1,fitline_lnk_F1,F2, fitline_lnk_F2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    plot(F1,lnK(:,1),'*');
    hold on;
    plot(F1,fitline_lnk_F1);
    %拟合函数，求0点。
    LNK = @(F2)p1*F2+p2;
    F_0 = fzero(LNK,0);
    %计算G0,并将单位换算为kBT

    disp('请输入dx');
    dx = input('dx = ','s');
    dx = str2double(dx);
    disp('请输入G4结构nt数');
    nt = input('nt = ','s');
    nt = str2double(nt);
    
    G_0 = (F_0*dx - G_stretch(F_0, nt,T))/4.1;
save('G0_DATA.mat','FileName','FileName2','fit_lnk_F1','fitline_lnk_F1','F_0','G_0','lnK','T');
% ,'fit_lnk_F2','fitline_lnk_F2'

end



