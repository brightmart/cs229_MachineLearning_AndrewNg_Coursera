function [im]=bright_standard_resizeImage(imo)
%
%imo=imread(dirrr);%读取
s=0.15625;%缩放倍数，缩放后与原始大小的比值
%figure(1)
%imshow(imo);%原图显示
[m n d]=size(imo);
if s<=1 & s>0
    for i=1:d
        im(:,:,i)=imo(round(1:1/s:m),round(1:1/s:n),i);
    end
elseif s>1
    [X Y]=meshgrid(1:n,1:m);
    [Xt Yt]=meshgrid(1:1/s:n,1:1/s:m);
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