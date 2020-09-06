File=dir('E:\analysis code\simulink\QI simulink\*.tif'); %��ȡ��·���µ�ȫ��bmpͼƬ
img_num = length(File);%��ȡͼ��������
n=0;
cenX = zeros(img_num,1);
cenY = zeros(img_num,1);
cenX3 = zeros(10,1);
cenY3 = zeros(10,1);
if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            image_name = File(j).name;% ͼ����
            image =  imread(strcat('E:\analysis code\simulink\QI simulink\',image_name));%����һ��ͼ��
            [cenX,cenY] = cu_cenroid(image,1);
            imshow(image);
            hold on
            plot(cenX,cenY,'Marker','.','MarkerSize',8);
            % �øĽ����㷨�ٲ���һ��
            [cenX2,cenY2] = cu_cenroid_modi(image,1);
            plot(cenX2,cenY2,'Marker','.','MarkerSize',8);
            % ��������QI�㷨��ʼ��������������
            % ���ȸ��ݲ�������ü������ֵ
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
%             F=getframe(gcf); % ��ȡ�����������ݵ�ͼ��,ʹ�ø��ٵĿ��Ҳ����ͼ��ߣ�F�Ǹ��ṹ����
%             n=n+1;
%             F1=imcrop(F.cdata,[83 31 624 528]);   %��Ҫ������ʾ�����ܱߵİ���
%             image_name_out=sprintf('%d.bmp',n);%��ͼƬ���ƽ��б�������,data to string
%             imwrite(F1,strcat('D:\analysis code\simulink\QI simulink',image_name_out));%����д��ͼƬ
        end
end


% File=dir('D:\analysis code\simulink\QI simulink\*.tif'); %��ȡ��·���µ�ȫ��bmpͼƬ
% img_num = length(File);%��ȡͼ��������
% n=0;
% img_array = zeros(80,80,img_num);
% cenX = zeros(img_num,1);
% cenY = zeros(img_num,1);
% if img_num > 0 %������������ͼ��
%         for j = 1:img_num %��һ��ȡͼ��
%             image_name = File(j).name;% ͼ����
%             image =  imread(strcat('D:\analysis code\simulink\QI simulink\',image_name));%����һ��ͼ��
%             img_array(:,:,j)=image;
% 
%             hold off
%             F=getframe(gcf); % ��ȡ�����������ݵ�ͼ��,ʹ�ø��ٵĿ��Ҳ����ͼ��ߣ�F�Ǹ��ṹ����
%             n=n+1;
% 
%         end
% end

