% pro,fydq,fyq,fyp,rkb,d(i,j).
% data = cell(10,6);
%  unnamed = cell(10,6);
% data = unnamed;
N = size(data,1);
d = zeros(N);
fydq = data(:,3);
fyq = data(:,4);
fyp = data(:,5);

for i = 1:N
    for j = 1:N
        if strcmp(fydq{i},fydq{j})
            if strcmp(fyq{i},fyq{j})
                if (strcmp(fyp{i},'空白片')||strcmp(fyp{i},'空白片'))||(strcmp(fyp{i},fyp{j}))
                    d(i,j)=0;
                else d(i,j)=1;
                end
            else   d(i,j)=2;
            end
        else d(i,j)=3;
        end
    end
end

% 计算省间距离
%共有359个省市，从1到359建立编号；
city_num = 359;
city_list = data(:,1);
city_list = cell2mat(city_list);

pro_distance = zeros(city_num);
% 然后对这两个省，检索其包含的地区；
for p = 1:city_num
    for q = p:city_num
        fy_p = find(city_list==p);
        fy_q = find(city_list==q);
        rkb_p = cell2mat(data(fy_p,6));
        rkb_q = cell2mat(data(fy_q,6));
        dpq = d(fy_p,fy_q);
      pro_distance(p,q) = rkb_p'*dpq*rkb_q;  
    end
end
yuyan_city_array = zeros(nchoosek(city_num,2)+city_num,3);
k = 1;
for j = 1:city_num
    for i = 1:j
        yuyan_city_array(k,1) = i;
        yuyan_city_array(k,2) = j;
        yuyan_city_array(k,3) = pro_distance(i,j);
        k=k+1;
    end
end

