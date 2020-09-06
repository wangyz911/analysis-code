%% ATK VS DEF
def  = 100:10:1000;
atk = 10000;

atk_real = floor(atk*(4000+def)./(4000+10.*def))/atk;
plot(def,atk_real);
atk_js = zeros(size(def,2)-1,1);
for i = 1:(size(def,2)-1)
    atk_js(i) = (atk_real(i)-atk_real(i+1));
end
figure;
plot(def(2:end),atk_js);

%% ATL VS ºı…À
title('DEF vs ATK real(%)');