
[done] = change_plot_style();
k = 1;
close all;
%%  ���師��ͼ��
offset = 0;
FE_plot6(force_curve,ext_curve,k,offset);
k = k+1;
%% ����ͼ���Զ�����

[file_name,~]=uigetfile({'*.fig'},'Select your fig file');
disp(file_name);
op_name = strcat('./',file_name);
    name_save=strtok(file_name,'.');

fig_name = strcat(name_save(1:end-4),'FE_sum.fig');
saveas(gcf,fig_name);


%% FE-align �Ѷ��FEͼ�е����ݳ�������룬��������ߵ��ֵ����ƽ�ƣ����յõ��߶�ͳһ�Ķ�F-E��άͼ��
% ����ͼ����ɫ��marker��С����
    FE_align();
%% FE-align 3D �Ѷ��FEͼ�е����ݳ�������룬��������ߵ��ֵ����ƽ�ƣ����յõ��߶�ͳһ�Ķ�F-E��άͼ��
% ����ͼ����ɫ��marker��С����
    FE_align_3D();
%% �����������Ϣ������graphpad�ĸ�ʽ
[done] = change_plot_style();

%% ��figͼ�е����ݳ����������һ����ƽ�Ƶõ���ʵ�Ĵ���߶ȣ��ٱ����ԭͼ
close all;
offset = -30;
FE_figure_shift(offset);

%% gather figure �Ѷ���fig ͼ����һ��
%�����棬���Զ������ţ��Զ���ͼ������color����
gather_figure();

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

[fitresult, gof] = WLCFL_P_Fs_4_constraint( extc,forcec, start_point,lower,upper);

[fitresult2, gof2] = WLCFL_P_1_constraint(force, extc,start_point,lower,upper);
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
lh = findall(gca,'type','line');
xc = get(lh,'xdata');
yc = get(lh,'ydata');
xm = xc{1};
ym = yc{1};
xm = xm/0.88*0.8;
hold on 
plot(xm,ym);


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



%   ������ĺ�������ȡ������ͼ�ŵ�һ��һ������ƽ��̬������

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
