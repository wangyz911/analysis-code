
% 自己写的一个基于窗口的改进版二分扫描台阶位置的函数
function [indexes,properties] =my_iterative_split(data,properties)
window1 = 50;
window2 = 60;
p = 1.2;
step_loc = zeros(length(data),1);
good_step_loc1 = Split_global(data,window1,p);
good_step_loc2 = Split_global(data,window2,p);
good_step_loc = intersect(good_step_loc1,good_step_loc2); %这是多次分段检查找到的好step,并入下面的step中，下面的数组大一些，便于后续添加step
step_loc(1:length(good_step_loc)) = good_step_loc; %good_step_loc已经包含了起点和终点

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

    disp('ranking the step...');  %下一步是计算所有台阶的拟合值fit，step值，驻留时间，权重，step的正负可以作为判断上下行的判据
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
   % 暂时没有找到第二个好的判据，先这样吧
%    rank2 = zeros(Nst+2,1);
   
   indexes = zeros(Nst+2,6); % 先按照愿来的格式弄，以后改成自己的，把不用的垃圾都丢了
   
   indexes(:,2) = good_step_loc;
   indexes(:,3) = step;
   indexes(:,4) = rank1;
   indexes(:,5) = dwell_time;
   properties.growth_range=+max(data)-min(data);
   properties.aantal=Nst;
end
   
   
    

















function good_step_loc=Split_global(rij,window,p)
%本函数采用基于窗口的最大差分卡方值的方式计算台阶，思路是计算一个窗口（需要足够小，只容纳一个step）中每一点的分段卡方和均值卡方的差值，
%选择差值达到一定倍数（比如p倍）的位置记录袭来，作为好的台阶位置，找到所有位置，记录左右步长，再来计算一个加权值。

good_step_loc = zeros(1,length(rij));
%and determines the best step-fit there
N = floor(length(rij)/window);

tel = 1; % 注意这里是1，找到的台阶从2开始填入，1保留给起点
for i=1:N
    Chisq_base = sum( (rij(i*window+1:min((i+1)*window,length(rij)))-mean(rij(i*window+1:min((i+1)*window,length(rij)))) ).^2)/(window-1); % 计算整个窗口的卡方值，作为基底
    if i<N
        Chisq=zeros(window-1,1);  % 初始化保存卡方结果的位置
    for j = 2:window-2
        left = rij(i*window+1:i*window+j);
        right = rij(i*window+j+1:min((i+1)*window,length(rij)));  % 碰到终点就停,以免超出索引
        mean_l = mean(left);
        mean_r = mean(right);
        Chisq(j) = (sum((left-mean_l).^2)+sum((right-mean_r).^2))/(window-1);
    end
    Chisq(1) = Chisq(2)+1;
    Chisq(window-1) = Chisq(window-2)+1;
    else
        mo = mod(length(rij),window);
        Chisq_base = sum( (rij(i*window+1:length(rij))-mean(rij(i*window+1:length(rij))) ).^2)/(mo-1);
        Chisq=zeros(mo-1,1);  % 初始化保存卡方结果的位置
    for j = 2:mo-2
        left = rij(i*window+1:i*window+j);
        right = rij(i*window+j+1:min((i+1)*window,length(rij)));  % 碰到终点就停,以免超出索引
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
if window>2 % 这个循环是必然切到2个点，不切到不停止，好像没有太大意义
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