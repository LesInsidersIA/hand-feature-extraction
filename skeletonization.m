function [O] = skeletonization(I)
    % use morphological function [LAM 92]
    squelet = bwmorph(~I,'thin','inf');
    
    squelet = bwareaopen(squelet, 30);
    
    O = squelet;
end


