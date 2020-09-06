function create_hist(data1)
%CREATEFIGURE(data1)
%  DATA1:  histogram data

%  �� MATLAB �� 26-Sep-2019 14:26:57 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� histogram
histogram(data1,'Parent',axes1,'EdgeColor',[0.8 0.8 0.8],...
    'FaceColor',[0 0.450980392156863 0.741176470588235],...
    'NumBins',44);

% ���� ylabel
ylabel('Count');

% ���� xlabel
xlabel('Ext./nm');

box(axes1,'on');
% ������������������
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
