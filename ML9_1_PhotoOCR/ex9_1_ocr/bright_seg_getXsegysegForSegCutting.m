function [Xseg yseg Xcv ycv Xtest ytest]=bright_seg_getXsegysegForSegCutting(dirr)
%get all images from special folder. this images was already cutted into
%simple piceses
%假如读取F盘English文件夹中的所有bmp图片：
% dirr='D:\english\appleVerfCode-LabelledForCutting50\'
Files = dir(strcat(dirr,'*.jpg'));
LengthFiles = length(Files);
sizeX1=0;
sizeX2=0;
singleVectorLength=0;
for i = 1:LengthFiles;
    Img = imread(strcat(dirr,Files(i).name));
    sizeImg=size(Img);
    x=double(Img)/255;
    if i==1;
        Xseg=ones(LengthFiles,size(x,1)*size(x,2));
        yseg=ones(LengthFiles,1).*2;
        sizeX1=size(x,1);
        sizeX2=size(x,2);
        singleVectorLength=sizeX1*sizeX2;
    end;
    x=x(:)';
    if length(x)<singleVectorLength
        continue;
    end;
      Xseg(i,:)=x;
    IND = regexp(Files(i).name, '_', 'split');
    if length(IND)==3;
     yreg(i)=1;
    end;
end


 %allocate dataset to training, cross validation and testing.
randIncies=randperm(length(yseg));
randIncies1=randIncies(1:int16(length(yseg)*0.8));
randIncies2=randIncies(int16(length(yseg)*0.8)+1:int16(length(yseg)*0.9));
%lengthYseg=length(yseg)
%startt=int16(length(yseg)*0.8)
randIncies3=randIncies(int16(length(yseg)*0.9)+1:end);%索引超出矩阵维度。
Xseg2=Xseg(randIncies1,:);
yseg2=yseg(randIncies1);
Xcv=Xseg(randIncies2,:);
ycv=yseg(randIncies2);
Xtest=Xseg(randIncies3,:); 
ytest=yseg(randIncies3);
Xseg=Xseg2;
yseg=yseg2;

save('bright_Xseg.mat','Xseg');
save('bright_yseg.mat','yseg');
save('bright_Xcv.mat','Xcv');
save('bright_ycv.mat','ycv');
save('bright_Xtest.mat','Xtest');
save('bright_ytest.mat','ytest');