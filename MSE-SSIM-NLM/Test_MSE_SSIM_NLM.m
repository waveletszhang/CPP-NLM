close all;
clear
clc

I=double(imread('D:\testimage\peppers.tif'));
seed=0;
randn('state', seed);
si=10;
noisy=double(I+si*randn(size(I)));

%  t: radio of search window
%  f: radio of similarity window
t=5;
f=3;

tic
msessimnlm= MSE_SSIM(noisy,t,f,si,si*si);
toc

psnr_pro = psnr(double(I),double(msessimnlm),255);
ssim_pro = ssim2009(double(I), double(msessimnlm)); 

figure;imshow(uint8(msessimnlm));
