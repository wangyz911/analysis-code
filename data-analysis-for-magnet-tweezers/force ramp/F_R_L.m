% 本脚本全称： force distribution --> rate --> landscape 是基于文献Proc. Natl. Acad.
% Sci. U.S.A. 110, 16432–7.中的工作编写的，用于处理含有多个态的结构在展开时如何得到能量图景。
%需要已知各个态分别的力值分布，往复或重叠的情况照常记录下力值,但正跳和回跳有所区别，统计时需要区别对待。 输入应是每个态一个
%矩阵NI,IN,IU,UI，第一行是bin值(F)，第二行是counts of F. matlab 的拟合不太给力，还是要用origin
%% 第一步，已知力值分布，转化为反应速率分布。
% 参数设置

load ramp_data_new
NI_f = force_zmag_che(NI_z);
IN_f = force_zmag_che(IN_z);
IU_f = force_zmag_che(IU_z);
UI_f = force_zmag_che(UI_z);
%% NI 数据分析

%加载率
loading_rate = 0.2;                                                         %单位 pN/s

% 总共（有现象的）拉伸轨迹数
total_number =144;
%%%%%%%%%%%%%%%%%%%%%%提取直方图中的数据
figure;
NI_h = histogram(NI_f,'BinMethod','fd');
%力值分布直方图
bin_number =NI_h.NumBins;
bin_width = NI_h.BinWidth;%待定
force =NI_h.BinEdges';                                                         %这里力值序列应该等于贯穿整个force
NI_counts = NI_h.Values';

%用来存放结果的矩阵
trajectory_number_N = zeros(bin_number,1);

NI_rate = zeros(bin_number,1);

% 计算反应速率
f = force';
for k = 1:bin_number
    
    trajectory_number_N(k,1) = total_number - size( find(NI_f < f(k)),1) + size(find(IN_f < f(k)),1);
    %     trajectory_number_I(k,1) = size( find(NI_f < f),1) -
    %     size(find(IN_f < f),1) - size(find(IU_f < f),1) + size(find(UI_f
    %     < f),1); trajectory_number_U(k,1) = size(find(IU_f < f),1) -
    %     size(find(UI_f < f),1);
    NI_rate(k,1) = loading_rate * NI_counts(k)/(trajectory_number_N(k,1)*bin_width);
    %     rate(k,2) = loading_rate *
    %     IN_counts(k)/(trajectory_number_I(k,1)*bin_width); rate(k,3) =
    %     loading_rate * IU_counts(k)/(trajectory_number_I(k,1)*bin_width);
    %     rate(k,4) = loading_rate *
    %     UI_counts(k)/(trajectory_number_U(k,1)*bin_width);
    
end
NI_log = log(NI_rate);

%
%
% NI_p = [-6,2]; NI_rate_log = log(NI_rate); % NI_parameter_fit =
% Dudko_fit_unfold( force(1:(end-1)),NI_rate_log,NI_p); NI_total =
% size(NI_f,1); %%%%%%%%%%%%%%%% evans model NI_parameter_fit =
% evans_model( force(1:(end-1)),NI_counts(1:end),NI_p,NI_total);


% IU_p = [-7.25,10,3]; IU_rate = log(NI_rate(6:28,3)); [ IU_parameter_fit,
% IU_resnorm ] = Dudko_fit_unfold( IU_rate,force(6:28),IU_p);

% % UI_p = [-7.25,10,3]; % UI_rate = log(NI_rate(9:18,4)); % [
% UI_parameter_fit, UI_resnorm ] = Dudko_fit_unfold(
% UI_rate,force(9:18),UI_p);
figure;
IU_h = histogram(IU_f,'BinMethod','fd');
%力值分布直方图
bin_number =IU_h.NumBins;
bin_width = IU_h.BinWidth;                                                    %待定
force =IU_h.BinEdges;                                                         %这里力值序列应该等于贯穿整个force
IU_counts = IU_h.Values;
%用来存放结果的矩阵
trajectory_number_N = zeros(bin_number,1);
trajectory_number_I = zeros(bin_number,1);
trajectory_number_U = zeros(bin_number,1);
IU_rate = zeros(bin_number,1);                                    %这里要解释一下，暂时默认为渐进模型，1-2-3，因此三个状态总共有两个转换速率，
%加上逆反应，乘2,数据保存默认先存正向（展开），再存逆向（折叠）。

% 计算反应速率
f = force;
for k = 1:bin_number
    
    trajectory_number_N(k,1) = total_number - size( find(NI_f < f(k)),1) + size(find(IN_f < f(k)),1);
    trajectory_number_I(k,1) = size( find(NI_f < f(k)),1) - size(find(IN_f < f(k)),1) - size(find(IU_f < f(k)),1) + size(find(UI_f < f(k)),1);
    trajectory_number_U(k,1) = size(find(IU_f < f(k)),1) - size(find(UI_f < f(k)),1);
    IU_rate(k,1) = loading_rate * IU_counts(k)/(trajectory_number_I(k,1)*bin_width);
    %     rate(k,2) = loading_rate *
    %     IN_counts(k)/(trajectory_number_I(k,1)*bin_width); rate(k,3) =
    %     loading_rate * IU_counts(k)/(trajectory_number_I(k,1)*bin_width);
    %     rate(k,4) = loading_rate *
    %     UI_counts(k)/(trajectory_number_U(k,1)*bin_width);
    
end

IU_p = [-3,60,0];
IU_rate_log = log(IU_rate);
IU_parameter_fit = Dudko_fit_unfold( force(1:(end-1)),IU_rate_log,IU_p);
