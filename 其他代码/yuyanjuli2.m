% ���ű����ڸ���������֮������ƶȺ󣬼����ʡ��֮������Ծ���

%% ���ȸ�����������������֮�����ľ���
xiangsidu = [];
data = cell(10,6);
% �����ƶ�����ճ�����������ɵľ���xiangsidu�
%�ٽ������������������data �ע���Ҽ�ѡ��paste excel data
% ���湹�����ƶȾ����Ա�ʾ�����������������������Ƴ̶ȡ�
fyq_num = 12;   % �����������������޸�
xsdu_p2p = zeros(fyq_num); % ����������������ƶȾ���
k=1;
for i= 2:fyq_num
    for j = 1:(i-1)
        xsdu_p2p(i,j) = xiangsidu(k);
        xsdu_p2p(j,i) = xiangsidu(k);
        xsdu_p2p(j,j) = 1;
        k = k+1;
    end
    xsdu_p2p(fyq_num,fyq_num) = 1;
end
% 
% data = cell(10,6);
    
N = size(data,1);
% d ��������������Ƭ��Ӧ�����������ƶȾ���
d = zeros(N);

fyq = data(:,4);
% ���շ�������id ��xsdu_p2p�����������Ӧ�����ƶȣ�����d�С�
fyqid = cell2mat(data(:,8));
for i = 1:582
    for j = 1:582
        d(i,j) = xsdu_p2p(fyqid(i),fyqid(j));
    end
end


%% ������м����

%��unique ����ɾ���ظ����ȷ��������
cityindex = cell2mat(data(:,1));
cityNO = unique(cityindex,'rows');
city_num = size(cityNO,1);
pro_distance = zeros(city_num);
% Ȼ������������У�����������ĵ�����
for a = 1:city_num
    for b = a:city_num
        fy_a = find(cityindex==cityNO(a));  % ����a ���ļ�Ƭ
        fy_b = find(cityindex==cityNO(b));  %����b ���ļ�Ƭ
        
        rkb_p = cell2mat(data(fy_a,6));    %a ���Ǽ�Ƭ���˿ڱ���
        rkb_q = cell2mat(data(fy_b,6));    %b ���Ǽ�Ƭ���˿ڱ���
        dpq = d(fy_a,fy_b);                %ab�Ǽ�Ƭ��Ӧ���������ƶ�
      pro_distance(a,b) = 1-rkb_p'*dpq*rkb_q;  
    end
end