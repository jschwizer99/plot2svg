clear all;
%%

% Generate a nice plot.
dt = 0.01;
tend = 10;
t = 0:dt:tend;

y = sin(2*pi*t);

figure(1);
clf;
plot(t, y);
grid on;
axis tight;
xlabel('$t$ / s');
ylabel('$y$ / V');
set(gca, 'XScale', 'log');

text(0.02, -0.25, '\LaTeX{} test $\frac{a}{b}$');
legend('$\sin(2\pi t)$');

% We want to use the LaTeX + PDF export capability of Inkscape. Therefore,
% we have to make sure that plot2svg preserves all our LaTeX strings.
% This can be achieved by setting the option LatexPassOn to true.
setting.svg.LatexPassOn = true;
set(gcf, 'UserData', setting);

plot2svg('demo_graphics.svg');

% Call Inkscape to convert the SVG file to a PDF and a LaTeX overlay file.
% Note: This works only if the path to the Inkscape executable is correctly
%       set up. Alternatively you could do this manually in Inkscape.
system('inkscape -z --export-area-page --file=demo_graphics.svg --export-pdf=demo_graphics.pdf --export-latex');

%%
% Sometimes, we want the graphics to be smaller. There are multiple ways to
% achieve this. If we want to scale everything, including the line widths,
% the GlobalSize option can be used.
setting.svg.GlobalScale = 0.6;
set(gcf, 'UserData', setting);
plot2svg('demo_graphics_smaller.svg');
system('inkscape -z --export-area-page --file=demo_graphics_smaller.svg --export-pdf=demo_graphics_smaller.pdf --export-latex');

%%
% Call pdflatex to compile the document. Again, this only works if the
% path to pdflatex is set up.
system('pdflatex inkscape_demo.tex');
