% 本脚本用于给定语言区之间的相似度后，计算各省份之间的语言距离

%% 首先根据数据生成语言区之间距离的矩阵
xiangsidu = [];
data = cell(10,6);
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


% 
% data = cell(10,6);
    
N = size(data,1);
% d 是任意两个方言片对应方言区的相似度距离
d = zeros(N);

fyq = data(:,4);
% 按照方言区的id 在xsdu_p2p矩阵里检索对应的相似度，填入d中。
fyqid = cell2mat(data(:,8));
for i = 1:564
    for j = 1:564
        d(i,j) = xsdu_p2p(fyqid(i),fyqid(j));
    end
end
%564可改

%% 计算城市间距离

%用unique 函数删除重复项，以确定城市数
cityindex = cell2mat(data(:,1));
cityNO = unique(cityindex,'rows');
city_num = size(cityNO,1);
pro_distance = zeros(city_num);
% 然后对这两个城市，检索其包含的地区；
for a = 1:city_num
    for b = a:city_num
        fy_a = find(cityindex==cityNO(a));  % 城市a 有哪几片
        fy_b = find(cityindex==cityNO(b));  %城市b 有哪几片
        
        rkb_p = cell2mat(data(fy_a,6));    %a 的那几片的人口比例
        rkb_q = cell2mat(data(fy_b,6));    %b 的那几片的人口比例
        dpq = d(fy_a,fy_b);                %ab那几片对应的语言相似度
      pro_distance(a,b) = 1-rkb_p'*dpq*rkb_q;  
    end
end