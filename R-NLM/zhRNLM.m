clear all
close all

addpathrec('.')

% Load image

img=double(imread('D:\testimage\CPPNLM\boat.tif'));

% Generate noisy image
randn('seed', 0);
[img_nse, noise] = noisegen(img, 'gauss', 20);


% Perform denoising
param.wait = waitbar(0, 'RNL denoising...');
tic
img_rnl = rnl(img_nse, noise, param);
time=toc
close(param.wait);

PSNR2 = psnr(img,img_rnl,255)
[mssim, ssim_map] = ssim2009(img,double(img_rnl));


%imwrite(uint8(img_rnl),'D:\RNL-barbara-30.tif','tif');
figure;imshow(uint8(img_rnl))
