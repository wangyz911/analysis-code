% ���ű����ڽ�����ʡ�����������ݴ���ɻ���Ƶ��VS ʡ�ݵ���ʽ�����ڽ��л������ļ��㡣
%% ������ȷ�ж��ٸ�ʡ�ݣ����ٸ����ϣ�����Ԫ������
% data_prov = cell(257,1);
% data_name = cell(484,1);
% data = cell(7975,3);
load data2;

%% �������ɻ���Ƶ�ʵĽ���������������ϣ����򣩣�������ʡ��
gene_by_name = zeros(size(data_name,1),size(data_prov,1));
%��ʼѭ��ǰȷ���ж������ϣ�����ʡ�ݣ������Դ���ݽ��иĶ���ѭ����������
name_number = size(data_name,1);
prov_number = size(data_prov,1);
% ��ʼ������������i=1���ӵ�һ����ʼ����
i = 1;
%% ��ʼѭ������
% �ȼ���ʡ�ݣ��Ե�p��ʡ�ݶ��ԡ���
for p = 1:prov_number
% ����Ѱ��data�е�ʡ�ݣ�ֱ����i�������е�ʡ�ݣ��ڶ��У���pʡ����ͬ
    while (strcmp(data{i,2},data_prov{p}))
        %�����ҵ���data�е�pʡ�����ݣ�����һ�����ݵ�������������������в��ң����ǵڼ���
        for n = 1:name_number
            if strcmp(data{i,1}, data_name{n})
                %�ҵ���ʡ��p������n���ڻ�������е�n�е�p��д��������Ҳ����data ������
                gene_by_name(n,p) = data{i,3};
                break;
            end
        end
        %��i�����ݲ��ң���λ��д��������ɣ�i+1����ʼ������һ�����ݣ��������i�ﵽ���ֵ����break ��ֹѭ��
        if i <size(data,1)
            i=i+1;
        else
            break;
        end
    end
end
%% �õ����� VSʡ�ݵ������󣬿��Դ��Ը�ʡ������������ת���Ƶ��
% ���㣬ÿʡ�Ӻ�����Ӧ�õ��ڸ�ʡ�����������Զ���
prov_sum = sum(gene_by_name);
% ��һ����׼��һ���Ž���ľ���Ȼ���ÿһ�е����ݣ�������һ�еļӺͣ�һ�м�����һʡ
gene_by_name_nor = gene_by_name;
for p = 1: prov_number
gene_by_name_nor(:,p) = gene_by_name(:,p)./prov_sum(p);
end
% ���㣬ÿʡ�Ӻ����ڵ���1
sum(gene_by_name_nor);



