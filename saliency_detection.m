function sm = saliency_detection(img)
% Read image and blur it with a 3x3 or 5x5 Gaussian filter

% img = load_image
gfrgb = imfilter(img, fspecial('gaussian', 3, 3), 'symmetric', 'conv');

cform = makecform('srgb2lab');
lab = applycform(gfrgb,cform);
%---------------------------------------------------------
% Compute Lab average values (note that in the paper this
% average is found from the unblurred original image, but
% the results are quite similar)
%---------------------------------------------------------
l = double(lab(:,:,1)); lm = mean(mean(l));
a = double(lab(:,:,2)); am = mean(mean(a));
b = double(lab(:,:,3)); bm = mean(mean(b));
%---------------------------------------------------------
% Finally compute the saliency map and display it.
%---------------------------------------------------------
sm = (l-lm).^2 + (a-am).^2 + (b-bm).^2;
imshow(sm,[]);
title('saliency weight')
%---------------------------------------------------------