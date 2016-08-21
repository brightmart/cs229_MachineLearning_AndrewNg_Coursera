function [im]=bright_standard_resizeImage2(Img0,sHeight,sWidth) %imo
%
%imo=imread(dirrr);%读取
%s=0.15625;%缩放倍数，缩放后与原始大小的比值
%dirr='D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\';
%fileName='鄂AAD198.jpg';
%Img0 = imread(strcat(dirr,fileName));
%figure(1)
%imshow(Img0);%原图显示
 %Imgoo=rgb2gray(Img0);
 %Imgoo2=Imgoo/255 %double(
%sHeight=0.1041666*5;
%sWidth=0.078125*5;
s=sHeight;
imo=Img0;
[m n d]=size(imo);
if s<=1 & s>0
    for i=1:d
        im(:,:,i)=imo(round(1:1/s:m),round(1:1/sWidth:n),i);
    end
elseif s>1
    [X Y]=meshgrid(1:n,1:m);
    [Xt Yt]=meshgrid(1:1/s:n,1:1/sWidth:m);
    for i=1:d
        im(:,:,i)=interp2(double(imo(:,:,i)),Xt,Yt,'spline');
    end
    if isa(imo,'uint8')
        im=uint8(im);
    else 
        im=uint16(im);
    end
end
%figure(2)
%imshow(im);%缩放图显示