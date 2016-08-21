function [seg_X]=bright_charaSeg_gainSourceImageAsXFDirr(dirr)
%GAINXYFROMDIRR gain X and y from dir of images
%假如读取F盘English文件夹中的所有bmp图片：
%'D:\\home\bae\\'
Files = dir(strcat(dirr,'*.jpeg'));
LengthFiles = length(Files)
for i = 1:LengthFiles;%LengthFiles
    Img = imread(strcat(dirr,Files(i).name));
    x=rgb2gray(Img);
    x=double(x)/255;
    if i==1
       seg_X=zeros(LengthFiles,size(x,1)*size(x,2));
    end;
    x=x(:)';
    seg_X(i,:)=x;
end
save('bright_seg_X.mat','seg_X');