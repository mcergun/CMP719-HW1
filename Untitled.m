clear all;
clc;
close all;
path = 'D:\workspace\CMP719\HW1\symbench_v1\symbench_v1\essighaus\01.png';
I = im2double(rgb2gray(imread(path)));
% g = fspecial('gaussian', 13, 2);
% g2 = fspecial('gaussian', 19, 3);
% I2 = conv2(I, g, 'same');
% I3 = conv2(I, g2, 'same');
I2 = imresize(I, 0.5);
I3 = imresize(I, 0.25);
figure,
subplot(1,3,1)
imshow(I);
subplot(1,3,2)
imshow(I2);
subplot(1,3,3)
imshow(I3);
% s + 2 filters
% s + 1 difference images
s = 3;
sigmas = zeros(s + 2, 1);
sigmas(1) = 2;
for n=2:s+2
    sigmas(n) = 2^((n -1) / s) * sigmas(1);
end

gsize = ceil(sigmas(s + 2) * 6)
if ~mod(gsize, 2)
    gsize = gsize + 1
end

gwindows = zeros(gsize, gsize, s + 2);

for n=1:s+2
    gwindows(:, :, n) = fspecial('gaussian', gsize, sigmas(n));
end
Ig1 = conv2(I, gwindows(:, :, 1), 'same');
Ig2 = conv2(I, gwindows(:, :, 2), 'same');
Ig3 = conv2(I, gwindows(:, :, 3), 'same');
Ig4 = conv2(I, gwindows(:, :, 4), 'same');
Ig5 = conv2(I, gwindows(:, :, 5), 'same');

Ig12 = Ig1 - Ig2;
Ig23 = Ig2 - Ig3;
Ig34 = Ig3 - Ig4;
Ig45 = Ig4 - Ig5;

figure,
subplot(1,4,1)
imshow(histeq(Ig12));
subplot(1,4,2)
imshow(histeq(Ig23));
subplot(1,4,3)
imshow(histeq(Ig34));
subplot(1,4,4)
imshow(histeq(Ig45));