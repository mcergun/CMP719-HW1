function [ imout ] = im_make_gray( im )
    if ndims(im) == 3
        im = rgb2gray(im);
    end
    if ~strcmp(class(im), 'double')
        im = double(im);
    end
    if max(im) > 1
        im = im / 255;
    end
    imout = im;
end

