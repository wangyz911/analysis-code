function [done] = change_plot_style()
% ����������Ҫ������������м��ɣ����ظ��������done���������޸�ͼ���ʽʹͳһ����
        % ���� axes
        axes1 = gca;
        hold(axes1,'on');
        
        box(axes1,'off');
        %         % ������������������
        %         set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
        %             'ZColor',[0 0 0])
        
        % ��������̶��ⷭ
        set(axes1,'TickDir','out');
        % ������������������
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

