% data = [];

x = data(:,1);
y = data(:,2);
x1 = ones(size(data,1),1);
X = [x1,x];
b = regress(y,X);
y_fit = b(1)+b(2)*x;

createMyScatter(x,y,y_fit);

