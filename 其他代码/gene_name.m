% 本脚本用于将海量省份与姓氏数据处理成基因频率VS 省份的形式，用于进行基因距离的计算。
%% 首先明确有多少个省份，多少个姓氏，导入元胞矩阵。
% data_prov = cell(257,1);
% data_name = cell(484,1);
% data = cell(7975,3);
load data2;

%% 构造容纳基因频率的结果矩阵，竖排是姓氏（基因），横排是省份
gene_by_name = zeros(size(data_name,1),size(data_prov,1));
%开始循环前确认有多少姓氏，多少省份，避免对源数据进行改动后循环次数出错
name_number = size(data_name,1);
prov_number = size(data_prov,1);
% 初始化检索索引，i=1即从第一个开始检索
i = 1;
%% 开始循环查找
% 先检索省份，对第p个省份而言……
for p = 1:prov_number
% 不断寻找data中的省份，直到第i个数据中的省份（第二列）和p省份相同
    while (strcmp(data{i,2},data_prov{p}))
        %我们找到了data中的p省份数据，把这一行数据的姓氏提出来，在姓氏中查找，看是第几个
        for n = 1:name_number
            if strcmp(data{i,1}, data_name{n})
                %找到了省份p的姓氏n后，在基因矩阵中第n行第p列写入人数，也就是data 第三列
                gene_by_name(n,p) = data{i,3};
                break;
            end
        end
        %第i个数据查找，定位，写入数据完成，i+1，开始查找下一个数据，如果数据i达到最大值，用break 终止循环
        if i <size(data,1)
            i=i+1;
        else
            break;
        end
    end
end
%% 得到姓氏 VS省份的人数后，可以处以各省人数，将人数转变成频率
% 验算，每省加和现在应该等于各省总人数，可以对照
prov_sum = sum(gene_by_name);
% 归一化，准备一个放结果的矩阵，然后对每一列的数据，除以这一列的加和，一列即代表一省
gene_by_name_nor = gene_by_name;
for p = 1: prov_number
gene_by_name_nor(:,p) = gene_by_name(:,p)./prov_sum(p);
end
% 验算，每省加和现在等于1
sum(gene_by_name_nor);



