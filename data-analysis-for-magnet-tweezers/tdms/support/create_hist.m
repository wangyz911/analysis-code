function create_hist(data1)
%CREATEFIGURE(data1)
%  DATA1:  histogram data

%  由 MATLAB 于 26-Sep-2019 14:26:57 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 histogram
histogram(data1,'Parent',axes1,'EdgeColor',[0.8 0.8 0.8],...
    'FaceColor',[0 0.450980392156863 0.741176470588235],...
    'NumBins',44);

% 创建 ylabel
ylabel('Count');

% 创建 xlabel
xlabel('Ext./nm');

box(axes1,'on');
% 设置其余坐标区属性
set(axes1,'FontSize',18,'LineWidth',2,'XColor',[0 0 0],'YColor',[0 0 0],...
    'ZColor',[0 0 0]);
