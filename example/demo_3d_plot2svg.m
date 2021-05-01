%% 3D sphere with alpha data
clear all;
figure
[x y z] = sphere(20); 
s = surface(x,y,z,'facecolor','interp','cdata',z);
set(s,'edgecolor','black','facealpha','flat','alphadata',x.*z);
alpha('scaled'); 
axis equal
box on
grid on
campos([2 13 10]); 
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Sphere with Alpha Data');
plot2svg('sphere.svg');

%% Rescaling patches to avoid gaps
clear all;

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
shading flat;
view([20, 80]);

% When exporting 3D plots with flat shading (no mesh lines around the
% patches) some viewers show small gaps between the patches. This can even
% lead to a mind of "semi transparent" appearance with many small patches,
% because the background can be seen in the gaps.
setting.svg.PatchRescale = 1;   % This is the deault setting.
set(gcf, 'UserData', setting);
plot2svg('flat_default.svg');

% A simple solution to this problem is to tell plot2svg to slightly
% increase the patch size, such that the patches overlap. A rescaling value
% of 105% is usually a good value to start with.
setting.svg.PatchRescale = 1.05;
set(gcf, 'UserData', setting);
plot2svg('flat_rescaled.svg');
