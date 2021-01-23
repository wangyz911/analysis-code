function [] =FE_align_3D()
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
% 选择一个基准点x，读取每条曲线最靠近x点的点的y值（因为都是一个范围，所以查到一个等于查到所有）
yes = input('请按1选择对齐的基准点坐标','s');
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
% 需要补偿一下
t_offset = 140-top_y+r_offset_y(top_id);

end
k = 1;
figure;
for i=subNum1:-1:1   
    if length(xdata1{i})==1   
        break;   
    end
%     if k ==1
        NO_seq = ones(1,length(xdata1{i})) * k;
        plot3(xdata1{i},NO_seq,ydata1{i}-r_offset_y(i)+t_offset,'DisplayName',DisplayName{i},'MarkerSize',mk_size{i},'Marker',marker{i},...
        'MarkerFaceColor',MarkerFaceColor{i} ,'Color',color{i},'LineWidth',LineWidth{i});
%         plot(xdata1{i},ydata1{i}-r_offset_y(i)+t_offset,'DisplayName',DisplayName{i},'MarkerSize',mk_size{i},'Marker',marker{i},...
%         'MarkerFaceColor',MarkerFaceColor{i} ,'Color',color{i},'LineWidth',LineWidth{i});
%     else
%         plot(xdata1{i},ydata1{i}+offset,'LineWidth',2,'Color',[1 0 0]);
%     end
    k = k+1;
    hold on;   
end 
    xlabel('Force/pN');ylabel('Stretching cycle');zlabel('Ext./nm');
    hold off
    axes1 = gca;
hold(axes1,'on');
view(axes1,[-17.9059071729958 12.4534682080925]);
% 设置其余坐标区属性
set(axes1,'FontSize',18,'LineWidth',2,'XGrid','on','ZGrid','on');

            [~] = change_plot_style();
        % 首先保存图片的tif 格式
        name_save=strtok(file_name,'.');
        fig_name = strcat(name_save,'_ali_shif3D.fig');
        saveas(gcf,fig_name);  
end

