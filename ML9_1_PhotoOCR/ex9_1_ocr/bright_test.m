function [XsingelSource]=bright_test()
Img0 = imread(strcat('D:\home\baeDivided\dataAppleCode1461424773714.jpeg'));
Img=rgb2gray(Img0);
XsingelSource=double(Img)/255;
sumOfXsingelSource=sum(XsingelSource);
size1=size(Img,1);
size2=size(Img,2);
XsingelProcessed=zeros(size1,size2);
index=1;
for i=1:size2;
    if sumOfXsingelSource(i)>=60;
        if (i-4)>0 && sumOfXsingelSource(i-4)>=60;       
        end;
    else;
        XsingelProcessed(index)=XsingelSource(index);
        index=index+1;  
    end;
end;
loc=['D:\home\baeDivided\' num2str(1) '.gif'];
XsingelProcessed;
imwrite(XsingelProcessed,loc);
 