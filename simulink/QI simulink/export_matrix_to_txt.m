fileID = fopen('template502.txt','w');

for i = 1:50
    for j=1:50
        elem = sprintf('%3.0f',template502(i,j));
        fprintf(fileID,elem);
        fprintf(fileID,',');
    end
    fprintf(fileID,'\n');
end
fclose(fileID);

