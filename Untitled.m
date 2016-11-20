clear all;
clc;
close all;
path = 'http://i.stack.imgur.com/8rLG8.jpg';
I = im2double(rgb2gray(imread(path)));
% g = fspecial('gaussian', 13, 2);
% g2 = fspecial('gaussian', 19, 3);
% I2 = conv2(I, g, 'same');
% I3 = conv2(I, g2, 'same');
I2 = imresize(I, 0.5);
I3 = imresize(I, 0.25);
%figure,
%subplot(1,3,1)
%imshow(I);
%subplot(1,3,2)
%imshow(I2);
%subplot(1,3,3)
%imshow(I3);
% s + 2 filters
% s + 1 difference images
s = 3;
sigmas = zeros(s + 2, 1);
sigmas(1) = 2.5;
for n=2:s+2
    sigmas(n) = 2^((n -1) / s) * sigmas(1)
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

Igtotal1 = imfindlocalmax(Ig121 .* Ig231 .* Ig341 .* Ig451, I);
Igtotal2 = imfindlocalmax(Ig122 .* Ig232 .* Ig342 .* Ig452, I);
Igtotal3 = imfindlocalmax(Ig123 .* Ig233 .* Ig343 .* Ig453, I);

%figure,
%subplot(3,4,1)
%imshow((Ig121));
%subplot(3,4,2)
%imshow((Ig231));
%subplot(3,4,3)
%imshow((Ig341));
%subplot(3,4,4)
%imshow((Ig451));
%subplot(3,4,5)
%imshow((Ig122));
%subplot(3,4,6)
%imshow((Ig232));
%subplot(3,4,7)
%imshow((Ig342));
%subplot(3,4,8)
%imshow((Ig452));
%subplot(3,4,9)
%imshow((Ig123));
%subplot(3,4,10)
%imshow((Ig233));
%subplot(3,4,11)
%imshow((Ig343));
%subplot(3,4,12)
%imshow((Ig453));

figure,
subplot(1,3,1)
imshow((Igtotal1));
subplot(1,3,2)
imshow((Igtotal2));
subplot(1,3,3)
imshow((Igtotal3));

[imout imout2] = imfindlocalmax(Ig343, I3);

figure,
imshow(I);
hold on;
imshow(imout2);



clear all;