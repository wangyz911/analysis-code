% pro,fydq,fyq,fyp,rkb,d(i,j).
% data = cell(10,6);
load data
N = size(data,1);
d = zeros(N);
fydq = data(:,3);
fyq = data(:,4);
fyp = data(:,5);

for i = 1:N
    for j = 1:N
        if fydq{i}==fydq{j}
            if fyq{i}==fyq{j}
                if (strcmp(fyp{i},'空白片')||strcmp(fyp{i},'空白片'))||(strcmp(fyp{i},fyp{j}))
                    d(i,j)=0;
                else d(i,j)=1;
                end
            else   d(i,j)=10;
            end
        else d(i,j)=100;
        end
    end
end

% 计算省间距离
%共有29个省市，从1到29建立编号；
pro_num = 31;
prolist = data(:,1);
prolist = cell2mat(prolist);

pro_distance = zeros(pro_num);
% 然后对这两个省，检索其包含的地区；
for p = 1:pro_num
    for q = p:pro_num
        fy_p = find(prolist==p);
        fy_q = find(prolist==q);
        rkb_p = cell2mat(data(fy_p,6));
        rkb_q = cell2mat(data(fy_q,6));
        dpq = d(fy_p,fy_q);
      pro_distance(p,q) = rkb_p'*dpq*rkb_q;  
    end
end