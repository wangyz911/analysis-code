% 本脚本用于批量统计fig图文件中各个跳变的rupture force 和step size。
%% 预先设置好采样结果的存放矩阵
N = 100; % 设置统计结果的个数
reader_result = cell(N,1);
outer_circle = zeros(N,4);
inner_circle = zeros(N,4);
% 检查数据save的文件名是否被占用，如果被占用就更新一下最后一位数字，继续检查，直到通过检查为止。
data_save = 'force_and_step_record_';
k = 1;
data_save_name = strcat(data_save,num2str(k),'.mat');
while(exist(data_save_name,'file'))
    k = k+1;
    data_save_name = strcat(data_save,num2str(k),'.mat');
end
save(data_save_name,'reader_result','outer_circle','inner_circle');

    
%% 首先读取一张fig文件，可加入询问循环，以依次处理多张。
i =1;
keep = 1;
number = 10000;  % 没什么用的数，就是定义了避免出错用的
while(keep)
    disp("还要继续读取图像吗？ 是-1，否-0");
    keep = str2double(input('输入1读取图像','s'));
    if keep
        [file_name,filefolder]=uigetfile({'*.fig'},'Select your fig file');
        disp(file_name);
        name_save=strtok(file_name,'.');
        % 保存对应的文件名
        reader_result{i} = name_save;
        openfig(file_name);
        out_num = input("输入外圈step个数",'s');

            %读取外圈数据，没有的话输0
            if out_num =='1'
                [step_x1,step_y1]=ginput(1);
%                 step_x1=floor(step_x1);       后续不要整数处理，没有理由取整
                if step_x1<1
                    step_x1=1;
                end
                
                [step_x2,step_y2]=ginput(1);                                          %鼠标取点设置断点  ？
%                 step_x2=floor(step_x2);                                          %向下取整
                if step_x2>number
                    step_x2=number;
                end
                stepsize1 = step_y2-step_y1;
                force1 = (step_x1+step_x2)/2;
                outer_circle(i,1) = force1;
                outer_circle(i,2) = stepsize1;
                
            elseif out_num=='2'
                [step_x1,step_y1]=ginput(1);
%                 step_x1=floor(step_x1);
                if step_x1<1
                    step_x1=1;
                end
                
                [step_x2,step_y2]=ginput(1);                                          %鼠标取点设置断点  ？
%                 step_x2=floor(step_x2);                                          %向下取整
                if step_x2>number
                    step_x2=number;
                end
                [step2_x1,step2_y1]=ginput(1);
%                 step2_x1=floor(step2_x1);
                if step2_x1<1
                    step2_x1=1;
                end
                
                [step2_x2,step2_y2]=ginput(1);                                          %鼠标取点设置断点  ？
%                 step2_x2=floor(step2_x2);                                          %向下取整
                if step2_x2>number
                    step2_x2=number;
                end
                stepsize1 = step_y2-step_y1;
                force1 = (step_x1+step_x2)/2;
                stepsize2 = step2_y2-step2_y1;
                force2 = (step2_x1+step2_x2)/2;
                outer_circle(i,1) = force1;
                outer_circle(i,2) = stepsize1;
                outer_circle(i,3) = force2;
                outer_circle(i,4) = stepsize2;
            end
            % 现在调整图像位置，读取内圈数据
            inn_num = input("输入内圈step个数",'s');
            if inn_num=='1'
                [step_x1,step_y1]=ginput(1);
%                 step_x1=floor(step_x1);
                if step_x1<1
                    step_x1=1;
                end
                
                [step_x2,step_y2]=ginput(1);                                          %鼠标取点设置断点  ？
%                 step_x2=floor(step_x2);                                          %向下取整
                if step_x2>number
                    step_x2=number;
                end
                stepsize1 = step_y2-step_y1;
                force1 = (step_x1+step_x2)/2;
                inner_circle(i,1) = force1;
                inner_circle(i,2) = stepsize1;
                
            elseif inn_num=='2'
                [step_x1,step_y1]=ginput(1);
%                 step_x1=floor(step_x1);
                if step_x1<1
                    step_x1=1;
                end
                
                [step_x2,step_y2]=ginput(1);                                          %鼠标取点设置断点  ？
%                 step_x2=floor(step_x2);                                          %向下取整
                if step_x2>number
                    step_x2=number;
                end
                [step2_x1,step2_y1]=ginput(1);
%                 step2_x1=floor(step2_x1);
                if step2_x1<1
                    step2_x1=1;
                end
                
                [step2_x2,step2_y2]=ginput(1);                                          %鼠标取点设置断点  ？
%                 step2_x2=floor(step2_x2);                                          %向下取整
                if step2_x2>number
                    step2_x2=number;
                end
                stepsize1 = step_y2-step_y1;
                force1 = (step_x1+step_x2)/2;
                stepsize2 = step2_y2-step2_y1;
                force2 = (step2_x1+step2_x2)/2;
                inner_circle(i,1) = force1;
                inner_circle(i,2) = stepsize1;
                inner_circle(i,3) = force2;
                inner_circle(i,4) = stepsize2;
            end
            i = i+1;
            save(data_save_name,'reader_result','outer_circle','inner_circle');
            close;
    end
    
end
% 最终裁剪结果数组，并保存最终结果
num_check =cellfun('isempty',reader_result);
num = length(find(num_check==0));
reader_result_m = reader_result(1:num);
outer_circle_m = outer_circle(1:num,:);
inner_circle_m = inner_circle(1:num,:);
save(data_save_name,'reader_result_m','outer_circle_m','inner_circle_m');
 
