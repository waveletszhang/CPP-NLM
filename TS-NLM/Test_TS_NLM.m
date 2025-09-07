clear;clc
close all  
%
clean=imread('D:\testimage\CPPNLM\man.tif');
%clean=imread('D:\testimage\Parrot.png');
%clean=imread('D:\testimage\Set12\12.png');

CleanImg = im2double(clean);

Sigma = 10/255;PatchSizeHalf = 9; SearchSizeHalf = 5;BlockSizeHalf = 13;BLambdaSqRatio = 1.00*0.50;
randn('seed', 0);
NoisyImg = CleanImg+randn(size(CleanImg))*Sigma;
tic
s=0.82;
DenoisedImg = TS_1(NoisyImg,PatchSizeHalf,SearchSizeHalf,s*Sigma,BlockSizeHalf,BLambdaSqRatio);%0.88
DenoisedImg = TS_2(DenoisedImg.heur,1,2,1.00*((1.00-s^2)^0.5)*Sigma,5,BLambdaSqRatio);
time=toc

denoised=DenoisedImg.one;
PSNR1 = psnr(double(255*NoisyImg),double(clean),255)
[mssim1, ssim_map1] = ssim2009(double(clean), double(255*NoisyImg)); 
PSNR2 = psnr(double(255*denoised),double(clean),255)
[mssim11, ssim_map11] = ssim2009(double(clean), double(255*denoised)); 

fi=255*denoised;
figure;imshow(uint8(fi))
%imwrite(uint8(mz),'D:\pro-mz-30.tif','tif')
