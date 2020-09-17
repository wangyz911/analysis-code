function [radial_result] = QI_polar_1p(xc,yc,r_size,theta_size,r_matrix,theta_matrix,img_array,img_num)
%QI极坐标化部分的并行

radial_result = coder.nullcopy(zeros(theta_size,r_size,img_num));
coder.gpu.kernel();
for k = 1:img_num
    for i = 1:theta_size
        for j = 1:r_size
            x = xc+r_matrix(i,j)*cos(theta_matrix(i,j));
            y = yc+r_matrix(i,j)*sin(theta_matrix(i,j));
            x1=floor(x);
            y1=floor(y);
            x2=x1+1;
            y2=y1+1;
            radial_result(i,j,k) = img_array(x1,y1,k)*(x2-x)*(y2-y)+img_array(x1,y2,k)*(x2-x)*(y-y1)...
                +img_array(x2,y1,k)*(x-x1)*(y2-y)+img_array(x2,y2,k)*(x-x1)*(y-y1);
        end
    end
end

end

