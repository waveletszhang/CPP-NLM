clear
clc
close all
% load test image
path(path,'D:\testimage')

   
sigma=30; 

x0=double(imread('peppers.tif'));    

% add noise
seed=0;
randn('state', seed);
I=x0+sigma*randn(size(x0));
disp(['psnr of noisy image=' num2str(psnr(I,x0,255))])
disp(['ssim of noisy image =' num2str(ssim2009(I,x0))])

 
similarWindowSize = 9;
f = floor(similarWindowSize/2);
searchWindow = 21;
t = floor(searchWindow/2);
h=sigma * 0.4;
h2=sigma*sigma*0.1;
% Pix-NLM 
tic
[O1]=NLmeansfilter(I,2,3,sigma);
toc
disp(['Pixel_NLM psnr =' num2str(psnr(O1,x0,255))])
disp(['Pixel_NLM ssim =' num2str(ssim2009(O1,x0))])
figure(1);imshow(O1,[0 255]);

% Patch-NLM
tic
O2=patchwise_NLM2(I,sigma,2.5*h,similarWindowSize, searchWindow);
toc
disp(['Patch_NLM psnr =' num2str(psnr(O2,x0,255))])
disp(['Patch_NLM ssim =' num2str(ssim2009(O2,x0))])
figure(2);imshow(O2,[0 255]);

tic
O4=Pixel_Patch_NLM(I,sigma,1.0*0.60*h2,similarWindowSize, searchWindow);
toc
disp(['Pixel_Patch_NLM psnr =' num2str(psnr(O4,x0,255))])
disp(['Pixel_Patch_NLM ssim =' num2str(ssim2009(O4,x0))])
xm=min(min(O4(:)));dm=max(max(O4(:)));

figure(3);imshow(x0,[0 255]);figure(2);imshow(O4,[0 255]);
%imwrite(uint8(O4),'D:\Pro-straw10-o4.tif');

w=O1-O4;wf=255*(w-min(min(w(:))))./(max(max(w(:)))-min(min(w(:))));
figure(4);imshow(wf,[0 255]);


