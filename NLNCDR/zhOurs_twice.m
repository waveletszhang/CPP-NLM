
clear,close all

num = 1;
noise_level = 10;

x0 = double(imread('D:\testimage\peppers.tif'));

randn('seed', 0);
y           = double(x0+noise_level*randn(size(x0))); 

%%%------------------------------------------------------------------------
%%% Set Parameters
%%%------------------------------------------------------------------------
% Parameters for calculating w(x,y)
global W;
t = 2;                  % Search_size : 2*t+1;
f = 1;                  % Patch size  : 2*f+1;
h1 = 1;                 % Standard deviation of Gaussian kernel
h2 = 0.2*1.0;               % Threshold for distance
selfsim = 0;
% Parameters for updating a(x)
sigamma   = 5;          
M         = 1e3;        
% Other parameters
method    = 2;          % 1: STV1; 2: NCDR
alpha     = 1e3;        % Used for preprocessing
iter      = 1e3;        % The iteration number of GD 
lamda_pre = 22;         
lamda     = 4*1;  %1£¬3

tic
%%%------------------------------------------------------------------------
%%% Pre-processing via NCDR with fixed a(x)
%%%------------------------------------------------------------------------
xd = Ours( y, lamda_pre, alpha, method, iter, 0);  

%%%------------------------------------------------------------------------
%%% Update a(x) using the pre-processed image
%%%------------------------------------------------------------------------
temp = xd;
x_gradient_abs = forward_diff(temp,1,1).^2 + forward_diff(temp,1,2).^2 + forward_diff(temp,1,3).^2;
x_gradient_abs = sqrt(x_gradient_abs+sqrt(eps));
alpha = M * exp(-(x_gradient_abs).^2/sigamma^2);

%%%------------------------------------------------------------------------
%%% Update a(x) using the pre-processed image
%%%------------------------------------------------------------------------
W = cal_W(xd/max(xd(:)),t,f,h1,h2,selfsim); 

%%%------------------------------------------------------------------------
%%% Image Denoising via NL_NCDR
%%%------------------------------------------------------------------------
% Denoising using Ours method
x = Ours( y, lamda, alpha, method, iter, 1); 
time=toc

PSNR_NLNCDR = psnr(x,x0,255);
[mssim2, ssim_map2] = ssim2009(x,x0);
figure;
subplot(1,2,1); imshow(y,[]);
subplot(1,2,2); imshow(x,[]);

%imwrite(uint8(x),'D:\NCDR-goldhill.tif','tif');