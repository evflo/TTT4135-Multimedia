load('lenag_SD.mat');
waveletName = 'fk4';
[CA,CH,CV,CD] = dwt2(lenag,waveletName);

fig = figure;

subplot(2,2,1),imagesc(CA),title('Approximation'),colormap(gray);
subplot(2,2,2),imagesc(CH),title('Horizontal'),colormap(gray);
subplot(2,2,3),imagesc(CV),title('Vertical'),colormap(gray);
subplot(2,2,4),imagesc(CD),title('Diagonal'),colormap(gray);

[C2A,C2H,C2V,C2D] = dwt2(CA,waveletName);
fig2 = figure;

subplot(2,2,1),imagesc(C2A),title('Approximation wavelet'),colormap(gray);
subplot(2,2,2),imagesc(C2H),title('Horizontal wavelet'),colormap(gray);
subplot(2,2,3),imagesc(C2V),title('Vertical wavelet'),colormap(gray);
subplot(2,2,4),imagesc(C2D),title('Diagonal wavelet'),colormap(gray);

[C3A,C3H,C3V,C3D] = dwt2(C2A,waveletName);
fig2 = figure;

subplot(2,2,1),imagesc(C3A),title('Approximation wavelet'),colormap(gray);
subplot(2,2,2),imagesc(C3H),title('Horizontal wavelet'),colormap(gray);
subplot(2,2,3),imagesc(C3V),title('Vertical wavelet'),colormap(gray);
subplot(2,2,4),imagesc(C3D),title('Diagonal wavelet'),colormap(gray);