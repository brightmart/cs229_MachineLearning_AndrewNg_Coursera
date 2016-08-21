function []=bright_standard_readAllData2()
%Xstand ystand XstandCV ystandCV XstandTest ystandTest
% standard_readAllData read all data(total as up to 60,000)
%假如读取F盘English文件夹中的所有bmp图片：
dirr='D:\home\EnglishFnt.tgz\English\SampleAll\' %D:\home\dividedManulForstand
%dirr2='D:\home\dividedManulForstand2\';
x1=ones(20,20);
Files = dir(strcat(dirr,'*.png'));
LengthFiles = length(Files)
Xstand=ones(LengthFiles,size(x1,1)*size(x1,2));
ystand=ones(LengthFiles,1);
for i = 1:LengthFiles;
 if mod(i,5000)==0
     i
 end;
 fileName=Files(i).name; 
 if strfind(fileName, 'img')>0
    Img0 = imread(strcat(dirr,fileName));
    [im]=bright_standard_resizeImage(Img0);%resize from 128*128 to 20*20
     Xstand(i,:)=double(im(:))/255;
    IND = regexp(fileName, '-', 'split'); %img001-00027.png
    valuee=char(IND(1));
    xxx=str2num(valuee(4:6));
    ystand(i)=xxx;
  end;
 end;
 
 %allocate dataset to training, cross validation and testing.
randIncies=randperm(length(ystand));
randIncies1=randIncies(1:int32(length(ystand)*0.6));
randIncies2=randIncies(int32(length(ystand)*0.6)+1:int32(length(ystand)*0.8));
randIncies3=randIncies(int32(length(ystand)*0.8)+1:end);%索引超出矩阵维度。
Xstand2=Xstand(randIncies1,:);
ystand2=ystand(randIncies1);
XstandCV=Xstand(randIncies2,:);
ystandCV=ystand(randIncies2);
XstandTest=Xstand(randIncies3,:);  
ystandTest=ystand(randIncies3);
Xstand=Xstand2;
ystand=ystand2;
save ('bright_standard_standAllData.mat','Xstand','ystand','XstandCV','ystandCV','XstandTest','ystandTest');