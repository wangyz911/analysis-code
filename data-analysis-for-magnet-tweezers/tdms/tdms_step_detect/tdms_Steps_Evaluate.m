function [Steps_all,Fit]=tdms_Steps_Evaluate(data_for_detect, indexes,lijst, properties,initval,doitforthisstepnumber)
%EVALUATION
initval.ranking=2;              % 1: order steps by expected accuracy; 2: by measured accuracy
initval.showfits=0;
initval.lo_hist=-120;            %nm
initval.hi_hist=120;             %nm
initval.bin_hist=6;             %nm
initval.fast_steptest=4;        %number of points left and right of a step used for evaluating how instant a step is.��������һ��step�ж��
% initval.fast_steptest=4;      %�����ظ���һ��
initval.Nst=doitforthisstepnumber; %��һ����������0�����������ٸ�̨��Ϊ�ˣ��ڶ��������Ƽ��Ĳ������õ����յ�ͳ�ƽ��
close;
%-----------------------------------------------------------------------
%end of splitting part; Up to now, all possible steps has been found.
% figcnt=0; %for counting frames for movie
% c=0;        %for collecting fits
% shft=0;
% CollectFits=[];
lei=length(indexes);
lel=length(lijst);

%Now, rank them by their expected error of their measured one.
disp('sorting...');
if initval.ranking == 1
    indexes(1:lei,:)=sort_on_key(indexes(1:lei,:),4);
end  %sort on expected error (proportional with [noise*stepsize*sqrt(windowsize)]^-1 )

if initval.ranking == 2
    indexes(1:lei-lel,:)=sort_on_key(indexes(1:lei-lel,:),5);
end  %sort on measured error (proportional with [Chisq^0.5*stepsize*sqrt(windowsize)]^-1 )


%Initialize; %this section also uses the borderpoints to make a first fit
%-----------------------------------------------------------------------
Steppedness=zeros(properties.aantal,4);
Fit=ones(properties.N0,1);
le=length(lijst);
for tel=1:le-1
    Fit(lijst(tel)+1:lijst(tel+1))=mean(data_for_detect(lijst(tel)+1:lijst(tel+1),2));
end
% Anti_Fit=Fit;
% Var=sum((data(:,2)-Fit).^2);
% Anti_Var=sum((data(:,2)-Anti_Fit).^2);
% Chi=Var/properties.N0;
% Anti_Chi=Anti_Var/properties.N0;
Anti_Fit=Fit;



if initval.Nst>0
    stophere=initval.Nst+le;        %add number of segments ����������̨����+segment��
else
    stophere=initval.cutoff;        % NST �ƺ���Ϊ0��Ҳ����˵��ֹ������200���������200����ֹ��������ȫ��ֺ��ʵ�ʶ�����
end
if stophere > properties.aantal, stophere = properties.aantal;  end  % �����ֹ̨����>�����еķֶ��������ֹ̨�׵��ڷֶ������������ܸ��ࣩ
%------------------------------------------------------------------------

% 
% teller=0;
% selected_aantal=1;
% %Analyze
% while selected_aantal < stophere+1   %aantal is the total number after  full splitting aantal ����ȫ��ֺ�Ķ�������+1��֤������stophere��
%     teller=teller+1;
%     if indexes(properties.aantal-selected_aantal+1,1)~=0  %skip 'border' points of segments ��һ����round������0 round �Ǳ�Ե��
%         new_index=indexes(properties.aantal+1-selected_aantal,2); % �ڶ�����̨�׵�location����location �����򣬲���Ϊonly_indexes
%         only_indexes=sort(indexes(properties.aantal+1-selected_aantal:properties.aantal,2));  %with new index(es) added from the main list ����Only indexes�ƺ�ֵ����indexes��ĩ�˵�selected ��location����Ϊ��ĩ�˵�ranking��ߣ�Ҳ���������ȣ�ǰ�治֪�����˸�ɶ����������ĩ�˱���1000
%         only_indexes=[0,only_indexes']';
%         
%         %Pick_a_Segment(lijst, new_index);
%         %--------------------------------
%         %Find the segment where the new step-location is residing
%         lel=length(lijst);
%         pick=[0,0];
%         for i=1:lel-1
%             if new_index > lijst(i) && new_index <lijst(i+1)  % �����������ж����ڵ�step_index����һ��segment��
%                 pick=[lijst(i),lijst(i+1)];
%             end
%         end
%         
%         %Change_Fits_Where_Needed;
%         %the largest stretch affected by the new step is not that of the 'good' indexes on
%         %the left and the right, but on the 'bad' indexes even more to the
%         %left and the right of those. Meaning, three indexes determine
%         %where the best fit should be changed, four indexes determine where
%         %the 'worst' fit should be changed.
%         %This speeds up the whole analysis especially in the
%         %over-fit-range
%         %------------------------------------------
%         zoek=find(only_indexes==new_index);  %this is where a new step is in the indexrow �ҵ�����ָ���λ��
%         gim=new_index;
%         gil=only_indexes(zoek-1); % good index on left ���������location
%         gir=only_indexes(zoek+1); % ...... right....... ������Ҳ��location
%         %check for borders ����border ��Ϊ��ͬ���������
%         border=1;
%         if gil== pick(1), border =2;  end %border on left side
%         if gir == pick(2), border =3;  end %border on right side
%         if gir == pick(2) && gil==pick(1), border =4;  end
%         %determine left, right and middle bad indexes
%         a=ceil((gil+gim)/2); % badindexmiddle left
%         dummy=Split2(data_for_detect,gil+1,gim); %����������ν�ȡ��������Split2����������ѷָ�㣬bΪ��ѷָ��ľ���λ�ã�������
%         b=dummy(2);
%         %bilm=max(a,b);
%         if b==0, bilm=a;  % �����ϲ���һ���õ�̨�ף���ֱ��ȡ���ķֵ�a,�����ǲ���̨����
%         else
%             bilm=b; % ��¼����и��λ��
%         end
%         a=ceil((gim+gir)/2); % badindexmiddle right
%         dummy=Split2(data_for_detect,gim+1,gir); % ��������Ұ�ν�ȡ������������ѷָ�㣬bΪ��ѷָ�����λ��
%         b=dummy(2);
%         %birm=max(a,b);
%         if b==0, birm=a;
%         else
%             birm=b; % ��¼�Ұ��и��λ��
%         end
%         %determine outer limits
%         switch border
%             case 1  %no borders
%                 a=ceil((gil+only_indexes(zoek-2))/2);
%                 dummy=Split2(data_for_detect,only_indexes(zoek-2)+1,gil); % ���û�б߽磬���㿼���������������ŷָ�
%                 b=dummy(2);
%                 %bil=max(a,b);
%                 if b==0
%                     bil=a;
%                 else
%                     bil=b;
%                 end
%                 a=ceil((gir+only_indexes(zoek+2))/2);
%                 dummy=Split2(data_for_detect,gir+1,only_indexes(zoek+2));  % ���û�б߽磬���㿼����Ҳ����Ҳ�����ŷָ�
%                 b=dummy(2);
%                 %bir=max(a,b);
%                 if b==0
%                     bir=a;
%                 else
%                     bir=b;
%                 end
%             case 2 %border on left                               % ����б߽磬���bil���ڱ߽磬�Ҳ�����Ҳ����Ҳ�ķָ��
%                 bil=pick(1);
%                 a=ceil((gir+only_indexes(zoek+2))/2);
%                 dummy=Split2(data_for_detect,gir+1,only_indexes(zoek+2));
%                 b=dummy(2);
%                 %bir= max(a,b);
%                 if b==0
%                     bir=a;
%                 else
%                     bir=b;
%                 end
%             case 3 %border on right                               % �ұ��б߽磬�Ҳ�bil���ڱ߽磬��������������ķָ��
%                 a=ceil((gil+only_indexes(zoek-2))/2);
%                 dummy=Split2(data_for_detect,only_indexes(zoek-2)+1,gil);
%                 b=dummy(2);
%                 %bil=max(a,b);
%                 if b==0
%                     bil=a;
%                 else
%                     bil=b;
%                 end
%                 bir=pick(2);
%             case 4 % both borders                                 %���඼�Ǳ߽磬ֱ����Ϊ�߽�ֵ
%                 bil=pick(1);
%                 bir=pick(2);
%         end
        


teller=0;
selected_aantal=1;
%Analyze
while selected_aantal < stophere+1   %aantal is the total number after  full splitting aantal ����ȫ��ֺ�Ķ�������+1��֤������stophere��
    teller=teller+1;
    if indexes(properties.aantal-selected_aantal+1,1)~=0  %skip 'border' points of segments ��һ����round������0 round �Ǳ�Ե��
        new_index=indexes(properties.aantal+1-selected_aantal,2); % �ڶ�����̨�׵�location����location �����򣬲���Ϊonly_indexes
        only_indexes=sort(indexes(properties.aantal+1-selected_aantal:properties.aantal+2,2));  %with new index(es) added from the main list ����Only indexes�ƺ�ֵ����indexes��ĩ�˵�selected ��location����Ϊ��ĩ�˵�ranking��ߣ�Ҳ���������ȣ�ǰ�治֪�����˸�ɶ����������ĩ�˱���1000
%         only_indexes=[0,only_indexes']';
        
        %Pick_a_Segment(lijst, new_index);
        %--------------------------------
        %Find the segment where the new step-location is residing
        lel=length(lijst);
        pick=[0,0];
        for i=1:lel-1
            if new_index > lijst(i) && new_index <lijst(i+1)  % �����������ж����ڵ�step_index����һ��segment��
                pick=[lijst(i),lijst(i+1)];
            end
        end
        
        %Change_Fits_Where_Needed;
        %the largest stretch affected by the new step is not that of the 'good' indexes on
        %the left and the right, but on the 'bad' indexes even more to the
        %left and the right of those. Meaning, three indexes determine
        %where the best fit should be changed, four indexes determine where
        %the 'worst' fit should be changed.
        %This speeds up the whole analysis especially in the
        %over-fit-range
        %------------------------------------------
        zoek=find(only_indexes==new_index);  %this is where a new step is in the indexrow �ҵ�����ָ���λ��
        gim=new_index;
        gil=only_indexes(zoek-1); % good index on left ���������location
        gir=only_indexes(zoek+1); % ...... right....... ������Ҳ��location
        %check for borders ����border ��Ϊ��ͬ���������
        border=1;
        if gil== pick(1), border =2;  end %border on left side
        if gir == pick(2), border =3;  end %border on right side
        if gir == pick(2) && gil==pick(1), border =4;  end
        %determine left, right and middle bad indexes
        a=ceil((gil+gim)/2); % badindexmiddle left
        dummy=Split2(data_for_detect,gil+1,gim); %����������ν�ȡ��������Split2����������ѷָ�㣬bΪ��ѷָ��ľ���λ�ã�������
        b=dummy(2);
        %bilm=max(a,b);
        if b==0, bilm=a;  % �����ϲ���һ���õ�̨�ף���ֱ��ȡ���ķֵ�a,�����ǲ���̨����
        else
            bilm=b; % ��¼����и��λ��
        end
        a=ceil((gim+gir)/2); % badindexmiddle right
        dummy=Split2(data_for_detect,gim+1,gir); % ��������Ұ�ν�ȡ������������ѷָ�㣬bΪ��ѷָ�����λ��
        b=dummy(2);
        %birm=max(a,b);
        if b==0, birm=a;
        else
            birm=b; % ��¼�Ұ��и��λ��
        end
        %determine outer limits
        switch border
            case 1  %no borders
                a=ceil((gil+only_indexes(zoek-2))/2);
                dummy=Split2(data_for_detect,only_indexes(zoek-2)+1,gil); % ���û�б߽磬���㿼���������������ŷָ�
                b=dummy(2);
                %bil=max(a,b);
                if b==0
                    bil=a;
                else
                    bil=b;
                end
                a=ceil((gir+only_indexes(zoek+2))/2);
                dummy=Split2(data_for_detect,gir+1,only_indexes(zoek+2));  % ���û�б߽磬���㿼����Ҳ����Ҳ�����ŷָ�
                b=dummy(2);
                %bir=max(a,b);
                if b==0
                    bir=a;
                else
                    bir=b;
                end
            case 2 %border on left                               % ����б߽磬���bil���ڱ߽磬�Ҳ�����Ҳ����Ҳ�ķָ��
                bil=pick(1);
                a=ceil((gir+only_indexes(zoek+2))/2);
                dummy=Split2(data_for_detect,gir+1,only_indexes(zoek+2));
                b=dummy(2);
                %bir= max(a,b);
                if b==0
                    bir=a;
                else
                    bir=b;
                end
            case 3 %border on right                               % �ұ��б߽磬�Ҳ�bil���ڱ߽磬��������������ķָ��
                a=ceil((gil+only_indexes(zoek-2))/2);
                dummy=Split2(data_for_detect,only_indexes(zoek-2)+1,gil);
                b=dummy(2);
                %bil=max(a,b);
                if b==0
                    bil=a;
                else
                    bil=b;
                end
                bir=pick(2);
            case 4 % both borders                                 %���඼�Ǳ߽磬ֱ����Ϊ�߽�ֵ
                bil=pick(1);
                bir=pick(2);
        end
        %store values from parts that are going to be changed
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
        
        Fit(gil+1:gim)=mean(data_for_detect(gil+1:gim,2));             % �õ�������꣨good index location�������������Ұ�ľ�ֵ��Ϊ̨�����
        Fit(gim+1:gir)=mean(data_for_detect(gim+1:gir,2));
        % Anti_Fit �������滵����ϵ����Ҳ��ֵ�� ����ϣ�bad index location�������Ϊbil+1:bilm��
        % �Ҳ�Ϊbir+1:birm;
        if gil ~= pick(1) %border not on left side
            Anti_Fit(bil+1:bilm)=mean(data_for_detect(bil+1:bilm,2));
        else
            Anti_Fit(bil+1:bilm)=mean(data_for_detect(bil+1:bil+3,2)); % ����Ǳ߽�Ļ���ȡ�߽��3���㵱������������ϣ��о������趨������
        end
        Anti_Fit(bilm+1:birm)=mean(data_for_detect(bilm+1:birm,2));
        if gir ~= pick(2)%border not on right side
            Anti_Fit(birm+1:bir)=mean(data_for_detect(birm+1:bir,2));
        else
            Anti_Fit(birm+1:bir)=mean(data_for_detect(bir-2:bir,2));
        end
        
        Chi=mean((data_for_detect(:,2)-Fit).^2);
        Anti_Chi=mean((data_for_detect(:,2)-Anti_Fit).^2);
        S=Anti_Chi/Chi;           %
        
        
        %Collect_Fit_Properties;
        %-----------------------------------------------
        %1) Determine stepsizes and distinguish between fast and
        %slow steps
        leo=length(only_indexes); % �����̨����
        lel=length(lijst);
        segfinder=[lijst(1:lel-1) lijst(2:lel)]';
        Steps_all=zeros(7,leo);
        Steps_fast=zeros(2,leo);
        FastFit=0*Fit;
        SlowFit=0*Fit;
        tel1=0;
        tel2=0;
        tel3 = 0;

        for j=2:leo-1                                        % only_index��1�Ǳ߽�0�����ÿ��죬���һ������1000��Ҳ���ÿ���
            if any(lijst-only_indexes(j)==0)                  %skip border points [0,1000]-0����1000����0����ʾ��ʱonly_indexes(j)�Ǳ߽�㣬������
            else
                tel1=tel1+1;
                nw=only_indexes(j+1)-only_indexes(j-1); % nwΪ̨������Ŀ��
                step=abs(Fit(only_indexes(j)+1)-Fit(only_indexes(j)));
                %keep track of segment
                which_seg=find(sum(sign(segfinder-only_indexes(j)))==0); % sign(�߽��̨��λ�ã�Ӧ�õõ�-1��1�����Ϊ0��˵���ڷ�Χ�ڣ��߼���תʮ���䣩)�����find����û����
                %keep track of value (prior to step)
                Steps_all(:,tel1)=[which_seg; only_indexes(j) ; only_indexes(j+1)-only_indexes(j); Fit(only_indexes(j)); step; nw; 0];
                %contains: segment totalindex segmentindex val step nw fast
                %
                if (initval.Nst ~= 0&&j ==leo-1)
                    %Test how quick a step is
                    %��һ����ʱ�����ж�̨����һ��˲ʱ�����仹��һ�����䣨α̨�ף�, ��Ͻ�������е�̨�׼���fast fit��
                    %����slow fit ���Ҫ����ԭ��
                    %����ԭ������Ϊ���step�ڵ����������Ǳ仯�ģ���ʱ�����ǿ�step����ʱ��Ͳ��ǣ�Ӧ�ð��ⲿ���жϷ���ѭ��������������˵������һ��ѭ�����Ŷ�
                    %-------------------------------
                    for k=2:leo-1
                        tel3=tel3+1;
                        if      only_indexes(k)-only_indexes(k-1)>2*initval.fast_steptest -1&& ...
                                only_indexes(k+1)-only_indexes(k)>2*initval.fast_steptest-1  %left and right large enough step��Ҫ�����㹻�������ٱ���7����
                            Faststep=mean(data_for_detect(only_indexes(k)+1:only_indexes(k)+3,2))-mean(data_for_detect(only_indexes(k)-2:only_indexes(k),2));% ��̨�����Ҹ�ȡ���������ֵ��Ȼ���ּ���step�߶�
                            if Steps_all(5,k)-Faststep < properties.noise*(2/initval.fast_steptest)^0.5 % ���������������һ��˲ʱ̨�ף�����̨�ף�����fast_stepest�ı�׼���Ե���,noise Ψһ�ô�
                                %the chance that an instant step yields
                                %this much lower closely around the step location is only 15% (half of outside one-sigma confidence interval
                                tel2=tel2+1;
                                nw=only_indexes(k+1)-only_indexes(k-1); % nwΪ̨������Ŀ��
                                Steps_fast(:,tel2)=[Steps_all(5,k);nw];
                                Steps_all(7,tel3)=1;
                                FastFit(only_indexes(k)+1:only_indexes(k+1))=Fit(only_indexes(k)+1:only_indexes(k+1));
                            else
                                SlowFit(only_indexes(k)+1:only_indexes(k+1))=Fit(only_indexes(k)+1:only_indexes(k+1));
                            end
                        end
                    end
                    %_-----------------------
                end
            end
        end
        
        
        
        average_step=properties.growth_range/selected_aantal;
        
        Steppedness(teller,1)=properties.N0/selected_aantal;  %windowsize ƽ����̨������
        Steppedness(teller,2)=S;        %steppedness chibad/chigood
        Steppedness(teller,3)=selected_aantal-length(lijst);      %stepnumber exclusief border points ��ȥ�߽���̨����
        Steppedness(teller,4)=average_step;                       % ƽ��̨�׸߶�
        
        %         if initval.showfits==1
        %             %plot fits
        %             if initval.Nst~=0 &&selected_aantal<7
        %                 c=c+1;
        %                 shft=shft+1.5*max(Steps_all(5,:));
        %                 subplot(1,1,1)
        %                 plot(data(:,2),'LineWidth',1);
        %                 hold on;
        %                 plot( Fit-shft,'r','LineWidth',2);
        %                 figcnt=figcnt+1;
        %                 title(num2str(selected_aantal));
        %                 F(figcnt) = getframe;
        %                 hold on;
        %                 CollectFits(:,c)=Fit-shft;
        %             end
        %             if initval.Nst~=0 &&selected_aantal>5
        %                 if mod(selected_aantal,5)==0   % ����5֮��ÿ����5��̨�׻�һ��ͼ�����ͼ�����ܼ�
        %                     c=c+1;
        %                     shft=shft+1.5*max(Steps_all(5,:));
        %                     subplot(1,1,1)
        %                     plot(data(:,2),'LineWidth',1);
        %                     hold on;
        %                     title(num2str(selected_aantal));
        %                     plot( Fit-shft,'r','LineWidth',2);
        %                     figcnt=figcnt+1;
        %                     F(figcnt) = getframe;
        %                     hold on;
        %                     CollectFits(:,c)=Fit-shft;
        %                 end
        %             end
        %         end
        
    end
    selected_aantal=selected_aantal+1;
end
% �޸�Ư�ƣ���������Ӧ��Fit ֵ
Steps_all=Steps_all(:,1:tel1);
Steps_fast=Steps_fast(:,1:tel2);


%----------------------------------------------------------------------
% if initval.showfits==1&&initval.makemovie==1&&initval.Nst~=0
%     movie(F,1,3)
%     m=strcat(initval.outpath, initvaq 12whbjn iok90p-l,\l.filename,'_mov',int2str(initval.Nst), '.avi');
%     VideoWriter(F,m);
% end
% ���㻨�����

if initval.Nst ~= 0
    % ����������ٽ����޸����޸�����з���
    [steps_all_cor] = tdms_shift_cor(Steps_all);

fit_index = [0,steps_all_cor(2,:),length(Fit)];
for tel=1:(length(steps_all_cor)+1)  %0��ʾ���̨��
    Fit(fit_index(tel)+1:fit_index(tel+1))=median(data_for_detect(fit_index(tel)+1:fit_index(tel+1),2));
end
    
    
    %     Bins=(initval.lo_hist:initval.bin_hist:initval.hi_hist);
    %     Step_hist_all=hist(Steps_all(5,:),Bins);
    
    Step_hist_all=histogram(steps_all_cor(5,steps_all_cor(5,:)>1));
    step_all_hist_bin = Step_hist_all.BinEdges(1:end-1)+Step_hist_all.BinWidth/2;
    step_all_hist_val = Step_hist_all.Values;
    %     Step_hist_fast=[];
    hist_fit = histogram(steps_all_cor(4,:));
    if sum(Steps_fast)>0
        Step_hist_fast=histogram(Steps_fast(1,:));
        step_fast_hist_bin = Step_hist_fast.BinEdges(1:end-1)+Step_hist_fast.BinWidth/2;
        step_fast_hist_val = Step_hist_fast.Values;
    end
    % FastFit_short = unique(FastFit(FastFit~=0));
    %     if sum(Steps_fast)>0, Step_hist_fast=hist(FastFit_short); end
end

Steppedness=Steppedness(1:teller,:);
le=length(lijst);   %skip border points:

disp('Nw   S 0 Nst 0 0 AvStep 0 ')

selectie=find(Steppedness(:,1)~=0);
% ls=length(selectie);

% subplot(1,1,1)
% hold ;
%         Steppedness(teller,1)=properties.N0/selected_aantal;  %windowsize ƽ����̨������
%         Steppedness(teller,2)=S;        %steppedness chibad/chigood
%         Steppedness(teller,3)=selected_aantal-length(lijst);      %stepnumber exclusief border points ��ȥ�߽���̨����
%         Steppedness(teller,4)=average_step;                       % ƽ��̨�׸߶�
if initval.Nst == 0  % ���������������оݸ����Ƽ��Ĳ���
    %     selectie=find(Steppedness(:,1)~=0);
    subplot(3,1,1);
    hold on;
    title('Chibad/Chigood  vs. nst','FontSize',8)
    plot(Steppedness(selectie,3),Steppedness(selectie,2));  %̨������vs Sֵ
    [~,h] = max(Steppedness(selectie,2));
    good_nst_S = Steppedness(h,3);  % ����Sֵ�����Ƽ��Ĳ���
    
    subplot(3,1,2);
    hold on;
    title('(Chibad/Chigood  vs. nw ','FontSize',8);
    plot(Steppedness(selectie,1),Steppedness(selectie,2));  %ƽ��̨������VS Sֵ
    
    good_nst_win = ceil(length(data_for_detect)/Steppedness(h,1));
    subplot(3,1,3);
    hold on;
    title('Chibad/Chigood-1 vs. st )','FontSize',8);
    plot(abs(Steppedness(selectie,4)),Steppedness(selectie,2)-1);  %.ƽ��̨�׸߶�VS Sֵ����Ϊ̨�׸߶ȱ�̨������һ���� ����Ҫ��1
    range = max(data_for_detect(:,2))-min(data_for_detect(:,2));
    good_nst_size = ceil(range/Steppedness(h,1));
    %figname=strcat(initval.filename,'_Stepp' , '.fig');
    %saveas(gcf,figname);
    disp(["the suggested step num by S, window, and stepsize is :",num2str(good_nst_S), num2str(good_nst_win),num2str(good_nst_size)]);
end

if initval.Nst == 0
    All_Steppedness=Steppedness; %keep for later
    All_selectie=selectie;
    histossteps=[];
else
    All_Steppedness=[];
    
    subplot(1,2,1);
    hold on;
    title('Reconstructed steps','FontSize',8)
    % plot(data_for_detect(:,1),data_for_detect(:,2),data_for_detect(:,1), FastFit,'r',data_for_detect(:,1), SlowFit,'g'); % ֮ǰ��ע����
     plot(data_for_detect(:,1),data_for_detect(:,2),data_for_detect(:,1), Fit,'r');
    hold off
    subplot(1,2,2);
    
    title('Histogram of all steps: green; fast steps: red','FontSize',8)
    %     bar(Bins, Step_hist_all, 'g');
    bar( step_all_hist_bin,step_all_hist_val, 'g');
    hold on
    if ~isempty(step_fast_hist_val)
        bar( step_fast_hist_bin,step_fast_hist_val, 'r');
    end
    %     histossteps=[Bins', Step_hist_all'];  %,Step_hist_fast'
    %figname=strcat(initval.filename, '_Fit' , int2str(initval.Nst), '.fig');
    %saveas(gcf,figname);
    
end

% dummy2=Write_files(initval,data_for_detect,Fit,Steps_all,histossteps,All_Steppedness)

disp('ready');


dummy=1;

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
if window>2
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
    rank2=abs(stp)*sqrt(window/g);       %measured rel. step accuracy
    spl=[sqrt(g),h+i1,stp,rank1, rank2];      %minimum Chi, index, stepsize,  step*srqt(N), step*sqrt(N/Var)
else
    spl=[0,0,0,0,0];
end
end
