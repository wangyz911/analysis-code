function [new_steps_all] = tdms_shift_cor(Steps_all)
%本函数用来修正因为漂移生成的微小伪step
%Steps_all(:,tel1)=[which_seg; only_indexes(j) ; only_indexes(j)-lijst(which_seg); Fit(only_indexes(j)); step; nw; 0];
% 矩阵中的数按顺序分别为，
%   此处显示详细说明
steps_for_cor = sort_on_key(Steps_all',2)';
steps = steps_for_cor(5,:);
window = steps_for_cor(3,:);
window_check = 10;   %时间检查，小于5帧的不要
step_check = max(Steps_all(5,:))*0.1; % 步长检查，小于最大步长的百分之20
% step_check = 0; % 步长检查，小于最大步长的百分之20
step_shift = find(steps<=step_check|window < window_check);

while( ~isempty(step_shift))
    for i = step_shift
        if i<3
            continue;
        end
        temp = (steps_for_cor(4,i)*steps_for_cor(3,i)+ steps_for_cor(4,i-1)*steps_for_cor(3,i-1))/sum(steps_for_cor(3,(i-1):i));%两个台阶合并，主要是统计计算出fit值
        steps_for_cor(4,i-1) = temp;
        steps_for_cor(3,i-1) = steps_for_cor(3,i-1)+steps_for_cor(3,i); %计算出fit值后，将台阶长度加和
        steps_for_cor(5,i-1) = abs(steps_for_cor(4,i-1)-steps_for_cor(4,i-2)); % 合并后fit(i)=fit(i+1)，直接拿来用了
        if i<length(steps) % 如果不是末端就计算另一边的点，否则就不算了，反正要
            steps_for_cor(5,i+1) = abs(steps_for_cor(4,i+1)-steps_for_cor(4,i-1)); %台阶合并后新台阶的高度变化了，需要修复两侧的step值
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