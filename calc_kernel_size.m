function [ ksize ] = calc_kernel_size( sigma )
    ksize = 2 * ceil(3 * sigma) + 1;
end

