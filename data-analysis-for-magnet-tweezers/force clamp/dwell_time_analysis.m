%执行驻留时间统计的脚本，顺便算出与驻留时间相关的参数。

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
fgetl(fid);                                      
%去掉字符头，开始读取数据
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
%% 步长统计分析

disp('---------------需要做步长&驻留时间统计吗？0-不需要；1-需要')
yes_or_no_string1=input('judge1=','s');                                    %*
if yes_or_no_string1=='1'                                                  %计算了就画图，没计算就不画
    new_file_name=strcat(PathName,name_save,'dwelltime2','_',date,'\');
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
 
    deal_number=1;
    DNA_y_position_modi=DNA_y_position-ref_DNA_y_position;                     %跳过算力情况下补充定义y
    DNA_x_position_modi=DNA_x_position-ref_DNA_x_position;                     %定义x
    
%请输入试验温度
    T = input('T = ','s');
    T = str2double(T);
    
%划分好分析的起点，终点，步长
            disp('---------------请点击驻留时间分析的起点和终点');
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
    s = input('请输入步长','s');
    stepsize = str2double(s);

     %预设置保存分析结果的矩阵，大小由分析区间和台阶大小决定
    dwell_time_curve=zeros(ceil((step_end_y-step_first_y)/stepsize),7);            %力值曲线，分别用来保存zmag，力值，k_unfold,k_fold。       
    time_number=1;                                                                  %总序号，力值曲线需要用
    DNA_length=1.034;                                                           %定义L，轮廓长度，单位是微米
    Kb_multi_T=1.3806504e-2*(T+273.15);                                     %k_B*T, 换成了pN*nm之后数量级降到-2，结果为4.128pN*nm
    
    %% 此处 mean_mag == step_end_y的部分未被分析,加上一个小量使得最后一段可以被分析   
    %建立保存结果的txt文档

fileID = fopen('step_and_std.txt','a');
fileID2 = fopen('time_domination.txt','a');
fprintf(fileID,'%8s %12s\n','step','step_std');
fprintf(fileID2,'%6s %12s %12s\n','fold','mid','unfold');
non = [];

    while mean_mag < (step_end_y+0.001)                                                        %反复分段，直到分完
            %得到一个台阶的序号
            step_mag = find(abs(magnet_z_position-mean_mag)<2E-3);         %最小误差，注意到马达有时候会有移位出错，0.01变成0.009
            %得到序号对应的data_z, data_y ,磁铁位置
            step_mag = step_mag(step_mag >start_number&step_mag <end_number);

            data_z=DNA_z_position_modi(step_mag);                             %同时提取修正的Z信息和小波滤波的Z信息
            data_y=DNA_y_position_modi(step_mag);
            % 对data_z进行step-detect 工作，结果用于后面的分析。
            step_position = J_search(data_z,0.7);
            length_check = 5;
            step_check = 0.002;%滤除比较小的杂音step
            % 对 data_z进行步长分析，提取出拟合参数
            [ data_d,step,step_std,~,good1] = step_modulation( data_z,step_position,step_check,length_check);
            if good1==1

            % 生成图像后马上保存图像
            
            step_fig_name = strcat('step',num2str(time_number),'.fig');
            h = gcf;
            saveas(h, step_fig_name,'fig');
            fprintf(fileID,'%6.8f \t',step);
            fprintf(fileID,'%6.8f \t',step_std);
            fprintf(fileID,'%f\r\n',non);
            % 对 data_z进行驻留时间分析，提取出拟合参数

            [k_unfold,k_mid,k_fold,good,time_domination] = dwell_time_count(data_z,step_position,step_check,length_check);
            time_fig_name = strcat('dwelltime',num2str(time_number),'.fig');
            h = gcf;
            saveas(h, time_fig_name,'fig');
            % 如果down不是0，说明没有跳过这一段分析，则执行后续，如果是0,则跳入下一循环。
            % 得到拟合结果后，导出拟合结果，并计算k_fold and k_unfold
            if good ==1

            
            fprintf(fileID2,'%6.8f %12.8f %12.8f\r\n',time_domination);
            %计算力值
            data_z_mean=mean(data_d);           %Z方向均值，即L
%         deviation_y=var(data_y);
%         %y方向标准差^2=方差,改成了方差函数,已整合到force_estimate中
%         force=force_estimate(data_y,data_cal_mean); 
%         force=Kb_multi_T*data_z_mean*1.0e-3/var_correction(data_y,T);    %力值计算，其中对方差进行了积分时间修正
                                                                           %除以1000，单位换算，最后单位是纳米，F单位是pN,为什么+1.4(1.4是2.8微米的球的半径，加上之后才是摆长)
% 储存计算结果
            force = force_zmag_che(mean_mag,0.015);                                  %用force zmag的关系间接得到force，因为短链的力算不准。
            dwell_time_curve(time_number,1)=time_number;                      %time_curve第1列标明序号
            dwell_time_curve(time_number,2)=data_z_mean;                       %time_curve 第2列输入Z值，也就是extension
            dwell_time_curve(time_number,3)=force;                             %第3列输入计算出的力值，即force
            dwell_time_curve(time_number,4)=mean_mag;                          %第4列输入Zmag
            dwell_time_curve(time_number,5)=k_unfold;
            dwell_time_curve(time_number,6)=k_fold;
            dwell_time_curve(time_number,7)=k_mid;
%保存原始数据
            new_data_name=strcat('data_',num2str(deal_number),'.mat');
            new_data_name_y=strcat('data_y',num2str(deal_number),'.mat');
            new_data_d_name=strcat('data_d','_',num2str(deal_number),'.mat');

            save(new_data_name,'data_z');                                                %同时保存修正的Z信息和小波滤波的Z信息
            save(new_data_d_name,'data_d');                                            %存储并不等于写入，在载入上有着微妙的差别
            save(new_data_name_y,'data_y');
            % clear data_4_analysis;
            % clear data_input;
            end
            end
% 进入下一循环，技术+1，步长加一级            
            deal_number=deal_number+1;
            time_number=time_number+1;
            mean_mag = mean_mag + stepsize;


    end
    fclose(fileID);
    save('dwell_time_data.mat','dwell_time_curve','time_domination');     

    % 循环完成，关闭文件。
                                %保存力值-长度信息
   %% %以下部分专门分析二态过程，可以写成一个函数，输入函数是dwell_time_curve;

   disp('how many states are the system ? ');
   states =str2double(input('states = ? ','s'));
   if states==2
       T = 31;
       [ dx_f,dG0_f,dx_u,dG0_u,k0_u,k0_f,G0,G0_u_minus_f,G0_uf,nt,Feq,keq,teq] = FC_calculate_2( dwell_time_curve,T );
       % 重要参量的误差计算
       
   elseif states ==3
       [ dx_f,dG0_f,dx_u,dG0_u,k0_u,k0_f,G0,G0_u_minus_f,G0_uf,~] = FC_calculate_3( dwell_time_curve,T );
       
   else
       
   end
   
% force_line = dwell_time_curve(:,3);
% k_unfold_line = dwell_time_curve(:,5);
% k_fold_line = dwell_time_curve(:,6);
% %消除未赋值而为零的点
% force_line(force_line==0)=[];
% k_unfold_line(k_unfold_line==0)=[];
% k_fold_line(k_fold_line==0)=[];
% k_u_log = log(k_unfold_line);
% k_f_log = log(k_fold_line);
% % 对反应速率做线性拟合得到dx 和 dG（还需修正成为自然情况下dGO）.
% [fit_fold,s_f] = polyfit(force_line,k_f_log,1);
% [fit_unfold,s_u]= polyfit(force_line,k_u_log,1);
% Kb_T = 1.3806504e-2*(T+273.15); 
% % 最终分析结果
% dx_f = fit_fold(1)*Kb_T;
% dG0_f = -fit_fold(2);
% k0_f = exp(-dG0_f);
% dx_u = fit_unfold(1)*Kb_T;
% dG0_u = -fit_unfold(2);
% k0_u = exp(-dG0_u);
% % 自由能还需要减去单链的拉伸自由能和G4拉伸自由能等等，统称G_stretch
% lnK = k_u_log./k_f_log;
% dx_uf = dx_u-dx_f;
% [G0,G0_uf] = G0_modi(lnK,force_line,T,dx_uf);
% %另一种方法计算出的G0
% G0_u_minus_f = dG0_u - dG0_f;
% 
% 
% save('dwell_time_results.mat','dx_f','dG0_f','dx_u','dG0_u','k0_u','k0_f','G0','G0_u_minus_f','G0_uf','s_u','s_f');
% %作图
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

