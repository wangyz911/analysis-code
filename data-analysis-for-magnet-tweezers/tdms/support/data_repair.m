function [data_repair] = data_repair(data_ramp,fit_func)
%�����������޸�һЩ���߲�����������ɵ�Ư��
N = size(data_ramp,1);
t = (1:N);
t = t';
% disp('�Ƿ��޸� force ramp ���ߣ�')
% yes_ramp = input('�ǻ��߷�','s');
% if yes_ramp == '1'
%�����������ݲ���ͼ��ʾ��ѯ���Ƿ�Ҫ�����޸�

    if fit_func==3
    % ʹ���ݺ���Ҫ��ʹ���������Ҫ���������ƣ���ƽ�������Һ����Ե�ʱ��Ҳ������Ȼ�������ȶ������������٣�����ϡ�
    % �ݺ����ڽӽ�0��˥���ĺ����������������ƶ���㸽����״̬
%     f = @(c,x)c(1)*x.^(1/c(2))+c(3);
%     c0=[1,6,0];
    f = @(c,x)c(1)*x+c(2);
    c0=[1,0];
    data_sm = smooth(data_ramp,400);% ƽ���ĵ�Խ��Ч��Խ�ã�����Ӱ������ԭ���Ĳ���,��������λ����1000��ʱ���бȽ����Ե���βЧӦ��
    elseif fit_func==1
    f = @(c,x)c(1)*x+c(2);
    c0=[1,0];
    data_sm = smooth(data_ramp,2000);% ƽ���ĵ�Խ��Ч��Խ�ã�����Ӱ������ԭ���Ĳ���,��������λ����1000��ʱ���бȽ����Ե���βЧӦ��
    elseif fit_func==5
    f = @(c,x)c(1)*x+c(2);
    c0=[1,0];
    data_sm = smooth(data_ramp,200);% ƽ���ĵ�Խ��Ч��Խ�ã�����Ӱ������ԭ���Ĳ���,��������λ����1000��ʱ���бȽ����Ե���βЧӦ��
    elseif fit_func ==2
           f = @(c,x)c(1)*x+c(2);
           c0=[1,0];
           data_sm = wdenoise(data_ramp,6, ...
    'Wavelet', 'sym4', ...
    'DenoisingMethod', 'BlockJS', ...
    'ThresholdRule', 'James-Stein', ...
    'NoiseEstimate', 'LevelIndependent');% ƽ���ĵ�Խ��Ч��Խ�ã�����Ӱ������ԭ���Ĳ���,��������λ����1000��ʱ���бȽ����Ե���βЧӦ��

    end





figure;
plot(t,data_ramp*1000,'MarkerSize',4,'Marker','.',...
    'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
hold on
% data_sm = smooth(data_ramp,2000);% ƽ���ĵ�Խ��Ч��Խ�ã�����Ӱ������ԭ���Ĳ���,��������λ����1000��ʱ���бȽ����Ե���βЧӦ��
plot(t,data_sm*1000,'LineWidth',2,'Color',[1 0 0]);
xlabel('Time/s)');ylabel('Ext./nm');

input('���������ʼѡ���׼����','s');
    
    [base_start,~]=ginput(1);
    base_start=floor(base_start);
    if base_start<1
        base_start=1;
    end
    
    [base_end,~]=ginput(1);                                          %���ȡ�����öϵ�  ��
    base_end=floor(base_end);                                          %����ȡ��
    if base_end > N
        base_end = N;
    end

    x = t(base_start:base_end);
    y = data_sm(base_start:base_end);
    

        base_fit=nlinfit(x,y,f,c0);
    % ���ڻ��߼����޸�ֵ��
    input('���������ʼѡ���޸�����','s');
    
        [rep_start,~]=ginput(1);
    rep_start=floor(rep_start);
    if rep_start<1
        rep_start=1;
    end
    
    [rep_end,~]=ginput(1);                                          %���ȡ�����öϵ�  ��
    rep_end=floor(rep_end);                                          %����ȡ��
    if rep_end > N
        rep_end = N;
    end
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% if fit_func==3
% %     base_rep = base_fit(1).*(t(rep_start:rep_end)).^(1/base_fit(2))+base_fit(3);
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% elseif fit_func==1
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% elseif fit_func ==2
%     base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
% end

    base_rep = base_fit(1).*t(rep_start:rep_end)+base_fit(2);
    data_ramp(rep_start:rep_end) = data_ramp(rep_start:rep_end)-data_sm(rep_start:rep_end)+base_rep;
   %���޸�����ǰ����롣�������Ʒǳ��������֮��

   dif_start = base_rep(1)-data_sm(rep_start);
   dif_end = base_rep(end)-data_sm(rep_end);
   data_ramp(1:(rep_start-1)) = data_ramp(1:(rep_start-1))+dif_start;
   data_ramp((rep_end+1):end) = data_ramp((rep_end+1):end)+dif_end;
% end

data_repair = data_ramp;
% figure;
% plot(t,data_repair);
end

