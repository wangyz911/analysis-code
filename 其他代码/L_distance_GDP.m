% 本代码是用于计算GDP加权的地理距离控制变量

% 首先导入各省GDP和语言距离
GDP = unnamed;
language_distance = unnamed1;
prov_num = length(GDP);

% 将上三角或者下三角矩阵填充完整，这样方便计算, 方法是三角矩阵加上它的转置矩阵即可
language_distance = language_distance +language_distance';
% 然后计算 语言距离点除（即对应项相除）GDP的值矩阵,相当于得到了求和多项式里每一个子项
lang_vs_GDP = zeros(size(language_distance));

for i = 1:prov_num
    lang_vs_GDP (:,i)=language_distance(:,i)./GDP;
end
% 全都除好之后，剩下的就是加和了，比如，AB的值等于A 和其他所有语言距离除以GDP的值的总和，减去其中和B的部分。
result = zeros(size(language_distance));
for i = 1:prov_num
    for j = 1:prov_num
        result (j,i) = sum(lang_vs_GDP(:,i))-lang_vs_GDP(j,i);
    end
end
% 对角线是A和A自己的贸易加权，这个值不为0但是没有什么意义（？），这里予以清除，如果有用可以把下面删了
for i = 1:prov_num
    result(i,i)=0;
end

% 预先设置存放结果的矩阵
A_array = zeros(nchoosek(prov_num,2),1);
B_array = zeros(size(A_array));
p = 1;


for i = 2: prov_num
    for j = 1:(i-1)
        A_array(p) = result(i,j);
        B_array(p) = result(j,i);
        p = p+1;
    end
end

    
    
