close all;
clear all;
clc;

%% Image input
% We take a RGB image as input and convert it to grayscale and store it in
% another variable, so we can get the mean luminance.

rgbImage=load_image;
rgbImage=im2double(rgbImage);
grayImage = rgb2gray(rgbImage); 
%% White Balancing
% Extract the individual red, green, and blue color channels.
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

meanR = mean2(redChannel);
meanG = mean2(greenChannel);
meanB = mean2(blueChannel);
meanGray = mean2(grayImage);

% Make all channels have the same mean
redChannel = (double(redChannel) * meanGray / meanR);
greenChannel = (double(greenChannel) * meanGray / meanG);
blueChannel = (double(blueChannel) * meanGray / meanB);

%redChannel and blueChannel Correction
redChannel=redChannel-0.3*(meanG-meanR).*greenChannel.*(1-redChannel);
blueChannel=blueChannel+0.3*(meanG-meanB).*greenChannel.*(1-blueChannel);


% Recombine separate color channels into a single, true color RGB image.
rgbImage_white_balance = cat(3, redChannel, greenChannel, blueChannel);

% figure('Name','Color Enhancement');
% subplot(121);
% imshow(rgbImage);
% title('original');

% subplot(122);
% imshow(rgbImage_white_balance);
% title('White balancing');
%-------------------------------------------------------------
I = imadjust(rgbImage_white_balance,[],[],0.5);
            
J=(rgbImage_white_balance+(rgbImage_white_balance-imgaussfilt(rgbImage_white_balance)));

figure();
subplot(221);
imshow(rgbImage);
title('Original Image');

subplot(131);
imshow(rgbImage_white_balance);
title('I. White Balance');

subplot(132);
imshow(I);
title('COLOR Corrected');
subplot(133);
imshow(J);
title('COLOR Corrected+Sharpened');
%exposed
WE2 = expo(J);
figure;imshow(WE2,[]);
%saliency
WS1 = saliency_detection(J);
figure;imshow(WS1,[]);
% laplacian
WP1=laplacian(J);