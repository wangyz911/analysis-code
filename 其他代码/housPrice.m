data = zeros(0,0);

h_price = flipud(data());
danyuan = size(h_price,2);
fl = 1:size(h_price,1);
for i = 1:danyuan
    plot(fl,h_price(:,i));
    hold on
end

xlabel('楼层');
ylabel('总价/万元');