function [ DNA_z_position ] = read_pico1( fid )
%UNTITLED4 �򻯰汾��������ֻ������Z�������ݵ������
%   Detailed explanation goes here
standard_string='abcd';
judge=~strcmp(standard_string(2:4),'-a!');
while  judge
    fgetl(fid);
    standard_string=fread(fid,4,'*char')';
    judge=~strcmp(standard_string(2:4),'-a!');
end
fgetl(fid);
DNA_z_position_array=textscan(fid,'%f%f');                                 %��ȡz��������
DNA_z_position=DNA_z_position_array{1,2};

end

