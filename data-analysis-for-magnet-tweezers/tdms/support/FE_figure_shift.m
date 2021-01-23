function [] = FE_figure_shift(offset)
%% ��figͼ�е����ݳ����������һ����ƽ�Ƶõ���ʵ�Ĵ���߶ȣ��ٱ����ԭͼ

[file_name,~]=uigetfile({'*.fig'},'Select your fig file');
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
end

