% 测试脚本，用来测试差分找台阶的效果

diff_step = diff(data_step);
diff_denoised = diff(data_denoised);

    neighbour_dif=zeros(length(data_step)-1,1);
    delta_i = 20;

                  %for each segment separate
        for i=delta_i:length(data_denoised)-delta_i  %Pick_a_Segment;
            neighbour_dif(i)=(median(data_denoised(i:i+delta_i))-median(data_denoised((i-delta_i+1):i))); % 只有用减法，才能对上关键的跳跃点，否则会有delta_i的错位
        end
%         nei_dif2 = zeros(length(neighbour_dif)-1,1);
%         for i=delta_i:length(data_denoised)  %Pick_a_Segment;
%             nei_dif2(i)=neighbour_dif(i)-neighbour_dif(i-delta_i+1); % 只有用减法，才能对上关键的跳跃点，否则会有delta_i的错位
%         end
[val,good_step_loc] = findpeaks(abs(neighbour_dif),'MinPeakDistance',20,'MinPeakProminence',2*mean(abs(neighbour_dif)),'MinPeakHeight',median(abs(neighbour_dif)));

good_step_loc = [0;good_step_loc;length(data_denoised)];
val = [data_denoised(1);val;data_denoised(end)];
% sum_d = 100;
%         sum_dif = neighbour_dif*0;
%         for j = sum_d+1:length(data_denoised)-sum_d-delta_i
%             sum_dif(j) = sum(neighbour_dif((j-sum_d):(j+sum_d)))/10;
%         end
        
        
plot(data_step);
hold on
plot(diff_denoised);
plot(neighbour_dif);
plot(good_step_loc,val,'o');
 % 依据当前台阶位置进行data的fit
 le = length(good_step_loc);
 Fit = zeros(length(data_denoised),1);
for k=1:le-1
    Fit(good_step_loc(k)+1:good_step_loc(k+1))=mean(data_step(good_step_loc(k)+1:good_step_loc(k+1)));
end
plot(Fit,'LineWidth',1.5);

% plot(sum_dif);