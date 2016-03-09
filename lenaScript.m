load('lenag_SD.mat');
% image Lena
%image = rgb2gray(lenag);
%imshow(lenag);

%2D dct
J = dct2(lenag);
figure,imshow(log(abs(J)));
figure,imshow(log(abs(J)),[]),colormap(jet),colorbar

%imagesc(lenag),colormap(gray)

% 2D fft
f=fft2(lenag); a=abs(f); m = fftshift(a); figure, mesh(m);
figure,imagesc(m);
startPixel = 320;
lengthOfBlock = 8;
lenagBlock = lenag(startPixel:startPixel+lengthOfBlock,startPixel:startPixel+lengthOfBlock);
figure(4),imshow(lenagBlock,[0 255])
set(4,'Position',[500,500,8,8]);
set(gca,'Position',[0,0,1,1]);
JBlock = dct2(lenagBlock);
figure(5),imshow(log(abs(JBlock))),title('JBlock');
set(5,'Position',[500,500,8,8]);
set(gca,'Position',[0,0,1,1]);
