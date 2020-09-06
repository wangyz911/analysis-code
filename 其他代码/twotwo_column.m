% data = [];
col = size(data,1);
n = size(data,2)/2;
data_array = zeros(2*col,n);
for i=1:n
    data_array(1:col,(2*i-1):2*i)=data(:,(4*i-3):(4*i-2));
    data_array((col+1):end,(2*i-1):2*i)=data(:,(4*i-1):4*i);
end