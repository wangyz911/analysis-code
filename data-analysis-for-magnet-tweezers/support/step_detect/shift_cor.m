function [ step_position_modi,step_info, step_shift ] = shift_cor( data_z, step_position, step_check,length_check )
% 本函数用于消除拟合出来的数据中由于漂移导致的步长很小的step，以提高驻留时间统计的精度，该函数目前仅在dwell time
% count函数中调用。
% 输出变量中，第一个是修正画图用，第二个是修正计算用，第三个是判定循环用。

        % 找到漂移点；
        step_info = get_step_info(data_z,step_position) ;
        step_shift = find(abs(diff(step_info(:,2)))<=step_check|step_info(2:end,1) < length_check);
        % 将小跃变合并消除,消除方法是，台阶两端的值都取两边值和长度的加权平均，将长度加到一端上， 另一端长度等于0.
        for k = step_shift' 

%             step_info(k+1,2)=step_info(k:(k+1),2)'*step_info(k:(k+1),1)/sum(step_info(k:(k+1),1));
%             step_info(k,2) = step_info(k+1,2);
%             step_info(k+1,1) = step_info(k+1,1)+step_info(k,1);
            step_info(k,1) = 0;

        end
        % 得到新的step_position_modi
        step_small = step_info(:,1)==0;
        %减掉一个数，使向量个数匹配。
        step_small(end) = [];
        step_position(step_small) = [];

        step_position_modi = step_position;
        %确保step_info与最新的step_position相匹配
        step_info = get_step_info(data_z,step_position_modi) ;

end

