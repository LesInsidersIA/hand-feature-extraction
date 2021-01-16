function [O] = binarization(I)
    level = graythresh(I);
    BW=im2bw(I,level);
    BW=bwareaopen(BW,3);
    %imshow(BW);
    O = BW;
end



