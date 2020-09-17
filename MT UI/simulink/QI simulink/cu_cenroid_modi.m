function [cenX,cenY] = cu_cenroid_modi(img_array,img_num)
% 本函数用于计算若干张图像数据的质心位置，图像有先后顺序但无逻辑顺序。
% 本函数对图心的寻找进行了改进，主要是消除背景噪声。
% 输入来的是N张图拼接起来的长图矩阵。
% 本函数是labview 并行计划的第一环
% 本函数必须假设图像矩阵是长宽一致的。

% 第一步，确定图像总矩阵大小，img_array 是一个三维矩阵，
img_array = im2double(img_array);
 ROI_size = size(img_array,2);
 % 创建两个矩阵保存结果
 mass_array_x = zeros(ROI_size);
 mass_array_y = zeros(ROI_size);
 cenX = zeros(img_num,1);
 cenY = zeros(img_num,1);
 % 第二步，划分成若干图像
 for i = 1:img_num
     img = img_array(:,:,i);
     img_bk = mean(mean(img));
     img_modi= abs(img-img_bk);
     mass = sum(sum(img_modi));
     % 质心坐标的计算规则实质上影响了后面所有的坐标系规则
     for j = 1:ROI_size
         for k  = 1:ROI_size
             mass_array_x(j,k) = img_modi(j,k)* k;
             mass_array_y(j,k) = img_modi(j,k)* j;
         end 
     end
     cenX(i) = sum(sum(mass_array_x))/mass;
     cenY(i) = sum(sum(mass_array_y))/mass;
     
end


