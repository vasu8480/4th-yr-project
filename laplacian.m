function I = laplacian(img)
%Inporting Image
%  img = load_image;
IMG = img(:,:,1);
%Backup original image

%Laplacian Filter Masks
W = [0 1 0;1 -4 1; 0 1 0];
%W = [1 1 1;1 -8 1; 1 1 1];

%Padding the boundary with zeros
IMG = padarray(IMG,[1,1]);

IMG1 = IMG;
I = zeros(size(IMG));
IMG = double(IMG);

%Computing the Laplasian mask
for i = 2:size(IMG,1)-1
    for j = 2:size(IMG,2)-1
       
        I(i,j) = sum(sum(W .* IMG(i-1:i+1,j-1:j+1)));       
    end
end
I = uint8(I);
%Gradient Filter Masks
W = [-1 -2 -1; 0 0 0; 1 2 1];
I = zeros(size(IMG));
IMG = double(IMG);

%Computing the Laplasian mask
for i = 2:size(IMG,1)-1
    for j = 2:size(IMG,2)-1     
        I(i,j) = sum(sum(W .* IMG(i-1:i+1,j-1:j+1)));       
    end
end
imshow(I);
title('Global Contrast');
end