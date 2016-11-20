function [ outim ] = im_draw_circles( im, rows, cols, radius )
    if ~(size(rows) == size(cols))
        error('arg error');
    end
    
    h = figure();
    imshow(im);
    hold on;
    
    th = 0:pi/50:2*pi;
    for n=1:size(rows, 1)
        xunit = radius * cos(th) + cols(n);
        yunit = radius * sin(th) + rows(n);
        plot(xunit, yunit);
    end
    hold off;
    outim = frame2im(getframe(h));
%     close(h);
end

