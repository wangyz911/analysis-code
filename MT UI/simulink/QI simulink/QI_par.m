function [corr_X,corr_Y,r_index] = QI_par(img_array,xc,yc,r_step,theta_num_perQ)
% 本函数用于计算若干张图像数据的质心位置，图像有先后顺序但无逻辑顺序。
% 本函数对图心的寻找进行了改进，主要是消除背景噪声。
% 输入来的是N张图拼接起来的长图矩阵。
% 本函数是labview 并行计划的第一环
% 本函数必须假设图像矩阵是长宽一致的。

% 第一步，确定图像总矩阵大小，img_array 是一个三维矩阵，
img_array = im2double(img_array);
ROI_size = size(img_array,2);
% 第二步，按参数生成QI的采样极坐标，并生成极坐标矩阵
% 此处令r_max 等于距离边界最小的
r_max = floor(min([xc,yc,(ROI_size-xc),(ROI_size-yc)]))-1;
%  r_max = 10;
r = 0:r_step:r_max;
theta_step = pi/2/theta_num_perQ;
theta = theta_step:theta_step:2*pi;

r_matrix = zeros(size(theta,2),size(r,2));
theta_matrix = zeros(size(r,2),size(theta,2));

for i = 1:size(theta,2)
    r_matrix(i,:) = r;
end

for i = 1:size(r,2)
    theta_matrix(i,:) = theta;
end
theta_matrix = theta_matrix';
% x = xc+r_matrix.*cos(theta_matrix);
% y = yc+r_matrix.*sin(theta_matrix);
% x1=floor(x);
% y1=floor(y);
% x2=x1+1;
% y2=y1+1;
% % 第三步，
%   radial_result = zeros(size(theta,2),size(r,2));
% parfor i = 1:size(theta,2)
%     radial_result2 = zeros(1,size(r,2));
%     for j = 1:size(r,2)
%         radial_result2(j) = img_array(x1(i,j),y1(i,j))*(x2(i,j)-x(i,j))*(y2(i,j)-y(i,j))+img_array(x1(i,j),y2(i,j))*(x2(i,j)-x(i,j))*(y(i,j)-y1(i,j))...
%             +img_array(x2(i,j),y1(i,j))*(x(i,j)-x1(i,j))*(y2(i,j)-y(i,j))+img_array(x2(i,j),y2(i,j))*(x(i,j)-x1(i,j))*(y(i,j)-y1(i,j));
%     end
%     radial_result(i,:)=radial_result2;
% end

 radial_result = zeros(size(theta,2),size(r,2));
for i = 1:size(theta,2)
    for j = 1:size(r,2)
        x = xc+r_matrix(i,j)*cos(theta_matrix(i,j));
        y = yc+r_matrix(i,j)*sin(theta_matrix(i,j));
        x1=floor(x);
        y1=floor(y);
        x2=x1+1;
        y2=y1+1;
        radial_result(i,j) = img_array(x1,y1)*(x2-x)*(y2-y)+img_array(x1,y2)*(x2-x)*(y-y1)...
            +img_array(x2,y1)*(x-x1)*(y2-y)+img_array(x2,y2)*(x-x1)*(y-y1);
    end
end


radial_sum = radial_result;
% 将计算结果按四个象限平均。
radialProfile1 = mean(radial_sum(1:theta_num_perQ,:));
radialProfile2 = mean(radial_sum((theta_num_perQ+1):2*theta_num_perQ,:));
radialProfile3 = mean(radial_sum((2*theta_num_perQ+1):3*theta_num_perQ,:));
radialProfile4 = mean(radial_sum((3*theta_num_perQ+1):4*theta_num_perQ,:));
% 分别计算X Y 方向的相关曲线，及其下标
radial_left = radialProfile2+radialProfile3;
radial_right = radialProfile1+radialProfile4;
radial_x = [flip(radial_left(2:end),2),radial_right];
radial_fx = flip(radial_x,2);
corr_X = xcorr(radial_x,radial_fx);

radial_up = radialProfile1+radialProfile2;
radial_down = radialProfile3+radialProfile4;
radial_y = [flip(radial_up(2:end),2),radial_down];
radial_fy = flip(radial_y,2);
corr_Y = xcorr(radial_y,radial_fy);
% 下标换算
size_radial = size(radial_x,2);
r_index = -(size_radial-1):(size_radial-1);
% 寻找相关曲线最高点，拟合计算偏移量


end
