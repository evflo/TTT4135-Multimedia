%% Assignment 1 TTT4135 Multimedia Signal Processing
% *Group members: Benjamin Strandli Fermann, Chenyan Zhang and Even
% Florenes*
%% Problem 1
% *Task a*
%
% Find the probability pn for each state of the source X Xn (n =1, 2).
% 
% p(x1|x0) = 1/4
% p(x1|x1) = 2/3
% p(x0|x0) = 3/4
% p(x0|x1) = 1/3
%
% p(x1)/p(x0) = p(x1|x0)/p(x0/x1)
% = (1/4)/(1/3)
% 
% p(x1)/p(x0) = 3/4
%
% p(x0)+p(x1) = 1                  
%
% p(x0)+(3/4)p(x0) = 1
%
% (7/4)p(x0) = 1
%
% p(x0) = 4/7 = 0.571
%
% p(x1) = 1-4/7 = 3/7 = 0.429
%
% Simulation of Markov process gives the same result
x0 = 0;
x1 = 0;
state = 0;
for k = 1:1000000
    if state
        if rand < 2/3
            x1 = x1 + 1;
            state = 1;
        else
            x0 = x0 + 1;
            state = 0;
        end
    else
        if rand < 0.75
            x0 = x0 + 1;
            state = 0;
        else
            x1 = x1 + 1;
            state = 1;
        end
    end
end

fprintf('Probability of state 0: %0.2f \n',x0/k);
fprintf('Probability of state 1: %0.2f \n',x1/k);
%%
% *Task b*
%
% Find entropy H(X)
%
% H(X) = (4/7)*log2(7/4)+(3/7)*log2(7/3) = 0.985
%%
% *Task c*
%
% Probability of extended states
% 
% P(x1 x1) = P(x1)*P(x1|x1) = 2/7
% P(x1 x0) = P(x1)*P(x0|x1) = 1/7
% P(x0 x1) = P(x0)*P(x1|x0) = 1/7
% P(x0 x0) = P(x0)*P(x0|x0) = 3/7
%
%  Find Huffman code and entropy rate B:
%                /
%              /  \
%        2/7 /  \  3/7
%          /  \  2/7
%       1/7    1/7
%
%  Bit encoding
% P(x0 x0) | 1 
% P(x1 x1) | 01
% P(x1 x0) | 001
% P(x0 x1) | 000
%
%  Entropy: B = (2/7)*log2(3.5)+2*(1/7)*log2(7)+(3/7)*log2(7/3) = 1.842
%  Average bit: 0.25*(2+3+3+1) = 2.25
%
% Using extended source compared to two states does not given any gain
%% Problem 2
% *Task a*
%
% error: e = sum(y_i-yhat_i)^2
%   = sum(y_i-a*x_i)^2
%
% Find a which gives lowest error:
%
% de/da = 2*sum((y_i-a*x_i)*x_i)
%       = 2*sum(y_i*x_i)-2*a*sum(x_i^2)
%
% Find best a => de/da = 0
%
% a = sum(y_i*x_i)/sum(x_i^2)
% Doing MATLAB-simulation gives: a = 0.3955
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
%%
% *Task b*
%
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
%%
% *Task c*
%
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

%% Problem 3
% *Task a*
image = [124 125 122 120 122 119 117 118; 
121 121 120 119 119 120 120 118;
126 124 123 122 121 121 120 120;
124 124 125 125 126 125 124 124;
127 127 128 129 130 128 127 125;
143 142 143 142 140 139 139 139;
150 148 152 152 152 152 150 151;
156 159 158 155 158 158 157 156 ];
   
imageDCTTransformed = dct2(image);
%%
% *Task b*
quantizationTable = [16 11 10 16 24 40 51 61;
12 12 14 19 26 58 60 55;
14 13 16 24 40 57 69 56; 
14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;
24 35 55 64 81 104 113 92;
49 64 78 87 103 121 120 101;
72 92 95 98 112 100 103 99];
   
transformTableImage = zeros(size(image,1),size(image,2));
transformTableImageDCT = zeros(size(image,1),size(image,2));

for i = 1:size(image,1)
    for j = 1:size(image,2)
        transformTableImage(i,j) = floor(image(i,j)/quantizationTable(i,j)+0.5);
        transformTableImageDCT(i,j) = floor(imageDCTTransformed(i,j)/quantizationTable(i,j)+0.5);
    end
end
% The coefficents k_ij for image:
fprintf('The coefficents k_ij for image: \n');
transformTableImage
fprintf('The coefficents k_ij for transform: \n');
transformTableImageDCT

%%
% Using the coefficients for the DCT-transformed will give us less
% quantization error. In the original image the energy is somewhat evenly
% distributed over the whole image, but for the DCT-transform all the
% energy is in the first part of the table. These values are a large an
% easy to quantize with high precision in the reconstruction. Using the
% DCT-transform also gives us the possibility of using zigzag- walktrough
% the table and stop when there is only zeros left.
%%
% *Task c*
imageDCTQuantized = zeros(size(image,1),size(image,2));
imageQuantized =  zeros(size(image,1),size(image,2));
for i = 1:size(image,1)
    for j = 1:size(image,2)
    imageDCTQuantized(i,j) = (transformTableImageDCT(i,j)*quantizationTable(i,j)-0.5);
    imageQuantized(i,j) = (transformTableImage(i,j)*quantizationTable(i,j)-0.5);

    end
end

imageInverseDCTQuantized = idct2(imageDCTQuantized);

psnrImageQuantizedDCT = psnr(image,imageInverseDCTQuantized,255)
psnrImageQuantized = psnr(image,imageQuantized,255)
