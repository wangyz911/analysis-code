function createMyScatter(X, Y, Y_fit)
%CREATEFIGURE(X1, Y1, Y2)
%  X1:  scatter x
%  Y1:  scatter y
%  Y2:  y ���ݵ�����

%  �� MATLAB �� 13-Apr-2019 23:00:50 �Զ�����

% ���� figure
figure('OuterPosition',[491 204 973 733]);

% ���� axes
axes1 = axes('Position',...
    [0.13 0.13302034428795 0.797899686520376 0.826408450704227]);
hold(axes1,'on');

% ���� scatter
scatter(X,Y,'DisplayName','\Delta private sector',...
    'MarkerFaceColor',[0.501960784313725 0.501960784313725 0.501960784313725],...
    'MarkerEdgeColor','none');

% ���� plot
plot(X,Y_fit,'DisplayName','fitted values','LineWidth',2,'LineStyle','--',...
    'Color',[0 0 0]);

% ���� ylabel
ylabel('\Delta divorce rate');

% ���� xlabel
xlabel('genetic distance');

% ȡ�������е�ע���Ա����������� X ��Χ
% xlim(axes1,[-0.0415276232851317 1.35847237671487]);
% ȡ�������е�ע���Ա����������� Y ��Χ
% ylim(axes1,[0.0589631037760304 0.23896310377603]);
% ������������������
set(axes1,'FontSize',18,'GridColor',[0 0 0],'LineWidth',1.5,...
    'MinorGridColor',[0 0 0],'XColor',[0 0 0],'YColor',[0 0 0],'YGrid','on',...
    'ZColor',[0 0 0]);
% ���� legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.677913075755882 0.868741553639501 0.214211071484266 0.0915492932561419],...
    'EdgeColor',[0 0 0]);

