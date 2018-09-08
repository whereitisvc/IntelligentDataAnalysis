close all;clear all;clc;
cv=4;
%cv=32;
img = imread('R._A._Fischer.jpg');
figure(1);imshow(img);
[row col]=size(img);
newimg=zeros(row,col);
Num_of_blocks=1;
blocks=zeros(row*col/4,4);
for r=1:2:row-1
    for c=1:2:col-1
        blocks(Num_of_blocks,:)=[img(r,c:c+1) img(r+1,c:c+1)];
        Num_of_blocks=Num_of_blocks+1;
    end
end
Num_of_blocks=1;
[IDX C]=kmeans(blocks,cv);
for r=1:2:row-1
    for c=1:2:col-1
        newimg(r,c:c+1)  =C(IDX(Num_of_blocks,1),1:2);
        newimg(r+1,c:c+1)=C(IDX(Num_of_blocks,1),3:4);
        Num_of_blocks=Num_of_blocks+1;
    end
end
figure(2);imshow(uint8(newimg));