function [ city_a,city_b,distance ] = arc_distance( city_ID,weidu_jingdu )
%本函数用于已知任意点纬度和经度（弧度值），批量计算两点之间的球面距离
%   设置结果矩阵，大小和点个数一致。
d_size = size(weidu_jingdu,1);
distance = zeros(d_size);
city_a = zeros(d_size);
city_b = zeros(d_size);
weidu = weidu_jingdu(:,1);
jingdu = weidu_jingdu(:,2);
%一些固定参数
R = 6371.004;  %地球半径，单位为km
for m = 1:d_size
    for n = m:d_size

       xian_length = sqrt( ...
            ( sin( weidu(m) )-sin( weidu(n) ) )^2 ...
          +( cos( weidu(m) )-cos( weidu(n) )*cos( jingdu(m)-jingdu(n) ) )^2 ...
          +(cos( weidu(n) )*sin( jingdu(m)-jingdu(n) ) )^2 ...
       );
   city_a (m,n)=city_ID(m);
   city_b (m,n)=city_ID(n);
   distance(m,n) = 2*R*asin(xian_length/2);
    end
end
end

