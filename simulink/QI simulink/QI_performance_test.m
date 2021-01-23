% 本脚本用于进行象限插值法的压力测试


 time = zeros(10,1);
 cycle = 1:100;
for p = cycle
image_name = 'bias1.tif';% 图像名
            image =  imread(strcat('C:\analysis-code\simulink\QI simulink\img_extract\',image_name));%读入一张图像
%             [cenX,cenY] = cu_cenroid(image,1);
%             imshow(image);
%             hold on
%             plot(cenX,cenY,'Marker','.','MarkerSize',8);
            % 我们认为将Image 的数量推上去，比如一次处理五十张。
            image_more = zeros(size(image,1),size(image,2),50);
            for k = 1:50
                image_more(:,:,k) = image;
            end
            
            % 用改进的算法再测试一次
            [cenX2,cenY2] = cu_cenroid_modi(image_more,50);
%             plot(cenX2,cenY2,'Marker','.','MarkerSize',8);
            % 接下来用QI算法开始计算真正的中心
            % 首先根据参数计算好极坐标的值
            xc = cenX2;
            yc = cenY2;
            tic
            for i =1:3  % 注意，这里是迭代次数，也就是说，并不存在并行的优势   
            [cenX3,cenY3] = radial_profile(image_more,xc,yc,0.4,4);
%             plot(cenX3(i),cenY3(i),'Marker','.','MarkerSize',8);
            xc = cenX3;
            yc = cenY3;
            end
            time(p) = toc;
end
figure;
            plot(cycle,time);

