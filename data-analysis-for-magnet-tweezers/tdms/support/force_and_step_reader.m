% ���ű���������ͳ��figͼ�ļ��и��������rupture force ��step size��
%% Ԥ�����úò�������Ĵ�ž���
N = 100; % ����ͳ�ƽ���ĸ���
reader_result = cell(N,1);
outer_circle = zeros(N,4);
inner_circle = zeros(N,4);
% �������save���ļ����Ƿ�ռ�ã������ռ�þ͸���һ�����һλ���֣�������飬ֱ��ͨ�����Ϊֹ��
data_save = 'force_and_step_record_';
k = 1;
data_save_name = strcat(data_save,num2str(k),'.mat');
while(exist(data_save_name,'file'))
    k = k+1;
    data_save_name = strcat(data_save,num2str(k),'.mat');
end
save(data_save_name,'reader_result','outer_circle','inner_circle');

    
%% ���ȶ�ȡһ��fig�ļ����ɼ���ѯ��ѭ���������δ�����š�
i =1;
keep = 1;
number = 10000;  % ûʲô�õ��������Ƕ����˱�������õ�
while(keep)
    disp("��Ҫ������ȡͼ���� ��-1����-0");
    keep = str2double(input('����1��ȡͼ��','s'));
    if keep
        [file_name,filefolder]=uigetfile({'*.fig'},'Select your fig file');
        disp(file_name);
        name_save=strtok(file_name,'.');
        % �����Ӧ���ļ���
        reader_result{i} = name_save;
        openfig(file_name);
        out_num = input("������Ȧstep����",'s');

            %��ȡ��Ȧ���ݣ�û�еĻ���0
            if out_num =='1'
                [step_x1,step_y1]=ginput(1);
%                 step_x1=floor(step_x1);       ������Ҫ��������û������ȡ��
                if step_x1<1
                    step_x1=1;
                end
                
                [step_x2,step_y2]=ginput(1);                                          %���ȡ�����öϵ�  ��
%                 step_x2=floor(step_x2);                                          %����ȡ��
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
                
                [step_x2,step_y2]=ginput(1);                                          %���ȡ�����öϵ�  ��
%                 step_x2=floor(step_x2);                                          %����ȡ��
                if step_x2>number
                    step_x2=number;
                end
                [step2_x1,step2_y1]=ginput(1);
%                 step2_x1=floor(step2_x1);
                if step2_x1<1
                    step2_x1=1;
                end
                
                [step2_x2,step2_y2]=ginput(1);                                          %���ȡ�����öϵ�  ��
%                 step2_x2=floor(step2_x2);                                          %����ȡ��
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
            % ���ڵ���ͼ��λ�ã���ȡ��Ȧ����
            inn_num = input("������Ȧstep����",'s');
            if inn_num=='1'
                [step_x1,step_y1]=ginput(1);
%                 step_x1=floor(step_x1);
                if step_x1<1
                    step_x1=1;
                end
                
                [step_x2,step_y2]=ginput(1);                                          %���ȡ�����öϵ�  ��
%                 step_x2=floor(step_x2);                                          %����ȡ��
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
                
                [step_x2,step_y2]=ginput(1);                                          %���ȡ�����öϵ�  ��
%                 step_x2=floor(step_x2);                                          %����ȡ��
                if step_x2>number
                    step_x2=number;
                end
                [step2_x1,step2_y1]=ginput(1);
%                 step2_x1=floor(step2_x1);
                if step2_x1<1
                    step2_x1=1;
                end
                
                [step2_x2,step2_y2]=ginput(1);                                          %���ȡ�����öϵ�  ��
%                 step2_x2=floor(step2_x2);                                          %����ȡ��
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
% ���ղü�������飬���������ս��
num_check =cellfun('isempty',reader_result);
num = length(find(num_check==0));
reader_result_m = reader_result(1:num);
outer_circle_m = outer_circle(1:num,:);
inner_circle_m = inner_circle(1:num,:);
save(data_save_name,'reader_result_m','outer_circle_m','inner_circle_m');
 
