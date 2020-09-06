function [data_for_detect, indexes,lijst,properties,initval] = tdms_steps_find(data_for_detect,cutoff_Nst)
% 本函数用于查找选中的数据区间的所有step 位置，并按照权重进行打分
%Settings
%------------------------------------------

initval.showfits=0;          %shows the fitting,
initval.makemovie=0 ;       %Make a movie of the fits (also switch 'showfits on')
initval.ra=500;                %for noise determination: max distance between data points
initval.condense=0;             %condenses original data with this factor by skipping points
initval.cutoff=cutoff_Nst;             %max aantal steps fitted {to gain time} 截止拟合步数，最大拟合200步，以节省时间，根据实际情况修改
initval.deelfactor=1;           %pre-divisions ; per segment! 预切割，分别拟合再接上，可以节省时间
initval.treshold = 3;           %number_of sigmas that a spike is allowed to rise
initval.standardinput=0;
initval.inpath='E:\analysis code\data-analysis-for-magnet-tweezers\Chi_square\SendPackStepfinder070626';
initval.outpath='E:\analysis code\data-analysis-for-magnet-tweezers\Chi_square\SendPackStepfinder070626';

% 读取输入的data文件，data 应包含两列，一列是时间轴，一列是磁球位置
% 可以选择下采样来提升台阶识别速度，应该不为0就可以下采样，而且不同的数可以调整下采样的密度
if initval.condense~=0
    data_for_detect=Skip_Points(data_for_detect,initval);
end
%Optional: Condense data to gain time
% 为了先保持一致，自己设定一下lijst
N = size(data_for_detect,1);
lijst = [0,N];

[noises, properties,data_for_detect]=Remove_Outliers_Get_Noise(data_for_detect,initval,lijst);
%This function removes outlying spikes and determines after that the Gaussian
%background noise via a nearest-neighbour analysis. To check for
%low-pass filtering, the analysis is also repeated as a function of
%datapoint-distance. The result is plotted to allow the user to
%click a most likely true noise level. If wished, the data is also condensed here by
%skipping points.

% [indexes,properties]=Iterative_Splitting(data_for_detect,lijst,properties, initval);

[indexes,properties] =My_Iterative_Splitting(data_for_detect(:,2),properties);
%Split Section. Output: a ranked list of potential step locations, ...
%ordered by their expected or their measured error. A specific fit ...
%to the whole dataset now just consists of the picking of these locations
%up to a certain number. This is user-tuned in Steps_Evaluate'

%'indexes' contains columns:
%-----------------------------------
%iteration round: the split round where this location was found
%index: the location of the step, expressed as data point number
%(last point of the left plateau)
%stepsize: the fitted size of the step
%step*srqt(N)/noise: A measure for the prominence of the step, equal to the inverted expected error.
%step*sqrt(N/Var):   The same value, but based on measured residual variance.
%...Also ranks how 'ideal' steps are but is more prone to statistical variation.
%minimum Chi: The minimum residual RMS Chi-square after the split.
%Should for an ideal step approach the noise
%----------------------------------------------------------------

%      Write_files(indexes,noises,initval);
%         %Storage of data
        
end

function data=Skip_Points(data,initval)
%If wished, the data is condensed here by
%skipping points.
N0=length(data);
resampled_data=zeros(2,NO);
tel=0;
for j=1:N0
    if mod(j,initval.condense) ==0
        tel=tel+1;
        resampled_data(:,tel)=data(j,:)';
    end
end
resampled_data = resampled_data(:,1:tel-1); % 减去后面没填的空白部分
data=resampled_data';
end

function [far_neighbour, properties, data]=Remove_Outliers_Get_Noise(data,initval,lijst)
%Section: properties.noise_Spike_Finder:
%This program determines noise, then spots the outliers, rmoves them and
%recalculates the noise.
N0=length(data);
properties.aantal=0;
properties.growth_range=0; %this parameter collects the total growth or shrinkage of all segments
properties.N0=length(data);
hold off;

%1) Determine noise including outliers
le=length(data);
neighbour_dif=zeros(1,le);
n=0;
for i=1:le-1
    if sum(find(lijst==i-1))==0 && sum(find(lijst==i))==0 && sum(find(lijst==i+1))==0
        n=n+1;
        neighbour_dif(1,n)=(data(i+1,2)-data(i,2))^2;
    end
end
properties.noise=(mean(neighbour_dif))^0.5/2^0.5 ;

%2) Discard spikes
spikes=0;
for i=2:le-1
    if sum(find(lijst==i-1))==0 && sum(find(lijst==i))==0 && sum(find(lijst==i+1))==0  %do not consider border points or next to those
        if data(i,2)-data(i-1,2)>initval.treshold*properties.noise && data(i,2)-data(i+1,2)>initval.treshold*properties.noise
            data(i,2)=(data(i-1,2)+data(i+1,2))/2; %positive spike
            spikes=spikes+1;
        end
        if data(i,2)-data(i-1,2)<-initval.treshold*properties.noise && data(i,2)-data(i+1,2)<-initval.treshold*properties.noise
            data(i,2)=(data(i-1,2)+data(i+1,2))/2;
            spikes=spikes+1;
        end %negative spike
    end
end

%3) Re-measure noise; also as function of further neighbours (up to
%30 points away
lel=length(lijst);
far_neighbour=zeros(3,initval.ra);
k=0;
for delta_i=1:initval.ra
    neighbour_dif=zeros(1,le);
    n=0;
    for j=1:lel-1                   %for each segment separate
        for i=lijst(j)+1:lijst(j+1)-delta_i  %Pick_a_Segment;
            n=n+1 ;
            neighbour_dif(:,n)=data(i+delta_i,2)-data(i,2);
        end
    end
    properties.noise=(std(neighbour_dif))/2^0.5;
    k=k+1;
    far_neighbour(:,k)=[k,properties.noise,0]';
end
far_neighbour=far_neighbour';
% subplot(1,2,1);
figure;

title('Noise vs. Neighbour_distance','FontSize',12)
plot(far_neighbour(:,1),far_neighbour(:,2));
% axis([0 initval.ra  0 ceil(max(far_neighbour(:,2)))]);
disp('Left mouse button picks points.') % 这里噪音到底是在选什么
[~,n] = ginput(1);
properties.noise=n;
far_neighbour(:,3)=properties.noise;
end

function [indexes,properties]=Iterative_Splitting(data,lijst,properties, initval)

%Split Section. Output: a ranked list of potential step locations, ...
%ordered by their expected or their measured error. A specific fit ...
%to the whole dataset now just consists of the picking of these locations
%up to a certain number. This is user-tuned in Steps_Evaluate'

%'indexes' contains columns:
%-----------------------------------
%iteration round: the split round where this location was found
%index: the location of the step, expressed as data point number
%(last point of the left plateau)
%stepsize: the fitted size of the step
%step*srqt(N)/noise: A measure for the prominence of the step, equal to the inverted expected error.
%step*sqrt(N/Var):   The same value, but based on measured residual variance.
%...Also ranks how 'ideal' steps are but is more prone to statistical variation.
%minimum Chi: The minimum residual RMS Chi-square after the split.
%Should for an ideal step approach the noise
%----------------------------------------------------------------


lijst_teller=1;
indexes=[0,0,0,0,0,0];
while lijst_teller<length(lijst)
    %1) Set some counters
    round=0;  % 第几轮
    start=0;  % 起点
    segment_aantal=0; % 一段有多少台阶
    found_last_round=initval.deelfactor-1; % 这是一个不稳定的分段提速功能，最好不要用，令deelfactor=1即可。
    
    %2) Pick a data segment (if the data consists of different data
    %sets glued together
    segment_data=data(lijst(lijst_teller)+1:lijst(lijst_teller+1),:);
    N1=length(segment_data);
    segment_indexes=zeros(N1,6);
    properties.growth_range=properties.growth_range+max(segment_data(:,2))-min(segment_data(:,2)); % 统计数据的取值范围
    
    %3) Make_Pre_locations;
    %this first pre-split serves only to speed up the fits for very large
    %datasets; If iterations are done on segments with too many
    %steps, the initial splits might not locate true steps
    %(rememmber that the locations are not changed anymore after being found
    %------------------------------------------------------
    tres0=(max(segment_data(:,2))-min(segment_data(:,2)))*sqrt(N1);
    if initval.deelfactor > 1
        segment_indexes([1:initval.deelfactor+1]',2)=ceil([0,[1:initval.deelfactor]*N1/initval.deelfactor]');
    else
        segment_indexes(1:2,2)=[0,N1]';         % 起点和终点的索引
        segment_indexes(1:2,4)=[tres0,tres0]';  % 令起点和终点的加权最重，便于后面评估
    end
    sorteer=sort(segment_indexes(1:initval.deelfactor+1,2));
    
    %4) Pre_Split; the used locations are not stored later on
    %-------------------------------------------------------
    %'indexes' contains columns:
%-----------------------------------
%iteration round: the split round where this location was found
%index: the location of the step, expressed as data point number
%(last point of the left plateau)
%stepsize: the fitted size of the step
%step*srqt(N)/noise: A measure for the prominence of the step, equal to the inverted expected error.
%step*sqrt(N/Var):   The same value, but based on measured residual variance.
%...Also ranks how 'ideal' steps are but is more prone to statistical variation.
%minimum Chi: The minimum residual RMS Chi-square after the split.
%Should for an ideal step approach the noise
    disp('splitting....')
    segment_indexes(1,:)=[0,0,0,tres0,tres0,tres0];
    segment_indexes(initval.deelfactor+2,:)=[0,N1,0,tres0,tres0,tres0];
    for c=1:initval.deelfactor % 这一段的任务是在每个分段中找第一个台阶
        stop=sorteer(c+1);
        %----------------------------------------------------------
        %this section adresses a two-dim array 'segment_data'in a specific segmentand determines the best step-fit there
        spl=Split2(segment_data,start,stop); %找台阶，用就是了
        
        if spl~=[0,0,0,0,0]
            segment_aantal=segment_aantal+1;  %如果找到台阶，台阶数+1，Index大小是台阶数+2
            segment_indexes(c+1,:)=[1,spl(2:5) ,spl(1)];
            %segment-indexes contains:
            %round, index, stepsize, step*srqt(N),%step*sqrt(N/Var), minimum Chi
        end
        start=stop;
    end %
    found_last_round=segment_aantal+2;       %includes begin and end 这是几问题不大， 只要不是0，所以这个等式也很迷
    start=0;   %resetting of a loop
    segment_aantal=segment_aantal+1;         %这里就很迷惑，跟segment_aantal 没啥逻辑联系，+1也毫无理由，就是凑到3
    sorteer=sort(segment_indexes(1:segment_aantal+1,2));
    
    %5) Iterative_Split; 正式开始迭代
    % Each new series of splitted steps is added to
    %the existing, earlier determined locations. The collection is regularly
    %sorted. The result is a ranked list of locations where steps can be
    %added;
    %------------------------------------------------------------------
    while found_last_round ~=0   %nested2 continue until no more steps can be fitted
        round=round+1;
        oudsegment_aantal=segment_aantal; %outsegment 表示本次循环结束的次数，注意，这里等于2，对应一个台阶，两段区间
        for c=1:oudsegment_aantal % nest3, run through the plateaus found in the former round
            stop=sorteer(c+1);  %终点从2开始，逐步往后推
            %----------------------------------------------------------
            %this section adresses a two-dim array 'segment_data'in a specific segment
            %and determines the best step-fit there
            spl=Split2(segment_data,start,stop);
            
            %spl=minimum Chi, index, stepsize,  step*srqt(N), step*sqrt(N/Var)
            if spl~=[0,0,0,0,0]    %add the results of the split to the collection
                segment_aantal=segment_aantal+1;
                segment_indexes(segment_aantal+1,:)=[round,spl(2:5),spl(1)]; %ronde, index, stepsize,  rank1, rank2, Chi, worstindex,worstChi
            end
            start=stop;
        end   % nest3......all plateaus were split, if possible
        found_last_round=segment_aantal-oudsegment_aantal; %如果输入的台阶数和输出一样，说明没找到新台阶，那么就不再循环了
        sorteer=sort(segment_indexes(1:segment_aantal+1,2)); %把新找出来的台阶排序，下个循环用
%         lijst_teller=lijst_teller;
        start=0;   %resetting of a loop; go back the beginning of the loop 重置起点，再按分段逐个找新台阶
    end
    disp('all steps found')
    disp('sorting.....')
    segment_indexes=sort_on_key(segment_indexes(1:segment_aantal+1,:),2); %cuts off initializing and unused parts and sorts on any column
    disp('ranking the step...');

    
        
    segment_indexes(:,2)=segment_indexes(:,2)+lijst(lijst_teller); %to change the relative index back to the absolute one
    indexes=[[indexes]',[segment_indexes(2:segment_aantal+1,:)]']' ;
    properties.aantal=properties.aantal+segment_aantal;
    lijst_teller=lijst_teller+1;
end

%6) some stupid cleaning up

indexes=indexes(2:properties.aantal+1,:);  %get the zero out of the system! 那前面为毛要加0？
indexes(:,4)=indexes(:,4)/properties.noise;
%convert column 4 (=step*sqrt(N)) to a relative error that can be compared with other datasets with different noise levels
indexes=(fliplr((sort_on_key(indexes,1))'))'; % 这里转置再转置什么意思？ 强行使用左右转置，直接用上下转置不就好了，另外为什么要按这么排？好像没有意义
end


function sorteer=sort_on_key(rij,key)
%this function reads a (index,props) array ands sorts along the index with one of the
%props as sort key
size=length(rij(:,1));
sorteer=0*rij;
buf=rij;
for i=1:size
    [g,h]=min(buf(:,key));
    sorteer(i,:)=buf(h,:);
    buf(h,key)=max(buf(:,key))+1;
end
end


function spl=Split2(rij,i1,i2)
%this function adresses a two-dim array 'rij'in a specific segment
%and determines the best step-fit there
window=i2-i1;
if window>2 % 这个循环是必然切到2个点，不切到不停止，好像没有太大意义
    Chisq=(1:window-1)*0;
    for t=2:window-2
        left=rij(i1+1:i1+t,2);
        right=rij(i1+t+1:i2,2);
        left_t=rij(i1+1:i1+t,1);
        right_t=rij(i1+t+1:i2,1);
        dcleft=mean(left);
        dcright=mean(right);
        Chisq(t)=(sum((left-dcleft).^2)+sum((right-dcright).^2))/(window-1);
    end
    Chisq(1)=Chisq(2)+1;
    Chisq(window-1)=Chisq(window-2)+1;
    [g,h]=min(Chisq);
    r=rij(i1+h+1:i2,2);
    l=rij(i1+1:i1+h,2);
    stp=mean(r)-mean(l);
    rank1=abs(stp)*sqrt(window);        %expected rel.step accuracy relative to background noise
%     rank2=abs(stp)*sqrt(window/g);       %measured rel. step accuracy
        rank2=abs(stp);       %measured rel. step accuracy
    spl=[sqrt(g),h+i1,stp,rank1, rank2];      %minimum Chi, index, stepsize,  step*srqt(N), step*sqrt(N/Var)
else
    spl=[0,0,0,0,0];
end
end


% 自己写的一个基于窗口的改进版二分扫描台阶位置的函数
function [indexes,properties] =My_Iterative_Splitting(data,properties)
% window1 = 50;
% window2 = 30;
% window3 = 20;
% window4 = 70;
% window5 = 110;
% p = 1.5;
% 
% good_step_loc1 = Split_global(data,window1,p);
% good_step_loc2 = Split_global(data,window2,p);
% good_step_loc3 = Split_global(data,window3,p);
% good_step_loc4 = Split_global(data,window4,p);
% good_step_loc5 = Split_global(data,window5,p);
% 
% % good_step_loc = union(good_step_loc1,good_step_loc2); %这是多次分段检查找到的好step,并入下面的step中，下面的数组大一些，便于后续添加step
% all_good = [good_step_loc1,good_step_loc2,good_step_loc3,good_step_loc4,good_step_loc5];
% good_step_loc = unique(all_good);


% good_step_loc = Split_global(data,window1,p); %这是多次分段检查找到的好step,并入下面的step中，下面的数组大一些，便于后续添加ste
% step_loc(1:length(good_step_loc)) = good_step_loc; %good_step_loc已经包含了起点和终点
% 
% nst_found = length(good_step_loc)-1;
% start = 0;
% get_new = 1;
% p2 = 1.5;
% while(get_new)
%     out_nst_found = nst_found;
%     for c = 1:out_nst_found
%         stop = good_step_loc(c+1);
%         new_step_loc = Split2_refine(data,start,stop,p2);
%         if new_step_loc
%             nst_found = nst_found+1;
%             step_loc(nst_found+1) = new_step_loc;
%         end
%         start = stop;
%     end
%     get_new = nst_found-out_nst_found;
%     
%     good_step_loc = sort(step_loc(1:nst_found+1));
%     start = 0;
% end
% 直接用差分来排序，尼玛的我就不信了
   neighbour_dif=zeros(length(data),1);
data_denoised = sigDEN5(data);
    delta_i = 20;

                  %for each segment separate
        for i=delta_i:length(data_denoised)-delta_i  %Pick_a_Segment;
            neighbour_dif(i)=(median(data_denoised(i:i+delta_i))-median(data_denoised((i-delta_i+1):i))); % 只有用减法，才能对上关键的跳跃点，否则会有delta_i的错位
        end
%         nei_dif2 = zeros(length(neighbour_dif)-1,1);
%         for i=delta_i:length(data_denoised)  %Pick_a_Segment;
%             nei_dif2(i)=neighbour_dif(i)-neighbour_dif(i-delta_i+1); % 只有用减法，才能对上关键的跳跃点，否则会有delta_i的错位
%         end
[~,good_step_loc] = findpeaks(abs(neighbour_dif),'MinPeakDistance',20,'MinPeakProminence',2*mean(abs(neighbour_dif)),'MinPeakHeight',median(abs(neighbour_dif)));

good_step_loc = [0;good_step_loc;length(data_denoised)];
   
    disp('all steps found')

    disp('ranking the step...');  %下一步是计算所有台阶的拟合值fit，step值，驻留时间，权重，step的正负可以作为判断上下行的判据
    Nst = length(good_step_loc)-2;
    Fit = zeros(Nst+1,1);
    for j = 1:Nst+1
        
        Fit(j)=median(data(good_step_loc(j)+1:good_step_loc(j+1)));
    end
   step = zeros(Nst+2,1);
   step(1) = 0;
   step(end) = 0;
   step(2:end-1) = diff(Fit);
%    dwell_time = zeros(Nst+2,1);  %现在还是过拟合状态，计算dwell time没有意义
%    dwell_time(1:end-1) = diff(good_step_loc);
%    dwell_time(end) = 0;
   % 第一种权重计算方式，按照stepsize，但是过拟合的时候stepsize会被切割，导致拟合不准。
   rank1 = zeros(Nst+2,1);

   rank1(2:end-1) = abs(step(2:end-1));
   rank1(1) = max(abs(step))+1;
   rank1(end) = max(abs(step))+1;
   % 第二个判据利用差分信号来定位step位置，并将峰值作为权重。
   rank2 = zeros(Nst+2,1);
   rank2(2:end-1) = abs(neighbour_dif(good_step_loc(2:end-1)));
   rank2(1) = max(rank2)+1;
   rank2(end) = max(rank2)+1;
   indexes = zeros(Nst+2,6); % 先按照愿来的格式弄，以后改成自己的，把不用的垃圾都丢了
   indexes(2:end-1,1) = 1;
   indexes(:,2) = good_step_loc;
   indexes(:,3) = step;
   indexes(:,4) = rank1;
   indexes(:,5) = rank2;

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
for i=1:N-1
    Chisq_base = sum( (rij(i*window+1:min((i+1)*window,length(rij)))-mean(rij(i*window+1:min((i+1)*window,length(rij)))) ).^2)/(window-1); % 计算整个窗口的卡方值，作为基底
    if (i<N)
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
        mo = length(rij)-i*(N-1);
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
good_step_loc(1) = 0;
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
