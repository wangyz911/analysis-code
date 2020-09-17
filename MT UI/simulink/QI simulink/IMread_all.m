File=dir('E:\analysis code\simulink\QI simulink\*.tif'); %读取该路径下的全部bmp图片
img_num = length(File);%获取图像总数量
n=0;
cenX = zeros(img_num,1);
cenY = zeros(img_num,1);
cenX3 = zeros(10,1);
cenY3 = zeros(10,1);
if img_num > 0 %有满足条件的图像
        for j = 1:img_num %逐一读取图像
            image_name = File(j).name;% 图像名
            image =  imread(strcat('E:\analysis code\simulink\QI simulink\',image_name));%读入一张图像
            [cenX,cenY] = cu_cenroid(image,1);
            imshow(image);
            hold on
            plot(cenX,cenY,'Marker','.','MarkerSize',8);
            % 用改进的算法再测试一次
            [cenX2,cenY2] = cu_cenroid_modi(image,1);
            plot(cenX2,cenY2,'Marker','.','MarkerSize',8);
            % 接下来用QI算法开始计算真正的中心
            % 首先根据参数计算好极坐标的值
            xc = cenX2;
            yc = cenY2;
            tic
            for i =1:100    
            [cenX3,cenY3] = radial_profile(image,xc,yc,0.4,8);
%             plot(cenX3(i),cenY3(i),'Marker','.','MarkerSize',8);
            xc = cenX3(i);
            yc = cenY3(i);
            end
            toc

            hold off
%             F=getframe(gcf); % 获取整个窗口内容的图像,使得跟踪的框框也进入图里边，F是个结构体了
%             n=n+1;
%             F1=imcrop(F.cdata,[83 31 624 528]);   %需要减掉显示窗口周边的白晕
%             image_name_out=sprintf('%d.bmp',n);%给图片名称进行变量定义,data to string
%             imwrite(F1,strcat('D:\analysis code\simulink\QI simulink',image_name_out));%批量写入图片
        end
end


% File=dir('D:\analysis code\simulink\QI simulink\*.tif'); %读取该路径下的全部bmp图片
% img_num = length(File);%获取图像总数量
% n=0;
% img_array = zeros(80,80,img_num);
% cenX = zeros(img_num,1);
% cenY = zeros(img_num,1);
% if img_num > 0 %有满足条件的图像
%         for j = 1:img_num %逐一读取图像
%             image_name = File(j).name;% 图像名
%             image =  imread(strcat('D:\analysis code\simulink\QI simulink\',image_name));%读入一张图像
%             img_array(:,:,j)=image;
% 
%             hold off
%             F=getframe(gcf); % 获取整个窗口内容的图像,使得跟踪的框框也进入图里边，F是个结构体了
%             n=n+1;
% 
%         end
% end

