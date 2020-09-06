
% data  = [];

N = size(data,1);

fileID = fopen('x and y.txt','w');
fprintf(fileID,'x = (');
for i = 1:N
    elem = sprintf('%.6f',data(i,1));
    fprintf(fileID,elem);
    if i<N
        fprintf(fileID,',');
    else
        fprintf(fileID,')\n');
    end
end
fprintf(fileID,'y = (');
for i = 1:N
    elem = sprintf('%.6f',data(i,2));
    fprintf(fileID,elem);
    if i<N
        fprintf(fileID,',');
    else
        fprintf(fileID,')\n');
    end
end

polyfit(data(:,1),data(:,2),1)
x = data(:,1);
fit_y = 0.1223+0.0490.*x;

fprintf(fileID,'fit_y = (');
for i = 1:N
    elem = sprintf('%.6f',fit_y(i));
    fprintf(fileID,elem);
    if i<N
        fprintf(fileID,',');
    else
        fprintf(fileID,')\n');
    end
end
    


