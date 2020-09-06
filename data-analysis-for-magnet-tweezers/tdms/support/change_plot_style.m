function [done] = change_plot_style()
% 本函数不需要输入参数，运行即可，返回个无意义的done，作用是修改图像格式使统一化。
        % 创建 axes
        axes1 = gca;
        hold(axes1,'on');
        
        box(axes1,'off');
        %         % 设置其余坐标区属性
        %         set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
        %             'ZColor',[0 0 0])
        
        % 设置坐标刻度外翻
        set(axes1,'TickDir','out');
        % 设置其余坐标区属性
        set(axes1,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
            'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
%         box off
%         ax2 = axes('Position',get(gca,'Position'),...
%             'XAxisLocation','top',...
%             'YAxisLocation','right',...
%             'Color','none',...
%             'XColor','k','YColor','k');
%         set(ax2,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
%             'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
%         set(ax2,'YTick', []);
%         set(ax2,'XTick', []);
%         box on
        done = 1;
        
end

