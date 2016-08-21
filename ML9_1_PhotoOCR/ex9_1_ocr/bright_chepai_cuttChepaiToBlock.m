function []=function_chepai_cuttChepaiToBlock(dirr)
Files = dir(strcat(dirr2,'*.jpg'));
LengthFiles = length(Files)
for i = 1:LengthFiles%LengthFiles;
fileName=Files(i).name
 if strfind(fileName, 'jpg')>0
     Img0 = imread(strcat(dirr2,fileName));
     sHeight=double(size(x1,1))/double((size(Img0,1)));
     sWidth=double(size(x1,2))/double((size(Img0,2)));
     [Img02]=bright_standard_resizeImage2(Img0,sHeight,sWidth);%resize picture
     sizeImg=size(Img02);
     if numel(sizeImg)==3
        Img02=rgb2gray(Img02);
     end;
     Imgoo2=double(Img02)/255; %double( %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     size1Imgoo2=size(Imgoo2,1);
     size2Imgoo2=size(Imgoo2,2);
    if size1Imgoo2*size2Imgoo2<size(Xchepai(i,:),2)
        Imgoo2=[Imgoo2 ones(size1Imgoo2,1)]; 
    end;
 end;
end;