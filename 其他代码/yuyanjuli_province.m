% 本脚本用来计算省级的语言距离 20190314

%% 首先根据数据生成语言区之间距离的矩阵
xiangsidu = [];
data = zeros(1);

% 将相似度数据粘贴到上面生成的矩阵xiangsidu里；
%再将城市相关数据张贴到data 里，注意右键选择，paste excel data
% 下面构建相似度矩阵，以表示任意两个方言区的语言相似程度。
fyq_num = 15;   % 方言区数量，可以修改
xsdu_p2p = zeros(fyq_num); % 方言区两两间的相似度矩阵
N = size(xiangsidu,1);
k=1;
%按照两两匹配关系填入相似度，中央填1
for i= 1:N
    xsdu_p2p(xiangsidu(i,1),xiangsidu(i,2)) = xiangsidu(i,3);
    xsdu_p2p(xiangsidu(i,2),xiangsidu(i,1)) = xiangsidu(i,3);
    k = k+1;
end
for j = 1:fyq_num
    xsdu_p2p(j,j) = 1;
end

% 统计每个省的方言区及其人口比重, 为了和相似度矩阵能够相乘，每个省也分为15个方言区，不存在的方言区比重为0
pro = unique(data(:,1));
pro_yuyan_arrays = zeros(size(pro,1),15);
for i = 1:size(pro,1)
    range = find(data(:,1)==pro(i));
    fyq_inpro = unique(data(range,2));
    for j = 1:size(fyq_inpro,1)
        data_inpro = data(range,:);
        fyq_range = find(data_inpro(:,2)==fyq_inpro(j));
        pro_sum = sum(data_inpro(:,3));
        pro_yuyan_arrays(i,fyq_inpro(j)) = sum(data_inpro(fyq_range,3))/pro_sum;
    end
end
% 计算每个省之间的语言距离
yuyanjuli_pro = zeros(size(pro,1));
for i = 1:size(pro,1)
    for j =i:size(pro,1)
        yuyanjuli_pro(i,j) = 1-pro_yuyan_arrays(i,:)*xsdu_p2p*pro_yuyan_arrays(j,:)';
    end
end

% 排成三列
yuyan_pro_array = zeros(nchoosek(size(pro,1),2)+size(pro,1),3);
k = 1;
for j = 1:size(pro,1)
    for i = 1:j
        yuyan_pro_array(k,1) = pro(i);
        yuyan_pro_array(k,2) = pro(j);
        yuyan_pro_array(k,3) = yuyanjuli_pro(i,j);
        k=k+1;
    end
end



