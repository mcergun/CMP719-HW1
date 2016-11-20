close all;
clc;
clear all;

I = imread('http://www-edlab.cs.umass.edu/~smaji/cmpsci670/fa14/hw/blobs/butterfly.jpg');
sigma = 4;
ksize = calc_kernel_size(sigma);
radius = floor(ksize / 4) * 2 + 1;
I = im_make_gray(I);
I2 = diffofgauss(I, sigma);
tic;
[I3 rows cols] = im_find_localmax(I2, radius);
toc;

figure, subplot(1,2,1)
imshow(I2);
subplot(1,2,2)
imshow(histeq(I2));
figure,
imshow(I3);


im_draw_circles(I, rows, cols, radius);

% figure,
% imshow(I);