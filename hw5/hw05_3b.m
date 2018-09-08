close all;clear all;clc;
img = imread('R._A._Fischer.jpg');
figure(1);imshow(img);
[row col]=size(img);
newimg=zeros(row,col);
img=double(img);
[U,S,V]=svd(img);
K=4;
S1=zeros(size(S));
for idx=1:K
    S1(idx,idx)=S(idx,idx);
end
newimg=U*S1*V';
figure(2);imshow(uint8(newimg));
K=10;
S1=zeros(size(S));
for idx=1:K
    S1(idx,idx)=S(idx,idx);
end
newimg=U*S1*V';
figure(3);imshow(uint8(newimg));