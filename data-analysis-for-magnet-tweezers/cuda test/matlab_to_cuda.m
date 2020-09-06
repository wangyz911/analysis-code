
maxIterations = 200;
gridSize = 1000;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

x = linspace( xlim(1), xlim(2), gridSize );
y = linspace( ylim(1), ylim(2), gridSize );
[xGrid,yGrid] = meshgrid( x, y );

%% Mandelbrot computation in MATLAB
count = mandelbrot_count(maxIterations, xGrid, yGrid);

% Show
figure(1)
imagesc( x, y, count );
colormap([jet();flipud( jet() );0 0 0]);
axis off
title('Mandelbrot set with MATLAB');


