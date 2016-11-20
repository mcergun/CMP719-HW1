function [outim rows cols] = im_find_localmax(im, windowsize)
if ~mod(windowsize, 2)
    error('arg error');
end
% im = im > 1e-5;
window = ones(windowsize);
mid = ceil(windowsize / 2);
window(mid, mid) = 0;
outim = im > imdilate(im, window);
[rows cols] = find(outim);
end