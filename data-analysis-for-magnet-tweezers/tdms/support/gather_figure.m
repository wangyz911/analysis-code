function [] = gather_figure()
%% gather figure 把多张fig 图画到一起
%改良版，可以读任意张，自动出图，保持color不变

clc;clear;   
i =0;
keep = 1;
while(keep)
    disp("还要继续读取图像吗？ 是-1，否-0");
    keep = str2double(input('输入1读取图像','s'));
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
    xdata = 1:length(eval([x '{j}'])./100);  %时间单位为秒
    plot(xdata,eval([y '{j}']),'.','color',eval([color '{j}']))   
    hold on;   
end   

title(strtok(eval(na),'f')) ;  
% set(gca,'xtick',[]);   
% set(gca,'ytick',[]);  
axes0 = gca;

hold(axes0,'on');
box(axes0,'on');
% 设置其余坐标区属性
set(axes0,'TickDir','out');
set(axes0,'Color','none','FontName','Arial','FontSize',12,'FontWeight',...
    'bold','LineWidth',1.5,'XColor',[0 0 0],'YColor',[0 0 0],'ZColor',[0 0 0]);
    
end
linkaxes([axes1,axes2,axes3],'xy'); % 3个轴同步，
xlabel('Time/s');ylabel('Ext./nm');
end

