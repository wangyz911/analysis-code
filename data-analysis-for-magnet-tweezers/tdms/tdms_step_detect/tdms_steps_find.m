function [data_for_detect, indexes,lijst,properties,initval] = tdms_steps_find(data_for_detect,cutoff_Nst)
% ���������ڲ���ѡ�е��������������step λ�ã�������Ȩ�ؽ��д��
%Settings
%------------------------------------------

initval.showfits=0;          %shows the fitting,
initval.makemovie=0 ;       %Make a movie of the fits (also switch 'showfits on')
initval.ra=500;                %for noise determination: max distance between data points
initval.condense=0;             %condenses original data with this factor by skipping points
initval.cutoff=cutoff_Nst;             %max aantal steps fitted {to gain time} ��ֹ��ϲ�����������200�����Խ�ʡʱ�䣬����ʵ������޸�
initval.deelfactor=1;           %pre-divisions ; per segment! Ԥ�и�ֱ�����ٽ��ϣ����Խ�ʡʱ��
initval.treshold = 3;           %number_of sigmas that a spike is allowed to rise
initval.standardinput=0;
initval.inpath='E:\analysis code\data-analysis-for-magnet-tweezers\Chi_square\SendPackStepfinder070626';
initval.outpath='E:\analysis code\data-analysis-for-magnet-tweezers\Chi_square\SendPackStepfinder070626';

% ��ȡ�����data�ļ���data Ӧ�������У�һ����ʱ���ᣬһ���Ǵ���λ��
% ����ѡ���²���������̨��ʶ���ٶȣ�Ӧ�ò�Ϊ0�Ϳ����²��������Ҳ�ͬ�������Ե����²������ܶ�
if initval.condense~=0
    data_for_detect=Skip_Points(data_for_detect,initval);
end
%Optional: Condense data to gain time
% Ϊ���ȱ���һ�£��Լ��趨һ��lijst
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
resampled_data = resampled_data(:,1:tel-1); % ��ȥ����û��Ŀհײ���
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
disp('Left mouse button picks points.') % ����������������ѡʲô
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
    round=0;  % �ڼ���
    start=0;  % ���
    segment_aantal=0; % һ���ж���̨��
    found_last_round=initval.deelfactor-1; % ����һ�����ȶ��ķֶ����ٹ��ܣ���ò�Ҫ�ã���deelfactor=1���ɡ�
    
    %2) Pick a data segment (if the data consists of different data
    %sets glued together
    segment_data=data(lijst(lijst_teller)+1:lijst(lijst_teller+1),:);
    N1=length(segment_data);
    segment_indexes=zeros(N1,6);
    properties.growth_range=properties.growth_range+max(segment_data(:,2))-min(segment_data(:,2)); % ͳ�����ݵ�ȡֵ��Χ
    
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
        segment_indexes(1:2,2)=[0,N1]';         % �����յ������
        segment_indexes(1:2,4)=[tres0,tres0]';  % �������յ�ļ�Ȩ���أ����ں�������
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
    for c=1:initval.deelfactor % ��һ�ε���������ÿ���ֶ����ҵ�һ��̨��
        stop=sorteer(c+1);
        %----------------------------------------------------------
        %this section adresses a two-dim array 'segment_data'in a specific segmentand determines the best step-fit there
        spl=Split2(segment_data,start,stop); %��̨�ף��þ�����
        
        if spl~=[0,0,0,0,0]
            segment_aantal=segment_aantal+1;  %����ҵ�̨�ף�̨����+1��Index��С��̨����+2
            segment_indexes(c+1,:)=[1,spl(2:5) ,spl(1)];
            %segment-indexes contains:
            %round, index, stepsize, step*srqt(N),%step*sqrt(N/Var), minimum Chi
        end
        start=stop;
    end %
    found_last_round=segment_aantal+2;       %includes begin and end ���Ǽ����ⲻ�� ֻҪ����0�����������ʽҲ����
    start=0;   %resetting of a loop
    segment_aantal=segment_aantal+1;         %����ͺ��Ի󣬸�segment_aantal ûɶ�߼���ϵ��+1Ҳ�������ɣ����Ǵյ�3
    sorteer=sort(segment_indexes(1:segment_aantal+1,2));
    
    %5) Iterative_Split; ��ʽ��ʼ����
    % Each new series of splitted steps is added to
    %the existing, earlier determined locations. The collection is regularly
    %sorted. The result is a ranked list of locations where steps can be
    %added;
    %------------------------------------------------------------------
    while found_last_round ~=0   %nested2 continue until no more steps can be fitted
        round=round+1;
        oudsegment_aantal=segment_aantal; %outsegment ��ʾ����ѭ�������Ĵ�����ע�⣬�������2����Ӧһ��̨�ף���������
        for c=1:oudsegment_aantal % nest3, run through the plateaus found in the former round
            stop=sorteer(c+1);  %�յ��2��ʼ����������
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
        found_last_round=segment_aantal-oudsegment_aantal; %��������̨���������һ����˵��û�ҵ���̨�ף���ô�Ͳ���ѭ����
        sorteer=sort(segment_indexes(1:segment_aantal+1,2)); %�����ҳ�����̨�������¸�ѭ����
%         lijst_teller=lijst_teller;
        start=0;   %resetting of a loop; go back the beginning of the loop ������㣬�ٰ��ֶ��������̨��
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

indexes=indexes(2:properties.aantal+1,:);  %get the zero out of the system! ��ǰ��ΪëҪ��0��
indexes(:,4)=indexes(:,4)/properties.noise;
%convert column 4 (=step*sqrt(N)) to a relative error that can be compared with other datasets with different noise levels
indexes=(fliplr((sort_on_key(indexes,1))'))'; % ����ת����ת��ʲô��˼�� ǿ��ʹ������ת�ã�ֱ��������ת�ò��ͺ��ˣ�����ΪʲôҪ����ô�ţ�����û������
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
if window>2 % ���ѭ���Ǳ�Ȼ�е�2���㣬���е���ֹͣ������û��̫������
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


% �Լ�д��һ�����ڴ��ڵĸĽ������ɨ��̨��λ�õĺ���
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
% % good_step_loc = union(good_step_loc1,good_step_loc2); %���Ƕ�ηֶμ���ҵ��ĺ�step,���������step�У�����������һЩ�����ں������step
% all_good = [good_step_loc1,good_step_loc2,good_step_loc3,good_step_loc4,good_step_loc5];
% good_step_loc = unique(all_good);


% good_step_loc = Split_global(data,window1,p); %���Ƕ�ηֶμ���ҵ��ĺ�step,���������step�У�����������һЩ�����ں������ste
% step_loc(1:length(good_step_loc)) = good_step_loc; %good_step_loc�Ѿ������������յ�
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
% ֱ���ò��������������ҾͲ�����
   neighbour_dif=zeros(length(data),1);
data_denoised = sigDEN5(data);
    delta_i = 20;

                  %for each segment separate
        for i=delta_i:length(data_denoised)-delta_i  %Pick_a_Segment;
            neighbour_dif(i)=(median(data_denoised(i:i+delta_i))-median(data_denoised((i-delta_i+1):i))); % ֻ���ü��������ܶ��Ϲؼ�����Ծ�㣬�������delta_i�Ĵ�λ
        end
%         nei_dif2 = zeros(length(neighbour_dif)-1,1);
%         for i=delta_i:length(data_denoised)  %Pick_a_Segment;
%             nei_dif2(i)=neighbour_dif(i)-neighbour_dif(i-delta_i+1); % ֻ���ü��������ܶ��Ϲؼ�����Ծ�㣬�������delta_i�Ĵ�λ
%         end
[~,good_step_loc] = findpeaks(abs(neighbour_dif),'MinPeakDistance',20,'MinPeakProminence',2*mean(abs(neighbour_dif)),'MinPeakHeight',median(abs(neighbour_dif)));

good_step_loc = [0;good_step_loc;length(data_denoised)];
   
    disp('all steps found')

    disp('ranking the step...');  %��һ���Ǽ�������̨�׵����ֵfit��stepֵ��פ��ʱ�䣬Ȩ�أ�step������������Ϊ�ж������е��о�
    Nst = length(good_step_loc)-2;
    Fit = zeros(Nst+1,1);
    for j = 1:Nst+1
        
        Fit(j)=median(data(good_step_loc(j)+1:good_step_loc(j+1)));
    end
   step = zeros(Nst+2,1);
   step(1) = 0;
   step(end) = 0;
   step(2:end-1) = diff(Fit);
%    dwell_time = zeros(Nst+2,1);  %���ڻ��ǹ����״̬������dwell timeû������
%    dwell_time(1:end-1) = diff(good_step_loc);
%    dwell_time(end) = 0;
   % ��һ��Ȩ�ؼ��㷽ʽ������stepsize�����ǹ���ϵ�ʱ��stepsize�ᱻ�и������ϲ�׼��
   rank1 = zeros(Nst+2,1);

   rank1(2:end-1) = abs(step(2:end-1));
   rank1(1) = max(abs(step))+1;
   rank1(end) = max(abs(step))+1;
   % �ڶ����о����ò���ź�����λstepλ�ã�������ֵ��ΪȨ�ء�
   rank2 = zeros(Nst+2,1);
   rank2(2:end-1) = abs(neighbour_dif(good_step_loc(2:end-1)));
   rank2(1) = max(rank2)+1;
   rank2(end) = max(rank2)+1;
   indexes = zeros(Nst+2,6); % �Ȱ���Ը���ĸ�ʽŪ���Ժ�ĳ��Լ��ģ��Ѳ��õ�����������
   indexes(2:end-1,1) = 1;
   indexes(:,2) = good_step_loc;
   indexes(:,3) = step;
   indexes(:,4) = rank1;
   indexes(:,5) = rank2;

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
for i=1:N-1
    Chisq_base = sum( (rij(i*window+1:min((i+1)*window,length(rij)))-mean(rij(i*window+1:min((i+1)*window,length(rij)))) ).^2)/(window-1); % �����������ڵĿ���ֵ����Ϊ����
    if (i<N)
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
        mo = length(rij)-i*(N-1);
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
good_step_loc(1) = 0;
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
