close all;
clear
clc


I=double(imread('D:\testimage\straw.tif'));


I(200,92:110)=255;
I(220,92:110)=255;
I(200:220,92)=255;
I(200:220,110)=255;

figure;imshow(uint8(I));
%imwrite(uint8(I),'D:\Mark-straw.tif');