function [XsegSource]=bright_1ReadAllImagesAppleCode(dirr)  
%get all images from special folder. this images was already cutted into
%ysegSource XcvSource ycvSource XtestSource ytestSource
%simple piceses
%假如读取F盘English文件夹中的所有bmp图片：
% 
Files = dir(strcat(dirr,'*.jpeg'));
LengthFiles = length(Files);
for i = 1:LengthFiles;%LengthFiles;
    Img0 = imread(strcat(dirr,Files(i).name));
    Img=rgb2gray(Img0);
    x=double(Img)/255;
    if i==1;
        XsegSource=ones(LengthFiles,size(x,1)*size(x,2));
    end;
    x=x(:)';
    XsegSource(i,:)=x;
end;
save('bright_seg_XsegSource.mat','XsegSource');
end
