function [radial_result] = QI_polar_1(xc,yc,r_size,theta_size,r_matrix,theta_matrix,img_array,img_num)
%QI极坐标化部分的并行
radial_result = zeros(theta_size,r_size,img_num);
x = zeros(theta_size,r_size);
y = zeros(theta_size,r_size);
for k = 1:img_num
    for i = 1:theta_size
        for j = 1:r_size
            x(i,j) = xc(k)+r_matrix(i,j)*cos(theta_matrix(i,j));
            y(i,j) = yc(k)+r_matrix(i,j)*sin(theta_matrix(i,j));
            x1=floor(x(i,j));
            y1=floor(y(i,j));
            x2=x1+1;
            y2=y1+1;
            radial_result(i,j,k) = img_array(x1,y1,k).*(x2-x(i,j))*(y2-y(i,j))+img_array(x1,y2,k).*(x2-x(i,j))*(y(i,j)-y1)+img_array(x2,y1,k).*(x(i,j)-x1)*(y2-y(i,j))+img_array(x2,y2,k).*(x(i,j)-x1)*(y(i,j)-y1);
        end
    end
end

end

