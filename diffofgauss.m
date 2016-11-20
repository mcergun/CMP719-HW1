function [ outim ] = diffofgauss( im, sigma )
    im = im_make_gray(im);
    sigma2 = sigma * power(2, 1/3);
    ksize1 = calc_kernel_size(sigma);
    ksize2 = calc_kernel_size(sigma2);
    gaussian1 = fspecial('gaussian', 21, 15);
    gaussian2 = fspecial('gaussian', 21, 20);
    
    im1 = conv2(im, gaussian1, 'same');
    im2 = conv2(im, gaussian2, 'same');
    
    outim = im1 - im2;
%     outim = sqrt(abs(im1 - im2));
end

