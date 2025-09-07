clear
clc
close all

path(path,'D:\testimage')

  
sigma=20; 
x0=double(imread('house.tif'));    


seed=0;
randn('state', seed);
I=x0+sigma*randn(size(x0));
disp(['psnr of noisy image=' num2str(psnr(I,x0,255))])
disp(['ssim of noisy image =' num2str(ssim2009(I,x0))])

 
similarWindowSize = 9;
f = floor(similarWindowSize/2);
searchWindow = 21;
t = floor(searchWindow/2);

h2=sigma*sigma*0.1;


tic
O4=Pixel_Patch_NLM_Fig2c(I,sigma,1.0*0.60*h2,similarWindowSize, searchWindow);
toc

disp(['Pixel_Patch_NLM psnr =' num2str(psnr(O4,x0,255))])
disp(['Pixel_Patch_NLM ssim =' num2str(ssim2009(O4,x0))])


figure(1);imshow(x0,[0 255]);figure(2);imshow(O4,[0 255]);




