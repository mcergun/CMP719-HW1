function [out] = getDoGKeyPoints(img, sigma1, fsize, thr)
if ~mod(fsize, 2)
    error('filter size should be odd');
end

imsize = size(img);

dog = fspecial('gaussian', fsize, sigma1) - fspecial('gaussian', fsize, sigma1 + 5);
out = zeros(imsize);
% for n = 1:imsize(3)
% out(:, :, n) = imfilter(img(:, :, n), dog);
% end
out = imfilter(img, dog);
% out(out < thr) = 0;
% out(out >= thr) = 1;
imshow(out);
end