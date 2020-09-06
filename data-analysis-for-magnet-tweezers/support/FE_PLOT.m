
% ��ͼ����
% shift = 112.5 - max(ext_curve);

figure;

ext_curve = ext_curve - min(ext_curve);
% ext_curve_c = ext_curve*0.8/0.88/1000;
offset = max(ext_curve);
ext_curve = ext_curve-max(ext_curve)+offset;

% ���� butterworth �˲�, ��û������Ŀ���Ū�ÿ��㣬�������Ū���ˡ�
Fs = 200;
Wc=2*50/Fs;                                          %��ֹƵ�� 30Hz
[b,a]=butter(2,Wc);
ext_but=filter(b,a,ext_curve);

ext_mean = smooth(ext_curve,5);
ext_med = medfilt1(ext_curve,3);

[done] = change_plot_style();
k = 1;
close all;
%%  ���師��ͼ��
% offset =40;
% ext_curve = ext_curve+offset;
hold on
if (k==1)
    h1=plot(force_curve,ext_curve,'DisplayName','1st',...
        'MarkerFaceColor',[0.074509803921569 0.623529411764706 1],...
        'Marker','o',...
        'LineWidth',1);
elseif (k==2)
    h2=plot(force_curve,ext_curve,'DisplayName','2nd','MarkerFaceColor',[1 0 0],'Marker','o',...
    'LineWidth',1);
elseif k==3
    h3=plot(force_curve,ext_curve,'DisplayName','3rd','MarkerFaceColor',[1 1 0.066666666666667],...
        'Marker','o',...
        'LineWidth',1);

% ���� textbox
% figure1 = gcf;
% annotation(figure1,'textbox',...
%     [0.642555285540705 0.588235295381494 0.111178611872553 0.0560875500357428],...
%     'String',{'22nm'},...
%     'LineStyle','none',...
%     'FontSize',18);

elseif k==4
    h4=plot(force_curve,ext_curve,'DisplayName','4th',...
    'MarkerFaceColor',[0.392156862745098 0.831372549019608 0.074509803921569],...
    'Marker','o',...
    'LineWidth',1,...
    'Color',[0.470588235294118 0.670588235294118 0.188235294117647]);
elseif k==5
    h5=plot(force_curve,ext_curve,'DisplayName','5th',...
    'MarkerFaceColor',[1 0 1],...
    'Marker','o',...
    'LineWidth',1,...
    'Color',[0.717647058823529 0.274509803921569 1]);
elseif k==6
    h6=plot(force_curve,ext_curve,'DisplayName','6th',...
   'MarkerFaceColor',[0 1 1],...
   'Marker','o',...
   'LineWidth',1,...
   'Color',[0.301960784313725 0.749019607843137 0.929411764705882]);
end
k = k+1;
axes1 = gca;
hold(axes1,'on');
box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
% plot(ext_curve_m,force_curve,'LineWidth',1,'Marker','o','MarkerSize',4);
xlabel('Force/pN');
ylabel('Ext./nm');
% ��������ĳ�������ߵ����¹�ϵ
% set(gca,'child',[h1 h2,h3,h4]);
% ���� legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.194319881955426 0.766175817600162 0.0986547072839844 0.115127172136562]);

deal_number = 1;
%% FE-align �Ѷ��FEͼ�е����ݳ�������룬��������ߵ��ֵ����ƽ�ƣ����յõ��߶�ͳһ�Ķ�F-E��άͼ������ͼ����ɫ��marker��С����
close all;
%  offset = 50;
 [file_name,~]=uigetfile({'*.fig'},'Select your fig file');
         disp(file_name);
        op_name = strcat('./',file_name);
        open(op_name);
 figure_info=findall(gcf,'type','line');    
xdata1 = get(figure_info,'xdata');   
ydata1 = get(figure_info,'ydata');  
color = get(figure_info,'color');
marker = get(figure_info,'Marker');
mk_size = get(figure_info,'MarkerSize');
DisplayName = get(figure_info,'DisplayName');
MarkerFaceColor = get(figure_info,'MarkerFaceColor');
LineWidth = get(figure_info,'LineWidth');

subNum1 = length(xdata1);  
% ѡ��һ����׼��x����ȡÿ���������x��ĵ��yֵ����Ϊ����һ����Χ�����Բ鵽һ�����ڲ鵽���У�
yes = input('�밴1ѡ�����Ļ�׼������','s');
if yes=='1'
[base_point_x,~] = ginput(1);
% x_ind = xdata1{1};
% [~,x_near] = min(abs(x_ind-base_point_x));

base_y = zeros(subNum1,1);
r_offset_y = zeros(subNum1,1);
top_y = 0;

top_id = 0;
for i=1:subNum1
x_ind = xdata1{i};
[~,x_near] = min(abs(x_ind-base_point_x));
    y_tmp = ydata1{i};
    base_y(i) = y_tmp(x_near);
    k = length(y_tmp);
    y_t_offset = y_tmp(k);
    while (isnan(y_tmp(k)))
        k = k-1;
        y_t_offset = y_tmp(k);
    end
        
    if (y_t_offset>top_y)
    top_y = y_tmp(k);
    top_id = i;
    end
    r_offset_y(i) = base_y(i)-base_y(1);
end
% ��Ҫ����һ��
t_offset = 140-top_y+r_offset_y(top_id);

end
k = 1;
figure;
for i=subNum1:-1:1   
    if length(xdata1{i})==1   
        break;   
    end
%     if k ==1
        plot(xdata1{i},ydata1{i}-r_offset_y(i)+t_offset,'DisplayName',DisplayName{i},'MarkerSize',mk_size{i},'Marker',marker{i},...
        'MarkerFaceColor',MarkerFaceColor{i} ,'Color',color{i},'LineWidth',LineWidth{i});
%     else
%         plot(xdata1{i},ydata1{i}+offset,'LineWidth',2,'Color',[1 0 0]);
%     end
    k = k+1;
    hold on;   
end 
    xlabel('Force/pN');ylabel('Ext./nm');
    hold off
    
            [~] = change_plot_style();
        % ���ȱ���ͼƬ��tif ��ʽ
        name_save=strtok(file_name,'.');
        fig_name = strcat(name_save,'_ali_shif.fig');
        saveas(gcf,fig_name);        


%% �����������Ϣ������graphpad�ĸ�ʽ
axes1 = gca;

% ��������̶��ⷭ
set(axes1,'TickDir','out');
% �ڿ���ʽ���color����Ϊ��ɫ������������ɫ
% title("Unfolding Curve of Canonical Nucleosome");
% xlabel("Dwell time/s");
% ylabel("Density");\
ylabel("Count");
xlabel("Ext./nm");
title("H2AZ+H1");
% ������������������
set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);

[done] = change_plot_style();


% % ����ͼƬ����͸��
% % you created a figure and it is "current". % the following, you could have guessed
% set(gcf,'color','none');
% set(gca,'color','none');
% % but this following little detail took me ages to figure out
% set(gcf,'InvertHardCopy','off');
% % ��������������������������������
% % ��Ȩ����������ΪCSDN������neweroica����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% % ԭ�����ӣ�https://blog.csdn.net/neweroica/article/details/1672988
%% ��figͼ�е����ݳ����������һ����ƽ�Ƶõ���ʵ�Ĵ���߶ȣ��ٱ����ԭͼ
close all;
 offset = 80;
 [file_name,filefolder]=uigetfile({'*.fig'},'Select your fig file');
         disp(file_name);
        op_name = strcat('./',file_name);
        open(op_name);
 figure_info=findall(gcf,'type','line');    
xdata1 = get(figure_info,'xdata');   
ydata1 = get(figure_info,'ydata');   
% color1 = get(figure_info,'color');   
subNum1 = length(xdata1);  
k = 1;
figure;
for i=subNum1:-1:1   
    if length(xdata1{i})==1   
        break;   
    end
    if k ==1
        plot(xdata1{i},ydata1{i}+offset,'MarkerSize',4,'Marker','.',...
        'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);
    else
        plot(xdata1{i},ydata1{i}+offset,'LineWidth',2,'Color',[1 0 0]);
    end
    k = k+1;
    hold on;   
end 
    xlabel('Time/min');ylabel('Ext./nm');
    hold off
    
            [~] = change_plot_style();
        % ���ȱ���ͼƬ��tif ��ʽ
        name_save=strtok(file_name,'.');
        fig_name = strcat(name_save,'_modi.fig');
        saveas(gcf,fig_name);
        
%% �Ѷ��FEͼ�е����ݳ����������һ����ƽ�Ƶõ���ʵ�Ĵ���߶ȣ��ٱ����ԭͼ������ͼ����ɫ��marker��С����
close all;
 offset = 50;
 [file_name,filefolder]=uigetfile({'*.fig'},'Select your fig file');
         disp(file_name);
        op_name = strcat('./',file_name);
        open(op_name);
 figure_info=findall(gcf,'type','line');    
xdata1 = get(figure_info,'xdata');   
ydata1 = get(figure_info,'ydata');  
color = get(figure_info,'color');
marker = get(figure_info,'Marker');
mk_size = get(figure_info,'MarkerSize');
DisplayName = get(figure_info,'DisplayName');
MarkerFaceColor = get(figure_info,'MarkerFaceColor');
LineWidth = get(figure_info,'LineWidth');
% color1 = get(figure_info,'color');   
subNum1 = length(xdata1);  
k = 1;
figure;
for i=subNum1:-1:1   
    if length(xdata1{i})==1   
        break;   
    end
%     if k ==1
        plot(xdata1{i},ydata1{i}+offset,'DisplayName',DisplayName{i},'MarkerSize',mk_size{i},'Marker',marker{i},...
        'MarkerFaceColor',MarkerFaceColor{i} ,'Color',color{i},'LineWidth',LineWidth{i});
%     else
%         plot(xdata1{i},ydata1{i}+offset,'LineWidth',2,'Color',[1 0 0]);
%     end
    k = k+1;
    hold on;   
end 
    xlabel('Force/pN');ylabel('Ext./nm');
    hold off
    
            [~] = change_plot_style();
        % ���ȱ���ͼƬ��tif ��ʽ
        name_save=strtok(file_name,'.');
        fig_name = strcat(name_save,'_modi.fig');
        saveas(gcf,fig_name);
        

%% merge figure �Ѷ���fig ͼ����һ��
%�����棬���Զ������ţ��Զ���ͼ������color����

clc;clear;   
i =0;
keep = 1;
while(keep)
    disp("��Ҫ������ȡͼ���� ��-1����-0");
    keep = str2double(input('����1��ȡͼ��','s'));
    if keep
        i =i+1;
        [file_name,filefolder]=uigetfile({'*.fig'},'Select your fig file');
        disp(file_name);
        op_name = strcat('./',file_name);
        open(op_name);
        x = strcat('x_data_',num2str(i));
        y = strcat('y_data_',num2str(i));
        color = strcat('color_',num2str(i));
        subNum = strcat('subNum_',num2str(i));
        na = strcat('n',num2str(i));
        
        figure_info=findall(gcf,'type','line');

        eval([x '= get(figure_info,''xdata''' ');']);
        eval([y  '= get(figure_info,''ydata''' ');']);
        eval([color '= get(figure_info,''color'');']);
        eval([subNum '= length(eval(x));']);
        eval([na '=file_name']);

    end
    close;
end
figure;

for k = 1:i
    ax = strcat('axes',num2str(k));
    eval([ax '=subplot(i,1,k);']);
%     subplot(i,1,k)   
        x = strcat('x_data_',num2str(k));
        y = strcat('y_data_',num2str(k));
        color = strcat('color_',num2str(k));
        subNum = strcat('subNum_',num2str(k));
        na = strcat('n',num2str(k));

for j=eval(subNum):-1:1   
    if length(eval([x '{j}']))==1   
        break;   
    end   
    plot(eval([x '{j}']),eval([y '{j}']),'.','color',eval([color '{j}']))   
    hold on;   
end   

title(strtok(eval(na),'f')) ;  
% set(gca,'xtick',[]);   
% set(gca,'ytick',[]);  
axes0 = gca;

hold(axes0,'on');
box(axes0,'on');
% ������������������
set(axes0,'TickDir','out');
set(axes0,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
    
end
linkaxes([axes1,axes2,axes3],'xy');
xlabel('Time/s');ylabel('Ext./nm');
deal_number = 1;
%%  �Ѷ���ͼ�񻭳�3D ��


% Ext = ext_curve+17;
% f_seq = force_curve;

% offset =+10;
% ext_curve = ext_curve+offset;

NO_seq = ones(1,size(force_curve,1)) * deal_number;
hold on

if (deal_number==1)
    h1=plot3(force_curve,NO_seq,ext_curve+20,'DisplayName','1st',...
        'MarkerFaceColor',[0.074509803921569 0.623529411764706 1],...
        'Marker','o',...
        'LineWidth',1);

elseif (deal_number==2)
    h2=plot3(force_curve,NO_seq,ext_curve,'DisplayName','2nd','MarkerFaceColor',[1 0 0],'Marker','o',...
    'LineWidth',1);
elseif deal_number==3
    h3=plot3(force_curve,NO_seq,ext_curve,'DisplayName','3rd','MarkerFaceColor',[1 1 0.066666666666667],...
        'Marker','o',...
        'LineWidth',1);
    
% ���� textbox
% figure1 = gcf;
% annotation(figure1,'textbox',...
%     [0.642555285540705 0.588235295381494 0.111178611872553 0.0560875500357428],...
%     'String',{'22nm'},...
%     'LineStyle','none',...
%     'FontSize',18);

elseif deal_number==4
    h4=plot3(force_curve,NO_seq,ext_curve,'DisplayName','4th',...
    'MarkerFaceColor',[0.392156862745098 0.831372549019608 0.074509803921569],...
    'Marker','o',...
    'LineWidth',1,...
    'Color',[0.470588235294118 0.670588235294118 0.188235294117647]);
elseif deal_number==5
    h5=plot3(force_curve,NO_seq,ext_curve,'DisplayName','5th',...
    'MarkerFaceColor',[1 0 1],...
    'Marker','o',...
    'LineWidth',1,...
    'Color',[0.717647058823529 0.274509803921569 1]);
elseif deal_number==6
    h6=plot3(force_curve,NO_seq,ext_curve,'DisplayName','6th',...
   'MarkerFaceColor',[0 1 1],...
   'Marker','o',...
   'LineWidth',1,...
   'Color',[0.301960784313725 0.749019607843137 0.929411764705882]);
end

% plot3(f_seq,NO_seq,Ext,'MarkerFaceColor',[0.074509803921569 0.623529411764706 1],...
%         'Marker','o',...
%         'LineWidth',1,...
%         'Color','k');
hold on
xlabel('Force/pN');
zlabel('Ext./nm');
ylabel('# Ramp cycle.');


% % ���� figure
% figure1 = gcf;

% ���� axes
axes1 = gca;
hold(axes1,'on');
view(axes1,[-17.9059071729958 12.4534682080925]);
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XGrid','on','ZGrid','on');
k = 1;

    deal_number = deal_number+1;
%% �����Զ��޸�ͼƬ��ʽ
% ���� axes
axes1 = gca;
hold(axes1,'on');
% text('\Delta Preference');

box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
% xlabel('Ext.(nm)');
% ylabel('Count');

%% �����ֱ��ͼ�Լ���ʵֵ�Ա�
N = size(data,2);
% data_name = cell(N,1);
% tru_v = zeros(N,1);
seq = [1,2,5,6,9,10,3,4,7,8,11];
k = 1;
for i = 1:3
    for j = 1:4
        if (i*j>N)
            break;
        end
        subplot(3,4,seq(k));
        fig = histogram(data(:,j+(i-1)*4));
        v = tru_v(j+(i-1)*4);
        hold on 
        plot([v,v],[0,500],'r--','Linewidth',2);
        t_string = strcat('\Delta ',data_name{j+(i-1)*4});
        title(t_string);
        ylabel('Frequency');
            k = k+1;
    end

end
hold on 
subplot(3,4,12);
title('')


%% ���ڶ�֮ǰ����ֵ����������
% ������֮ǰPicotwist ������
    A1 = 479.4;
    b1 = -3.947;
    force_curve = force_curve .*(273.15 + 27) /(273.15 + 31.5);
    zmag = log(force_curve./A1)./b1;
    force_curve_modi = force_zmag_m280(zmag,0);
    ext_curve = (ext_curve-min(ext_curve))*0.8/0.88;
%     ext_shift = 882;

    plot(ext_curve,force_curve_modi,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title('force-extension sum');
    hold on
a=ext_curve;
b=ext_curve;
x = corrcoef(a,b);
%% 20190129 ��MT4�����µģ�lambda DNA ��ϳ��Ĳ��������´����Ƕ���ǰ����ֵ���ݽ�������
% ������֮ǰMT4 10kb ��� �����ݣ����������1pN ����
    A1 = 142.6;
    b1 = -1.436;
    zmag = log(force_curve./A1)./b1;
    force_curve_modi = force_zmag_m280(zmag,4.1,0.3);
    plot(ext_curve,force_curve_modi,'Marker','o');
    xlabel('Ext.(nm)');
    ylabel('Force(pN)');
    title('force-extension sum');
    hold on

%% ��ͼ�Ƚ�������ϴ�Χ����ֵ�Ƚ�
z_mag = 0.7:0.01:5;
force_10kb = force_zmag_m280(z_mag,4,0.3);
force_lambda = force_zmag_m280(z_mag, 4.1,0.3);
figure;
plot (z_mag,force_10kb,'*');
hold on 
plot (z_mag,force_lambda,'o');





%%  �ػ�2G4���ĵ�ͼ��
data1 = data_ramp;
data2 = data_ramp;
data3 = data_ramp;
force = force_ramp;

z1_wavelet=sigDEN5(data1)';
z2_wavelet=sigDEN5(data2)';
z3_wavelet=sigDEN5(data3)';
time = 1:size(data1);
figure;
subplot(2,1,1)
hold on
plot(time,data1*1000);
plot(time,z1_wavelet*1000);
plot(time,(data2+0.2)*1000);
plot(time,(z2_wavelet+0.2)*1000);
plot(time,(data3+0.1)*1000);
plot(time,(z3_wavelet+0.1)*1000);
ylabel('Ext./nm');
hold off
subplot(2,1,2)
plot(time,force);
xlabel('Time/s');
ylabel('Force/pN');



%% export figure ���
% ����ǰͼ���ļ�����Ϊ �ļ���.��ʽ
export_fig m10fig4a.eps

% ��һ���ķŴ������棬���������Ϊ�Ŵ���
export_fig test.png -m2.5

% ����ʧ�ֱ��ʵ����
export_fig data_all3.tif -native

% ������߻��ߵ��޻���
export_fig m5fig3a2.eps -painters

% ���ڻ��� 0Ϊѹ���ߣ������ͣ�100Ϊ�����ߣ�����100Ϊ����

export_fig test.pdf -q101

% ���������׺
% ���ü���Ե��-nocrop
% ��������� -a<val> 1������ 2 3Ĭ������ 4��󻯿����
% �ı�ɫ�� -grey (or -gray) and -cmyk��only supported for PDF, EPS and TIFF files.�� 

% ��������ͼ���Ұ��������
for a = 1:5
    plot(rand(5, 2));
    export_fig(sprintf('plot%d.png', a));
end
% ͬʱ�������ָ�ʽ��ͼ��
export_fig filename -pdf -eps -png -jpg -tiff

% ͼ����Ⱦ -painters, -opengl, -zbuffer

% ���ڱ���͸��
set(gca, 'Color', 'none'); % Sets axes background
% then use export_fig's -transparent option when exporting:

export_fig test.png -transparent


%% ��������ͼ��
% ֻ��򿪸������ԣ�Ȼ��ĳ���ߵ�handleVisibility ����off���ɡ�
s = size(unnamed,1);
data = zeros(size(unnamed,1)*26,1);

for i=1:26
    data(((i-1)*s+1):i*s) = unnamed;
end


lh = findall(gca,'type','line')

yc = get(lh, 'ydata') 
ym = yc{1}';

xc = get(lh,'xdata');
xm = xc{1};
force_curve = force_curve';
% ������ԭ���ϴ������ϰ�ָ����ϵĲ�����
f2 = -log(force_curve./479.4)/3.947;

f2 = f2+0.008;

f_modi = force_zmag_m280(f2,0);

ext_curve_2 = ext_curve./1000-0.165;
ym = f_modi;

figure;
plot(xm,ym);

%% ����˥����������Ϊǿ�ȷֲ���

x = 0:0.1:3;
y = exp(-x).*cos(5*x);
x1 = x';
y1 = y';
x2 = [flip(-x1,1);x1(2:end)];
y2 = [flip(y1,1);y1(2:end)];
plot(x2-0.1,y2);
hold on 
plot(-(x2-0.05),y2);

plot (x1,y1);
xlabel('r');
ylabel('I');

% ���������еĻ���غ��� 20180620 ֤���˸�ʵ����ϵͳ����xcorr �ȼۣ�����ֱ��ʹ��xcorr
% x(n)=[1 3 2 6 2 1 -2 0 1 5 3 2 -3 0 1 2 0 3 1]
% y(n)=x(n-3)+e(n),e(n)Ϊ�������
x=y2;
y=flip(y2,1);
k=length(y2);
e=randn(1,k);
% y=y+e;
xk=fft(x,2*k);
yk=fft(y,2*k);
rm=real(ifft(conj(xk).*yk));%���ã�
rm=[rm(k+2:2*k) rm(1:k)];%���ã���
m=(-k+1):(k-1);%���ã���stem(m,rm)
plot((m-5)/100,rm);
xlabel('m');
ylabel('A');

grid on
hold on
corr = xcorr(x,y);
plot((m-5)/100,corr);
%end

%% ���һ����ֵ����
forcec = force;
extc = len;
% �ֱ�˳������
% start_point = 40;
upper = 100;
lower = 0;
start_point = [0.34,40,1150,0];

[fitresult, gof] = WLCFL_P_Fs_4_constraint( extc,forcec, start_point,lower,upper)

[fitresult2, gof2] = WLCFL_P_1_constraint(force, extc,start_point,lower,upper)
%% �۲�һ��WLCģ�͵�����
z =0.5:0.01:0.99;
F = 4.13./47*(1./(4*(1.-z).^2)-1/4 + z);
plot(z,F);
hold on
% force = [];
% zm = [];
% zm = zm+0.065;

plot(extc,forcec,'o','LineWidth',2);

%% ��origin �Ǳߵ�ֱ��ͼ��ֲ������
bar(twoG4_hist(:,1),twoG4_hist(:,2),'DisplayName','G4_hist')
xlabel('�������r');
ylabel('��ǿI');
title('����');
hold on 
plot(twoG4_hist_fit(:,1),twoG4_hist_fit(:,2));

 %% ��labview ���˼������������ͼ��
 PSD = [];
 freq = [];
 PSD_fit = [];
 figure;
semilogx(freq,PSD,'.','MarkerSize',10);
hold on
semilogx(freq,PSD_fit,'LineWidth',2);
 
%% ���������
r0 = r*0.4;
r_0 = -flipud(r0(2:end));
r_cor = [r_0;r0];
x_P0=(P(:,1)+P(:,2))/2;
x_P_0=flipud((P(2:end,3)+P(2:end,4))/2);
x_cor = [x_P_0;x_P0];
rp = (P(:,1)+P(:,2)+P(:,3)+P(:,4))/4;

plot(r_cor,x_cor)
hold on
plot(-r_cor,x_cor);

figure;
plot(r0,rp);
% ���������еĻ���غ���
%x(n)=[1 3 2 6 2 1 -2 0 1 5 3 2 -3 0 1 2 0 3 1]
%y(n)=x(n-3)+e(n),e(n)Ϊ�������
x=x_cor;
y=flip(x_cor,1);
k=length(x_cor);
e=randn(1,k);
y=y+e;
xk=fft(x,2*k);
yk=fft(y,2*k);
rm=real(ifft(conj(xk).*yk));%���ã�
rm=[rm(k+2:2*k) rm(1:k)];%���ã���
m=(-k+1):(k-1);%���ã���stem(m,rm)
figure;
plot((m-5)/100,rm);
xlabel('m');
ylabel('A');

grid on
hold on
%end

a=imread('piayi_0.tif');

%% ��150nm �Ļ�����Ԫ����һ��_ �˴�ʹ���������ַ����Ĺ�����������ͬ�ı�����
result = [];
for i=1:8
    data_name = strcat('y',num2str(i));
    result_name = strcat('y_',num2str(i));
    cmd = strcat(result_name,'=segment_auto_zero(',data_name,');');
    eval(cmd);
    result = [result;eval(result_name)];
end
dc_10_bd0_3F = result*0.8/0.88;

lucky2=[dc_8_bd0_2F;lucky];
    


%%  M280 wlc ���ݻ���
force_s = force(1:4:end);
len_s = len(1:4:end);
plot(len_s/4271,force_s,'o','MarkerSize',8);

hold on
plot(L/4271,force);

xlabel('Normalized Ext.')
ylabel('Force/pN')

%% ��ȡfig ͼ�е�����
open('data_all2.fig')
lh = findall(gca,'type','line')
xc = get(lh,'xdata')
yc = get(lh,'ydata')
xm = xc{1};
ym = yc{1};
xm = xm/0.88*0.8;
hold on 
plot(xm,ym);

%% �����Զ��޸�ͼƬ��ʽ
% ���� axes
axes1 = gca;
hold(axes1,'on');

box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);

%% ����һ����ֵ�Ȩ��
r_step = 200;
x = zeros(r_step,1);
for i=1:r_step
    x(i) = i/r_step;
end
t2 = 0.05;
t1 = 0.01;
fall = 1-exp(-(1-x).^2./t2);
fall2 = 1+(1-x).^2/t2;
rise = 1-exp(-x.^2./t1);
wnd =sqrt(fall.*rise.*x.*2);
% wnd2 = sqrt(fall2.*rise.*x.^2);
% wnd3 = sqrt(fall2.*rise.*x.*2);
plot(x,wnd);
% hold on
% plot(x,wnd2);
% plot(x,wnd3);

%****************************************************************************************
%  
%                      ���������ź�Mix_Signal_1 ���ź� Mix_Signal_2 
%
%***************************************************************************************

Fs = 200;                                                                        %������
N  = 1000;                                                                        %��������
n  = 0:N-1;
t   = 0:1/Fs:1-1/Fs;                                                            %ʱ������ 
Signal_Original_1 =sin(2*pi*10*t)+sin(2*pi*20*t)+sin(2*pi*30*t); 
Noise_White_1    = [0.3*randn(1,100), rand(1,100)];           %ǰ500���˹�ֲ�����������500����ȷֲ�������
Mix_Signal_1   = Signal_Original_1 + Noise_White_1;        %����Ļ���ź�

Signal_Original_2  =  [zeros(1,100), 20*ones(1,20), -2*ones(1,30), 5*ones(1,80), -5*ones(1,30), 9*ones(1,140), -4*ones(1,40), 3*ones(1,220), 12*ones(1,100), 5*ones(1,20), 25*ones(1,30), 7 *ones(1,190)]; 
Noise_White_2     =  0.5*randn(1,1000);                                 %��˹������
Mix_Signal_2        =  Signal_Original_2 + Noise_White_2;      %����Ļ���ź�
%****************************************************************************************
%  
%                �ź�Mix_Signal_1 �� Mix_Signal_2  �ֱ���������˹��ͨ�˲���
%
%***************************************************************************************

%����ź� Mix_Signal_1  ������˹��ͨ�˲�
figure(1);
Fs = 200;
Wc=2*30/Fs;                                          %��ֹƵ�� 50Hz
[b,a]=butter(2,Wc);
ext_ut=filter(b,a,ext_curve);
plot(force_curve, ext_curve);
hold on 
plot(force_curve, ext_but);



subplot(4,1,1);                                        %Mix_Signal_1 ԭʼ�ź�                 
plot(Mix_Signal_1);
axis([0,1000,-4,4]);
title('ԭʼ�ź� ');

subplot(4,1,2);                                        %Mix_Signal_1 ��ͨ�˲��˲����ź�  
plot(Signal_Filter);
axis([0,1000,-4,4]);
title('������˹��ͨ�˲����ź�');

%����ź� Mix_Signal_2  ������˹��ͨ�˲�
Wc=2*100/Fs;                                          %��ֹƵ�� 100Hz
[b,a]=butter(4,Wc);
Signal_Filter=filter(b,a,Mix_Signal_2);

subplot(4,1,3);                                        %Mix_Signal_2 ԭʼ�ź�                 
plot(Mix_Signal_2);
axis([0,1000,-10,30]);
title('ԭʼ�ź� ');

subplot(4,1,4);                                       %Mix_Signal_2 ��ͨ�˲��˲����ź�  
plot(Signal_Filter);
axis([0,1000,-10,30]);
title('������˹��ͨ�˲����ź�');

%% ��BSA ��CD ��
BSA = [];
BSA_H = [];

plot (BSA(:,1),BSA(:,2),'b');
hold on 
plot(BSA_H(:,1),BSA_H(:,2),'r');
xlabel('Wavelength')
ylabel('CircularDichroism')

n = size(unnamed,1);
for i = 1:n
    if abs(unnamed(i,7)-unnamed(i,8))<10E-20
        continue;
    else
        disappear("something wrong");
    end
end


%% �ж����������Ƿ���ȫ���
clear;
a = [];
b = [];
N = size(a,1);
N2 = N/2;
a1 = a(1:N2,:);
a2 = a((N2+1):end,:);
dif_a = a1-a2;
diff =find (dif_a);
c = a-b;

find(c);


%% �����޸�
 [data_repair] = data_repair(data_ramp);
 
 
 %% merge figure �Ѷ���fig ͼ����һ��
%֮ǰ�ܹ��ĳ��� �Ѿ������˶��matlabͼ��������Ҫ���кϲ���һ��ͼ�С�
%�������������ͼ������figureͼ���еĲ������뵽�ڴ��У�Ȼ������subplot���ơ�

open('./force=5.2317_G.fig')   
figure_info=findall(gcf,'type','line');    
xdata1 = get(figure_info,'xdata');   
ydata1 = get(figure_info,'ydata');   
color1 = get(figure_info,'color');   
subNum1 = length(xdata1);   

open('./force=5.4317_G.fig')   
figure_info=findall(gcf,'type','line');    
xdata2 = get(figure_info,'xdata');   
ydata2 = get(figure_info,'ydata');   
color2 = get(figure_info,'color');   
subNum2 = length(xdata2);   

open('./force=7.6317_G.fig')   
figure_info=findall(gcf,'type','line');    
xdata3 = get(figure_info,'xdata');   
ydata3 = get(figure_info,'ydata');   
color3 = get(figure_info,'color');   
subNum3 = length(xdata3);   

% open('./test_4.fig')   
% figure_info=findall(gcf,'type','line');    
% xdata4 = get(figure_info,'xdata');   
% ydata4 = get(figure_info,'ydata');   
% color4 = get(figure_info,'color');   
% subNum4 = length(xdata4);   



%%   

subplot(3,1,1)   
for i=subNum1:-1:1   
    if length(xdata1{i})==1   
        break;   
    end   
    plot(xdata1{i},ydata1{i},'.','color',color1{i})   
    hold on;   
end   
title('Force=6.4317pN')   
% set(gca,'xtick',[]);   
% set(gca,'ytick',[]);  
axes1 = gca;
hold(axes1,'on');
box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);

% box off;   
% axis off;   
subplot(3,1,2)   
for i=subNum2:-1:1   
    if length(xdata2{i})==1   
        break;   
    end   
    plot(xdata2{i},ydata2{i},'.','color',color2{i})   
    hold on;   
end   
title('force=7.1317pN')   
% set(gca,'xtick',[]);   
% set(gca,'ytick',[]);   
axes1 = gca;
hold(axes1,'on');
box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
% box off;   
% axis off;   
subplot(3,1,3)   
for i=subNum3:-1:1   
    if length(xdata3{i})==1   
        break;   
    end   
    plot(xdata3{i},ydata3{i},'.','color',color3{i})   
    hold on;   
end   
title('Force=7.8317pN')   
% set(gca,'xtick',[]);   
% set(gca,'ytick',[]);   
axes1 = gca;
hold(axes1,'on');
box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
    xlabel('Time/s');ylabel('Ext./nm');
% box off;   
% axis off;   
% subplot(2,2,4)   
% for i=subNum4:-1:1   
%     if length(xdata4{i})==1   
%         break;   
%     end   
%     lineH(subNum4-i+1) = plot(xdata4{i},ydata4{i},'.','color',color4{i});   
%     hold on;   
% end   
% title('(d). STCC')   
% set(gca,'xtick',[]);   
% set(gca,'ytick',[]);   
% box off;   
% axis off;   
% hL=legend(lineH,{'1','2','3','4','5','6','7','8'});   
% newPosition = [0.4 0.4 0.2 0.2];   
% newUnits = 'normalized';   
% set(hL,'Position', newPosition,'Units', newUnits);   
%% ����ֱ��ͼ

create_hist(step3(:,2));
