% ���ű����ڽ������޲�ֵ����ѹ������


 time = zeros(10,1);
 cycle = 1:100;
for p = cycle
image_name = 'bias1.tif';% ͼ����
            image =  imread(strcat('C:\analysis-code\simulink\QI simulink\img_extract\',image_name));%����һ��ͼ��
%             [cenX,cenY] = cu_cenroid(image,1);
%             imshow(image);
%             hold on
%             plot(cenX,cenY,'Marker','.','MarkerSize',8);
            % ������Ϊ��Image ����������ȥ������һ�δ�����ʮ�š�
            image_more = zeros(size(image,1),size(image,2),50);
            for k = 1:50
                image_more(:,:,k) = image;
            end
            
            % �øĽ����㷨�ٲ���һ��
            [cenX2,cenY2] = cu_cenroid_modi(image_more,50);
%             plot(cenX2,cenY2,'Marker','.','MarkerSize',8);
            % ��������QI�㷨��ʼ��������������
            % ���ȸ��ݲ�������ü������ֵ
            xc = cenX2;
            yc = cenY2;
            tic
            for i =1:3  % ע�⣬�����ǵ���������Ҳ����˵���������ڲ��е�����   
            [cenX3,cenY3] = radial_profile(image_more,xc,yc,0.4,4);
%             plot(cenX3(i),cenY3(i),'Marker','.','MarkerSize',8);
            xc = cenX3;
            yc = cenY3;
            end
            time(p) = toc;
end
figure;
            plot(cycle,time);

