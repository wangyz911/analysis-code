function [cenX,cenY] = radial_profile(img_array,xc,yc,r_step,theta_num_perQ)
% 本函数用于计算若干张图像数据的质心位置，图像有先后顺序但无逻辑顺序。
% 本函数对图心的寻找进行了改进，主要是消除背景噪声。
% 输入来的是N张图拼接起来的长图矩阵。
% 本函数是labview 并行计划的第一环
% 本函数必须假设图像矩阵是长宽一致的。

% 第一步，确定图像总矩阵大小，img_array 是一个三维矩阵，
% img_array = im2double(img_array);
 ROI_size = size(img_array,2);
 img_num = size(img_array,3);
 cenX = zeros(img_num,1);
 cenY = zeros(img_num,1);
%% 第二步，按参数生成QI的采样极坐标，并生成极坐标矩阵
 % 此处令r_max 等于距离边界最小的, 然而并不能这样做，会导致校准的时候LUT 不整齐
 r_max = floor(ROI_size/2)-2;
%  r_max = 10;
 r = 0:r_step:r_max;
 r = r(1:(end-1));
 r_size = size(r,2);
 
 theta_step = pi/2/theta_num_perQ;
 theta = 0:theta_step:2*pi;
 theta = theta(1:(end-1));
 theta_size = size(theta,2);
 
 r_matrix = zeros(theta_size,r_size);
 theta_matrix = zeros(r_size,theta_size);
 
 for i = 1:theta_size
     r_matrix(i,:) = r;
 end
 
  for i = 1:r_size
     theta_matrix(i,:) = theta;
 end
 theta_matrix = theta_matrix';
 
%% 第三步，矩阵极坐标化
radial_result = QI_polar_1(xc,yc,r_size,theta_size,r_matrix,theta_matrix,img_array,img_num);

%  radial_result = zeros(theta_size,r_size);
% for i = 1:theta_size
%     for j = 1:r_size
%         x = xc+r_matrix(i,j)*cos(theta_matrix(i,j));
%         y = yc+r_matrix(i,j)*sin(theta_matrix(i,j));
%         x1=floor(x);
%         y1=floor(y);
%         x2=x1+1;
%         y2=y1+1;
%         radial_result(i,j) = img_array(x1,y1)*(x2-x)*(y2-y)+img_array(x1,y2)*(x2-x)*(y-y1)...
%             +img_array(x2,y1)*(x-x1)*(y2-y)+img_array(x2,y2)*(x-x1)*(y-y1);
%     end
% end
for k = 1:img_num
radial_sum = radial_result(:,:,k);
% 将计算结果按四个象限平均。
 radialProfile1 = mean(radial_sum(1:theta_num_perQ,:));
 radialProfile2 = mean(radial_sum((theta_num_perQ+1):2*theta_num_perQ,:));
 radialProfile3 = mean(radial_sum((2*theta_num_perQ+1):3*theta_num_perQ,:));
 radialProfile4 = mean(radial_sum((3*theta_num_perQ+1):4*theta_num_perQ,:));
 radialProfile1 = rdp_power(r,radialProfile1);
 radialProfile2 = rdp_power(r,radialProfile2);
 radialProfile3 = rdp_power(r,radialProfile3);
 radialProfile4 = rdp_power(r,radialProfile4);
 
 
 % 分别计算X Y 方向的相关曲线，及其下标
 radial_left = radialProfile2+radialProfile3;
 radial_right = radialProfile1+radialProfile4;
 radial_x = [flip(radial_left(2:end),2),radial_right];
 radial_fx = flip(radial_x,2);
 corr_X = xcorr(radial_x,radial_fx);
 
 radial_up = radialProfile1+radialProfile2;
 radial_down = radialProfile3+radialProfile4;
 radial_y = [flip(radial_down(2:end),2),radial_up];
 radial_fy = flip(radial_y,2);
 corr_Y = xcorr(radial_y,radial_fy);
 % 下标换算
 size_radial = size(radial_x,2);
 r_index = -(size_radial-1):(size_radial-1);
 % 寻找相关曲线最高点，拟合计算偏移量
 peak_x = find(corr_X==max(corr_X));
 x_fitX = r_index((peak_x-3):(peak_x+3));
 y_fitX =corr_X((peak_x-3):(peak_x+3));
 px = polyfit(x_fitX,y_fitX,2);
 x_shift = -px(2)/(2*px(1))*2/pi;
 %
 cenX = xc+x_shift;
 
 peak_y = find(corr_Y==max(corr_Y));
 x_fitY = r_index((peak_y-3):(peak_y+3));
 y_fitY =corr_Y((peak_y-3):(peak_y+3));
 py = polyfit(x_fitY,y_fitY,2);
 y_shift = -py(2)/(2*py(1))*2/pi;
 % 下面是减号，因为matlab 和labview 的坐标原点不一样, 用到labview 上一定要记得改啊！！！
 cenY = yc-y_shift;
end     
end