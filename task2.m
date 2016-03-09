close all;

%% Task 2
% A)

xh = [160, 188, 155, 170, 145, 150];
yv = [65, 75, 60, 70, 50, 62];

a = sum(xh.*yv)/sum(xh.*xh);
xLine = [140,190];
yEst = xLine.*a;
figure;
scatter(xh,yv);
hold on;
plot(xLine, yEst);
hold off;
fprintf('a = %g', a);

%B)
% We see that the line is now flipped onto the x-axis, so it's easy to see
% the distance from the estimated line. We notice that the shortest person
% does not fit the linear regression well and has a large impact on the
% position of the line due to the nature of MSE.
phi = atan(a);
xMat = [xh;yv];
T = [cos(phi), sin(phi); -sin(phi), cos(phi)];
f = T*xMat;
figure;
scatter(f(1,:), f(2,:));
hold on;
plot([150,210], [0,0]); %line at zero
hold off;

%C)
% We make some assumptions about the statistical properties, namely the
% linear relation between height and weight and also that the error is
% normally distributed with a constant variance. As long as this is true,
% and the variance is sufficiently small, this can give good compression.
fCompress = f;
fCompress(2,:) = 0;

xCompress = T'*fCompress;
figure;
scatter(xCompress(1,:), xCompress(2,:));
hold on;
scatter(xh,yv);

avgErrorYv = mean(abs(xCompress(2,:)-yv));
fprintf('Average weight error: %g\n', avgErrorYv);

%% Task 3
imgBlock = [124 125 122 120 122 119 117 118;
121 121 120 119 119 120 120 118;
126 124 123 122 121 121 120 120;
124 124 125 125 126 125 124 124;
127 127 128 129 130 128 127 125;
143 142 143 142 140 139 139 139;
150 148 152 152 152 152 150 151;
156 159 158 155 158 158 157 156];

quantBlock = [16 11 10 16 24 40 51 61;
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 56;
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;
24 35 55 64 81 104 113 92;
49 64 78 87 103 121 120 101;
72 92 95 98 112 100 103 99];
