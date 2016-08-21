function []=bright_zky_wholeProcess()
%whole process: read a new image, sure image, cut it, and make a predict
%1.read a new image
dirr='D:\home\zky_verfCode\checkcode1135-2437.bmp'
Img0=imread(dirr);%∂¡»°
 Imgoo=rgb2gray(Img0);
 Imgoo2=Imgoo/255; %double
 x=Imgoo2(:)';
%2.show image
%3.cut image into 4 images.
numbersFromAImage=4;
temp=ones(1,length(x)/numbersFromAImage);
load('bright_zky_data_Theta1Theta2.mat');
result=zeros(1,4); 
size2=length(x);
dirr='D:\home\zky_verfCode\';
Files = dir(strcat(dirr,'*.bmp'));
LengthFiles = length(Files)
for i = 1:LengthFiles;
   fileName=Files(i).name
 if strfind(fileName, 'checkcode')>0
     Img0 = imread(strcat(dirr,fileName));
     %Img0=imread(dirr);%∂¡»°
     Imgoo=rgb2gray(Img0);
     Imgoo2=Imgoo/255; %double
     x=Imgoo2(:)';
     for j=1:numbersFromAImage;
       temp= x(1,(j-1)*(size2/numbersFromAImage)+1:j*(size2/numbersFromAImage));
        predTrainzky = predict(zkyTheta1, zkyTheta2, double(temp))
        result(j)=predTrainzky;
      end;
      imshow(Img0);
      title(result); 
       pause;
  end;
end;

