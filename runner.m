pkg load image;
close all;
im = rgb2gray(imread('https://rorasa.files.wordpress.com/2011/02/spatial.png'));

fsize = 11;
sigma1 = 2^(1/4);

imsize = size(im);
unity = zeros([fsize fsize]);
unity(ceil(fsize / 2), ceil(fsize / 2)) = 1;
dog0 = unity - ...
  fspecial('gaussian', fsize, sigma1);
dog1 = fspecial('gaussian', fsize, sigma1) - ...
  fspecial('gaussian', fsize, sigma1 ^ 2);
dog2 = fspecial('gaussian', fsize, sigma1 ^ 2) - ...
  fspecial('gaussian', fsize, sigma1 ^ 3);
dog3 = fspecial('gaussian', fsize, sigma1 ^ 3) - ...
  fspecial('gaussian', fsize, sigma1 ^ 4);
out1 = zeros(imsize);
out2 = zeros(imsize);
out3 = zeros(imsize);
cim = harris(im, 1, 200, 6);
%for n = 1:imsize(3)
%out0(:, :, n) = conv2(im(:, :, n), dog0, 'same');
%out1(:, :, n) = conv2(im(:, :, n), dog1, 'same');
%out2(:, :, n) = conv2(im(:, :, n), dog2, 'same');
%out3(:, :, n) = conv2(im(:, :, n), dog3, 'same');
%end
out0 = conv2(im, dog0, 'same');
out1 = getDoGKeyPoints(im, 20, 21);
out2 = conv2(im, dog2, 'same');
out3 = conv2(im, dog3, 'same');

%out4 = getDoGKeyPoints(im, 15, 21);
% out(out < thr) = 0;
% out(out >= thr) = 1;
subplot(2,2,1);
imshow(out1);
imshow(out0);
subplot(2,2,2);
imshow(out1);
subplot(2,2,3);
imshow(out2);
subplot(2,2,4);
imshow(out3);

figure, imshow(cim);