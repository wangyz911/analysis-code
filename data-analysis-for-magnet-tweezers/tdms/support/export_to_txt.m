%  本脚本用于将matlab 中的数据按列写入txt 文件中

x = DNA_x_modi;
y = DNA_y_modi;
z = DNA_z_position_modi;
zmag = magnet_z_position;

data_name = strcat(name_save,'.txt');
a = [x,y,z,zmag]';

fid = fopen(data_name,'w');

    fprintf(fid,'%6.8f\t %6.8f\t %6.8f\t %6.8f\r\n',a);

 
fclose(fid);

