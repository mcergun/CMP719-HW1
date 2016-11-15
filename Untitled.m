clear all;
clc;
close all;
path = 'http://www.artandarchitecture.org.uk/assets/aa_image/320/4/e/3/4/4e342ea047913d066eb734f260b8770fee2a8f34.jpg';
I = im2double(imread(path));
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
Ig12 = conv2(I2, gwindows(:, :, 1), 'same');
Ig22 = conv2(I2, gwindows(:, :, 2), 'same');
Ig32 = conv2(I2, gwindows(:, :, 3), 'same');
Ig42 = conv2(I2, gwindows(:, :, 4), 'same');
Ig52 = conv2(I2, gwindows(:, :, 5), 'same');
Ig13 = conv2(I3, gwindows(:, :, 1), 'same');
Ig23 = conv2(I3, gwindows(:, :, 2), 'same');
Ig33 = conv2(I3, gwindows(:, :, 3), 'same');
Ig43 = conv2(I3, gwindows(:, :, 4), 'same');
Ig53 = conv2(I3, gwindows(:, :, 5), 'same');

Ig121 = Ig1 - Ig2;
Ig231 = Ig2 - Ig3;
Ig341 = Ig3 - Ig4;
Ig451 = Ig4 - Ig5;
Ig122 = Ig12 - Ig22;
Ig232 = Ig22 - Ig32;
Ig342 = Ig32 - Ig42;
Ig452 = Ig42 - Ig52;
Ig123 = Ig13 - Ig23;
Ig233 = Ig23 - Ig33;
Ig343 = Ig33 - Ig43;
Ig453 = Ig43 - Ig53;

figure,
subplot(3,4,1)
imshow(histeq(Ig121));
subplot(3,4,2)
imshow(histeq(Ig231));
subplot(3,4,3)
imshow(histeq(Ig341));
subplot(3,4,4)
imshow(histeq(Ig451));
subplot(3,4,5)
imshow(histeq(Ig122));
subplot(3,4,6)
imshow(histeq(Ig232));
subplot(3,4,7)
imshow(histeq(Ig342));
subplot(3,4,8)
imshow(histeq(Ig452));
subplot(3,4,9)
imshow(histeq(Ig123));
subplot(3,4,10)
imshow(histeq(Ig233));
subplot(3,4,11)
imshow(histeq(Ig343));
subplot(3,4,12)
imshow(histeq(Ig453));