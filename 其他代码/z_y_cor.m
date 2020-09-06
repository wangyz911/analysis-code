y_cor_line = force_curve(:,6);
z_position = force_curve(:,2);
z = 2:0.01:2.99;
 y_cor_cali = z.*3*50* 1.0e-3./(1./(4*(1-z).^2)-1/4 + z);
figure;
plot(z,y_cor_cali,z_position',y_cor_line');
