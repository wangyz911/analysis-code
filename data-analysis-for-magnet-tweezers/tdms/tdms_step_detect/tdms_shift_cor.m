function [new_steps_all] = tdms_shift_cor(Steps_all)
%����������������ΪƯ�����ɵ�΢Сαstep
%Steps_all(:,tel1)=[which_seg; only_indexes(j) ; only_indexes(j)-lijst(which_seg); Fit(only_indexes(j)); step; nw; 0];
% �����е�����˳��ֱ�Ϊ��
%   �˴���ʾ��ϸ˵��
steps_for_cor = sort_on_key(Steps_all',2)';
steps = steps_for_cor(5,:);
window = steps_for_cor(3,:);
window_check = 10;   %ʱ���飬С��5֡�Ĳ�Ҫ
step_check = max(Steps_all(5,:))*0.1; % ������飬С����󲽳��İٷ�֮20
% step_check = 0; % ������飬С����󲽳��İٷ�֮20
step_shift = find(steps<=step_check|window < window_check);

while( ~isempty(step_shift))
    for i = step_shift
        if i<3
            continue;
        end
        temp = (steps_for_cor(4,i)*steps_for_cor(3,i)+ steps_for_cor(4,i-1)*steps_for_cor(3,i-1))/sum(steps_for_cor(3,(i-1):i));%����̨�׺ϲ�����Ҫ��ͳ�Ƽ����fitֵ
        steps_for_cor(4,i-1) = temp;
        steps_for_cor(3,i-1) = steps_for_cor(3,i-1)+steps_for_cor(3,i); %�����fitֵ�󣬽�̨�׳��ȼӺ�
        steps_for_cor(5,i-1) = abs(steps_for_cor(4,i-1)-steps_for_cor(4,i-2)); % �ϲ���fit(i)=fit(i+1)��ֱ����������
        if i<length(steps) % �������ĩ�˾ͼ�����һ�ߵĵ㣬����Ͳ����ˣ�����Ҫ
            steps_for_cor(5,i+1) = abs(steps_for_cor(4,i+1)-steps_for_cor(4,i-1)); %̨�׺ϲ�����̨�׵ĸ߶ȱ仯�ˣ���Ҫ�޸������stepֵ
        end
        
    end
    steps_for_cor(:,step_shift) = [];
    steps = steps_for_cor(5,:);
    window = steps_for_cor(3,:);
    step_shift = find(steps<=step_check|window < window_check);
end


new_steps_all = steps_for_cor;
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