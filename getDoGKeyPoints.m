function [outbin, im1, im2, im3, fsizes] = getDoGKeyPoints(img)

    fsizes = [13 25 49];
    sigmas = [2.5 3.15 3.97 5];
    gaussian1 = fspecial('gaussian',  fsizes(1), sigmas(1)) - ...
        fspecial('gaussian',  fsizes(1), sigmas(2));
    gaussian2 = fspecial('gaussian',  fsizes(2), sigmas(2)) - ...
        fspecial('gaussian',  fsizes(2), sigmas(3));
    gaussian3 = fspecial('gaussian',  fsizes(3), sigmas(3)) - ...
        fspecial('gaussian',  fsizes(3), sigmas(4));

    im1 = conv2(img, gaussian1, 'same');
    im2 = conv2(img, gaussian2, 'same');
    im3 = conv2(img, gaussian3, 'same');
    
    out = im1 & im2 & im3;
    tic;
    [im1 rows1 cols1] = imfindlocalmax(im1, img);
    [im2 rows2 cols2] = imfindlocalmax(im2, img);
    [im3 rows3 cols3] = imfindlocalmax(im3, img);
    toc;
    outbin = im1 | im2 | im3;
    
    figure, subplot(1, 3, 1)
    imshow(im1);
    subplot(1, 3, 2)
    imshow(im2);
    subplot(1, 3, 3)
    imshow(im3);
    
    figure, subplot(1, 2, 1)
    imshow(outbin);
    subplot(1, 2, 2)
    imshow(overlayCircles(img, rows1, cols1, fsizes(1)));
    
end

function [imgout] = overlayCircles(img, rows, cols, radius)

    if(~(size(rows) == size(cols)))
        error('arg error');
    end
    red = uint8([255 0 0]);
    shapeInserter = vision.ShapeInserter('Shape','Circles', ...
        'BorderColor','Custom','CustomBorderColor',red);
    RGB = repmat(img,[1,1,3]); % convert I to an RGB image
    
    circle = [rows(1), cols(1) radius; rows(2) cols(2) radius];
    
    imgout = shapeInserter(RGB, circle);
%     imgout = shapeInserter(RGB, circles);
    imshow(imgout);
end