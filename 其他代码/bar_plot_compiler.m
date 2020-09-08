% ���ű��Զ�����˳��ߵ�����ֵ���ʵ�python ����
% data = [];
val = flipud(data(:,1));
err = flipud(data(:,2));
nor = flipud(data(:,3)); %��׼��ϵ��
fileID = fopen('python code.txt','w');
N = length(data);
% ����data
fprintf(fileID,'data = (');
for i = 1:N
    v=sprintf('%f',val(i));
    fprintf(fileID,v);
    if i~=N
        fprintf(fileID,',');
    end
end
fprintf(fileID,')\n');
% ����yr
fprintf(fileID,'yr = (');
for i = 1:N
    e=sprintf('%f',err(i));
    fprintf(fileID,e);

    if i~=N
        fprintf(fileID,',');
    end
end
fprintf(fileID,')\n');
per = '%%';
for i = 1:N
    v=sprintf('%.3f',val(i));
    n=sprintf('%.3f',nor(i));
    fprintf(fileID,'plt.text(');
    fprintf(fileID,v);
    fprintf(fileID,'+0.015,');
    fprintf(fileID,num2str(i-1));
    fprintf(fileID,'-0.07,''');
    fprintf(fileID,n);
    
    fprintf(fileID,per);
    fprintf(fileID,''',fontsize =14)\n');
end


