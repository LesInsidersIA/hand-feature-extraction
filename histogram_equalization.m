function [O] = histogram_equalization(I)
    if length(size(I))~=2;
        I = rgb2gray(I);
    end
    I = im2double(I);
    w = 32;
    M = mean2(I);
    z = colfilt(I, [w,w], 'sliding', @std);
    m = colfilt(I, [w,w], 'sliding', @mean);
    A = M./z;
    O = A.*(I-m)+m;
end

