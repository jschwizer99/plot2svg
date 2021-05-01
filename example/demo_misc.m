%% Image overlay and typical usage.
% The purpose of the OverlayImage function is to replace parts of a figure,
% e.g., a rendering which is too complex to be stored as vector graphics,
% with a bitmap image. The bitmap file is linked and not embedded in the SVG.

clear all;

% First, render the 3D graphics into a bitmap file.
x = -3.5:0.1:3.5;
y = -3.5:0.1:3.5;

[X, Y] = meshgrid(x, y);

Z = peaks(X, Y);

figure(1); 
clf;
surf(X, Y, Z);
axis tight;
xlabel('x');
ylabel('y');
zlabel('z');
shading interp;
lighting('phong');
camlight('headlight');
colormap(jet(512));
axis off;
xl = xlim();
yl = ylim();
zl = zlim();

bg = get(gcf, 'color');
% Make sure the background color is saved, so that we can set it transparent
% later.
set(gcf, 'InvertHardCopy', 'off');

print -dpng -r300 'render.png'

% Load and re-save the image with transparent background.
% Be careful that the background color doesn't occur in your plot. If this
% is the case you should set another background color above.
A = imread('render.png');
imwrite(A, 'render_t.png', 'png', 'transparency', bg);

% Now recreate the same axis without the data.
% Please note:
% In some cases it can be difficult to achieve a correct alignment of the
% bitmap and vector output. It may require some fiddling and your mileage
% may vary.
figure(2); 
clf;
surf([0, 0;0, 0], [0, 0;0, 0], [0, 0;0, 0]);
axis tight;
xlabel('x');
ylabel('y');
zlabel('z');
xlim(xl);
ylim(yl);
zlim(zl);

% Last step: Store axis plot as SVG image and use the rendered data as
% overlay.
setting.svg.OverlayImage = 'render_t.png';
setting.svg.OverlayImagePos = [0, 0, 1, 1];
set(gcf, 'UserData', setting);

plot2svg('overlay.svg');

%% Simple use case:
% Of course, you can use the overlay function to just add a bitmap to your
% SVG file.
clear all;

x = 0:0.1:5;
y = 1 + x.^2;

figure(3);
clf;

plot(x, y);
xlabel('x values');
ylabel('y values');

setting.svg.OverlayImage = 'water_stones.jpg';
setting.svg.OverlayImagePos = [0.2, 0.2, 0.25, 0.25];
set(gcf, 'UserData', setting);

plot2svg('overlay_simple.svg');

