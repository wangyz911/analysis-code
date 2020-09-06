% cuda speed test

% x = image;
% tic;
% for i = 1:100
% y1=cuda_1(x2,1);
% end
% toc;

tic;
for i=1:100
y2=cuda_1(x2,2);
end
toc;
