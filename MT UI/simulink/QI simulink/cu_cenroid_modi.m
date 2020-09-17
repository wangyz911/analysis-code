function [cenX,cenY] = cu_cenroid_modi(img_array,img_num)
% ���������ڼ���������ͼ�����ݵ�����λ�ã�ͼ�����Ⱥ�˳�����߼�˳��
% ��������ͼ�ĵ�Ѱ�ҽ����˸Ľ�����Ҫ����������������
% ����������N��ͼƴ�������ĳ�ͼ����
% ��������labview ���мƻ��ĵ�һ��
% �������������ͼ������ǳ���һ�µġ�

% ��һ����ȷ��ͼ���ܾ����С��img_array ��һ����ά����
img_array = im2double(img_array);
 ROI_size = size(img_array,2);
 % �����������󱣴���
 mass_array_x = zeros(ROI_size);
 mass_array_y = zeros(ROI_size);
 cenX = zeros(img_num,1);
 cenY = zeros(img_num,1);
 % �ڶ��������ֳ�����ͼ��
 for i = 1:img_num
     img = img_array(:,:,i);
     img_bk = mean(mean(img));
     img_modi= abs(img-img_bk);
     mass = sum(sum(img_modi));
     % ��������ļ������ʵ����Ӱ���˺������е�����ϵ����
     for j = 1:ROI_size
         for k  = 1:ROI_size
             mass_array_x(j,k) = img_modi(j,k)* k;
             mass_array_y(j,k) = img_modi(j,k)* j;
         end 
     end
     cenX(i) = sum(sum(mass_array_x))/mass;
     cenY(i) = sum(sum(mass_array_y))/mass;
     
end


