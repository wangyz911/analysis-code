
% 本脚本用于处理平衡态轨迹，可以计算驻留时间分布以及
close all;

clear;
%% 读取库函数和头文件
%Check if the paths to 'nilibddc.dll' and 'nilibddc_m.h' have been
%selected. If not, prompt the user to browse to each of the files.
 NI_TDM_DLL_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\bin\64-bit\nilibddc.dll';
if exist('NI_TDM_DLL_Path','var')==0
    [dllfile,dllfolder]=uigetfile('*dll','Select nilibddc.dll');
    %提取库名称
%     libname=strtok(dllfile,'.');
    NI_TDM_DLL_Path=fullfile(dllfolder,dllfile);
end
libname='nilibddc';
 NI_TDM_H_Path = 'E:\analysis code\data-analysis-for-magnet-tweezers\tdms\include\64-bit\nilibddc_m.h';
if exist('NI_TDM_H_Path','var')==0
    [hfile,hfolder]=uigetfile('*h','Select nilibddc_m.h');
    NI_TDM_H_Path=fullfile(hfolder,hfile);
end
%% 打开指定TDMS 文件
%Prompt the user to browse to the path of the TDM or TDMS file to read
[file_name,filefolder]=uigetfile({'*.tdms';'*.tdm'},'Select your data file');
Data_Path=fullfile(filefolder,file_name);
% 打开 bead trajectories 文件(自带磁铁文件)
[ DNA_x_modi,DNA_y_modi,DNA_z_position_modi,magnet_z_position] = read_from_tdms(libname,NI_TDM_DLL_Path,NI_TDM_H_Path,Data_Path);
name_save=strtok(file_name,'.');
% % 找到弛豫的区间，方便标记
% relax_pos = find(magnet_z_position == -1.998);

%% data show

% shift 值，只有在修图时才用
DNA_z_shift =0;
DNA_z_position_modi = DNA_z_position_modi + DNA_z_shift;
% DNA_z_position_modi = DNA_z_position_no_shift + DNA_z_shift;
DNA_z_wavelet=sigDEN5(DNA_z_position_modi);
DNA_z_wavelet = DNA_z_wavelet';

number=size(DNA_z_position_modi,1);
time=(1:number)./3600;                                                   %时间单位由帧转换到分钟

plot(DNA_z_position_modi);
% 在弛豫的位置做个标记，方便选择区间
% hold on
% relax_marker = zeros(size(relax_pos,1),1);
% plot(relax_pos,relax_marker,'r','LineStyle','none','Marker','o');
% hold off

%% 选择数据区间
disp('请选择合适的区间')

if input('输入1选择区间','s')=='1'

[start_number,~]=ginput(1);
start_number=floor(start_number);
if start_number<1
    start_number=1;
end

[end_number,~]=ginput(1);                                          %鼠标取点设置断点  ？
end_number=floor(end_number);                                          %向下取整
if end_number>number
    end_number=number;
end

% name_save=FileName(13:name_length-3);
% 下面这个函数直接截取文件名的主要部分，去除后缀名，比减字符个数更加灵活。


%% 在这里修改后缀，省的保存数据后一个个改
    ramp_th = '_1';
    name_save = strcat(name_save,ramp_th);
%% 步长统计分析

disp('---------------需要做步长统计吗？0-不需要；1-需要')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不画
    new_file_name=strcat(Data_Path,name_save,'chi_hist','_','\');
    mkdir(new_file_name);                                                      %新建文件夹
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
    fig=3;                                                                     %设定图像标号和子图标号
    subfig=1;
    force_number=1;                                                                  %总序号，力值曲线需要用
    DNA_length=1.034;                                                           %定义L，轮廓长度，单位是微米
    Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, 换成了pN*nm之后数量级降到-2，结果为4.128pN*nm
    %%% 此处 mean_mag == step_end_y的部分未被分析,加上一个小量使得最后一段可以被分析
    while mean_mag < (step_end_y+0.001)                                                        %反复分段，直到分完
            %得到一个台阶的序号
            step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %最小误差，注意到马达有时候会有移位出错，0.01变成0.009
            %得到序号对应的data_z, data_y ,磁铁位置
            step_mag = step_mag(step_mag >start_number&step_mag <end_number);

            data_z=DNA_z_position_modi(step_mag);                             %同时提取修正的Z信息和小波滤波的Z信息
            [data_d,step_info]=find_step(data_z);                                                       %指令化的3级小波滤波，须在建立文件夹后第一时间将sigDEN函数文件拷到该文件夹。,五级滤掉太多了，统计图很难看。
            data_y=DNA_y_position_modi(step_mag)';                           %得到y方向的波动数据，这一数据不能滤波

            
            %计算力值
            data_z_mean=mean(data_d);           %Z方向均值，即L

            %         deviation_y=var(data_y);
            %         %y方向标准差^2=方差,改成了方差函数,已整合到force_estimate中
            %             force=force_estimate(data_y,data_cal_mean); 
%             force=Kb_multi_T*data_z_mean*1.0e-3/var_correction(data_y,T);    %力值计算，其中对方差进行了积分时间修正
            %除以1000，单位换算，最后单位是纳米，F单位是pN,为什么+1.4(1.4是2.8微米的球的半径，加上之后才是摆长)
            force = force_zmag_che(mean_mag);                                  %用force zmag的关系间接得到force，因为短链的力算不准。
            force_curve(force_number,1)=force_number;                      %force_curve第1列标明序号
            force_curve(force_number,2)=data_z_mean;                       %force_curve 第2列输入Z值，也就是extension
            force_curve(force_number,3)=force;                             %第3列输入计算出的力值，即force
            force_curve(force_number,4)=mean_mag;                          %第4列输入Zmag
            
            % data_input(:,2)=data_4_analysis;                                           %输入数据（是一种很有参考价值的写法）第一列为序号，第二列为数据
            % data_input(:,1)=(1:size(data_4_analysis,1))';
            title_name=strcat('F=',num2str(force),'length=',num2str(data_z_mean),'Z=',num2str(mean_mag),'NO_',num2str(deal_number));  %增加序号和磁镊位置，方便对应查找。
            new_data_name=strcat('data_',num2str(deal_number),'.mat');
            new_data_name_y=strcat('data_y',num2str(deal_number),'.mat');
            new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');
            cd(new_file_name);                                                         %改变当前路径至
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
            
            save(new_data_name,'data_z');                                                %同时保存修正的Z信息和小波滤波的Z信息
            save(new_data_d_name,'data_d');                                            %存储并不等于写入，在载入上有着微妙的差别
%             save(new_data_name_y,'data_y');
            % clear data_4_analysis;
            % clear data_input;
            deal_number=deal_number+1;
            force_number=force_number+1;
            mean_mag = mean_mag + stepsize;


    end
    save('force_extension.mat','force_curve');                                     %保存力值-长度信息
%将得到的F-E曲线作图
force_line = force_curve(:,3);
extension_line = force_curve(:,2);
%消除未赋值而为零的点
force_line(force_line==0)=[];
extension_line(extension_line==0)=[];
%作图
    figure;
    plot(force_line,extension_line,'*');
    title('force-extension');
    ylabel('extension');
    xlabel('force');
end
end

%[data, indexes,lijst,properties,initval]=Steps_Find(new_file_name);
%disp('请输入大概的台阶步数：');
%step_number_string=input('step_number=','s');
%step_number=str2double(step_number_string);
%dummy=Steps_Evaluate(data,indexes,lijst,properties,initval,step_number);


