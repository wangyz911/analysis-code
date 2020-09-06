% WLC fit, ֻҪ��һ��FE�Ϳ�����ϣ������������ڸ�FE��ͼ

%% extensible WLC model
% �������壺b[Lp,n(ƽ����)��]
fun=@(b,x)4.11/b(1)*(1./(4*(1-x(:,1)+b(2)+x(:,2)./b(3)).^2)-1/4+x(:,1)-b(2)-x(:,2)./b(3)-0.5164228*(x(:,1)-b(2)-x(:,2)./b(3)).^2-2.737418*(x(:,1)-b(2)-x(:,2)./b(3)).^3+16.07497*(x(:,1)-b(2)-x(:,2)./b(3)).^4-38.87607*(x(:,1)-b(2)-x(:,2)./b(3)).^5+39.49944*(x(:,1)-b(2)-x(:,2)./b(3)).^6-14.17718*(x(:,1)-b(2)-x(:,2)./b(3)).^7)-x(:,2);
% set initial value of b
b0=[rand*40,0.01,2000];
%b0=[]
% calculate and display R-squared
mdl= fitnlm(x,zeros(size(x,1),1),fun,b0);
% calculate and diaplay parameters
b=nlinfit(x,zeros(size(x,1),1),fun,b0);
disp('���������ֱ�Ϊ��');
disp(num2str(b));
disp('b0Ϊ��');
disp(num2str(b0));
% construct implicit function to plot �൱��f(x,y)=0����ʽ
f2=@(m,n)10^(12)*1.3806505*10^(-23)*(25+273)/(b(1)*10^(-9))*(1./(4*(1-m+b(2)+n./b(3)).^2)-1/4+m-b(2)-n./b(3)-0.5164228*(m-b(2)-n./b(3)).^2-2.737418*(m-b(2)-n./b(3)).^3+16.07497*(m-b(2)-n./b(3)).^4-38.87607*(m-b(2)-n./b(3)).^5+39.49944*(m-b(2)-n./b(3)).^6-14.17718*(m-b(2)-n./b(3)).^7)-n;
% plot
hold on
ezplot(f2,[0,1,0,18])  % �����޶�����x��Χ��y�ķ�Χ
plot(x(:,1),x(:,2),'rd','MarkerSize',6)
axis([0 1.1 0 18])
grid on
title('extensible WLC model');legend('�������','������');xlabel('L/L0');ylabel('Force/pN')

%% Inextensible WLCģ�ͣ�
% input x1
x1=x(:,1);
% inextensible WLC model  c(1)Ϊ�쳤����c(2)Ϊƽ�Ʋ���
fun=@(c,x1)4.11/c(1)*(1./(4*(1-x1+c(2)).^2)-1/4+x1-c(2)-0.5164228*(x1-c(2)).^2-2.737418*(x1-c(2)).^3+16.07497*(x1-c(2)).^4-38.87607*(x1-c(2)).^5+39.49944*(x1-c(2)).^6-14.17718*(x1-c(2)).^7);
% set initial value of c
c0=[40,0.01];
% calculate and display R-squared
mdl= fitnlm(x1,x(:,2),fun,c0);
% calculate and diaplay parameters
c=nlinfit(x1,x(:,2),fun,c0);
disp('���������ֱ�Ϊ��');
disp(num2str(c));
% construct implicit function to plot
f2=@(m,n)4.11/c(1)*(1./(4*(1-m+c(2)).^2)-1/4+m-c(2)-0.5164228*(m-c(2)).^2-2.737418*(m-c(2)).^3+16.07497*(m-c(2)).^4-38.87607*(m-c(2)).^5+39.49944*(m-c(2)).^6-14.17718*(m-c(2)).^7)-n;
% plot
hold on
fplot(f2,[0,1,0,18]);
plot(x(:,1),x(:,2),'rd','MarkerSize',6)
axis([0 1.1 0 18])
grid on
title('inextensible WLC model');legend('�������','������');xlabel('L/L0');ylabel('Force/pN')
