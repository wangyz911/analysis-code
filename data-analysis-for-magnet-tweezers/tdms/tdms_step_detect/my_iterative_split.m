
% �Լ�д��һ�����ڴ��ڵĸĽ������ɨ��̨��λ�õĺ���
function [indexes,properties] =my_iterative_split(data,properties)
window1 = 50;
window2 = 60;
p = 1.2;
step_loc = zeros(length(data),1);
good_step_loc1 = Split_global(data,window1,p);
good_step_loc2 = Split_global(data,window2,p);
good_step_loc = intersect(good_step_loc1,good_step_loc2); %���Ƕ�ηֶμ���ҵ��ĺ�step,���������step�У�����������һЩ�����ں������step
step_loc(1:length(good_step_loc)) = good_step_loc; %good_step_loc�Ѿ������������յ�

nst_found = length(good_step_loc)-1;
start = 0;
get_new = 1;
while(get_new)
    out_nst_found = nst_found;
    for c = 1:out_nst_found
        stop = good_step_loc(c+1);
        new_step_loc = Split2_refine(data,start,stop,p);
        if new_step_loc
            nst_found = nst_found+1;
            step_loc(nst_found+1) = new_step_loc;
        end
        start = stop;
    end
    get_new = nst_found-out_nst_found;
    out_nst_found = nst_found;
    good_step_loc = sort(step_loc(1:nst_found+1));
    start = 0;
end

    disp('all steps found')

    disp('ranking the step...');  %��һ���Ǽ�������̨�׵����ֵfit��stepֵ��פ��ʱ�䣬Ȩ�أ�step������������Ϊ�ж������е��о�
    Nst = length(good_step_loc)-2;
    Fit = zeros(Nst+1,1);
    for j = 1:Nst+1
        
        Fit(j)=mean(data(good_step_loc(j):good_step_loc(j+1)));
    end
   step = zeros(Nst+2,1);
   step(1) = 0;
   step(end) = 0;
   step(2:end-1) = diff(Fit);
   dwell_time = zeros(Nst+2,1);
   dwell_time(1:end-1) = diff(good_step_loc);
   dwell_time(end) = 0;
   rank1 = zeros(Nst+2,1);

   rank1(2:end-1) = step(2:end-1);
   rank1(1) = max(abs(step))+1;
   rank1(end) = max(abs(step))+1;
   % ��ʱû���ҵ��ڶ����õ��оݣ���������
%    rank2 = zeros(Nst+2,1);
   
   indexes = zeros(Nst+2,6); % �Ȱ���Ը���ĸ�ʽŪ���Ժ�ĳ��Լ��ģ��Ѳ��õ�����������
   
   indexes(:,2) = good_step_loc;
   indexes(:,3) = step;
   indexes(:,4) = rank1;
   indexes(:,5) = dwell_time;
   properties.growth_range=+max(data)-min(data);
   properties.aantal=Nst;
end
   
   
    

















function good_step_loc=Split_global(rij,window,p)
%���������û��ڴ��ڵ�����ֿ���ֵ�ķ�ʽ����̨�ף�˼·�Ǽ���һ�����ڣ���Ҫ�㹻С��ֻ����һ��step����ÿһ��ķֶο����;�ֵ�����Ĳ�ֵ��
%ѡ���ֵ�ﵽһ������������p������λ�ü�¼Ϯ������Ϊ�õ�̨��λ�ã��ҵ�����λ�ã���¼���Ҳ�������������һ����Ȩֵ��

good_step_loc = zeros(1,length(rij));
%and determines the best step-fit there
N = floor(length(rij)/window);

tel = 1; % ע��������1���ҵ���̨�״�2��ʼ���룬1���������
for i=1:N
    Chisq_base = sum( (rij(i*window+1:min((i+1)*window,length(rij)))-mean(rij(i*window+1:min((i+1)*window,length(rij)))) ).^2)/(window-1); % �����������ڵĿ���ֵ����Ϊ����
    if i<N
        Chisq=zeros(window-1,1);  % ��ʼ�����濨�������λ��
    for j = 2:window-2
        left = rij(i*window+1:i*window+j);
        right = rij(i*window+j+1:min((i+1)*window,length(rij)));  % �����յ��ͣ,���ⳬ������
        mean_l = mean(left);
        mean_r = mean(right);
        Chisq(j) = (sum((left-mean_l).^2)+sum((right-mean_r).^2))/(window-1);
    end
    Chisq(1) = Chisq(2)+1;
    Chisq(window-1) = Chisq(window-2)+1;
    else
        mo = mod(length(rij),window);
        Chisq_base = sum( (rij(i*window+1:length(rij))-mean(rij(i*window+1:length(rij))) ).^2)/(mo-1);
        Chisq=zeros(mo-1,1);  % ��ʼ�����濨�������λ��
    for j = 2:mo-2
        left = rij(i*window+1:i*window+j);
        right = rij(i*window+j+1:min((i+1)*window,length(rij)));  % �����յ��ͣ,���ⳬ������
        mean_l = mean(left);
        mean_r = mean(right);
        Chisq(j) = (sum((left-mean_l).^2)+sum((right-mean_r).^2))/(mo-1);
    end
        Chisq(1) = Chisq(2)+1;
    Chisq(mo-1) = Chisq(mo-2)+1;
    end

    refine_Chisq = Chisq_base./Chisq;
    [v,l]=max(refine_Chisq);
    if v>p
        tel = tel+1;
    good_step_loc(tel) = l+i*window;
    end
end
good_step_loc(1) = 1;
good_step_loc(tel+1) = length(rij);
good_step_loc = good_step_loc(1:tel+1);
end

function new_step_loc=Split2_refine(rij,i1,i2,p)
%this function adresses a two-dim array 'rij'in a specific segment
%and determines the best step-fit there
window=i2-i1;
if window>2 % ���ѭ���Ǳ�Ȼ�е�2���㣬���е���ֹͣ������û��̫������
    Chisq=(1:window-1)*0;
    for t=2:window-2
        left=rij(i1+1:i1+t);
        right=rij(i1+t+1:i2);
%         left_t=rij(i1+1:i1+t,1);
%         right_t=rij(i1+t+1:i2,1);
        dcleft=mean(left);
        dcright=mean(right);
        Chisq(t)=(sum((left-dcleft).^2)+sum((right-dcright).^2))/(window-1);
    end
    Chisq(1)=Chisq(2)+1;
    Chisq(window-1)=Chisq(window-2)+1;
    Chisq_base = sum((rij(i1+1:i2)-mean(rij(i1+1:i2))).^2)/(window-1);
    refine_Chisq = Chisq_base./Chisq;
    [v,l]=max(refine_Chisq);
    if v>p
    new_step_loc = i1+l;
    else
        new_step_loc = [];
    end
else
    new_step_loc = [];
end
end