function []=bright_zky_readAllData()
% bright_zky_readAllData read all data(total as up to 130)
%假如读取F盘English文件夹中的所有bmp图片：
dirr='D:\home\zky_verfCode\' %D:\home\dividedManulForzky
%dirr2='D:\home\dividedManulForzky2\';
x1=ones(10,40);
Files = dir(strcat(dirr,'*.bmp'));
LengthFiles = length(Files)
Xzky=ones(LengthFiles,size(x1,1)*size(x1,2));
yzky=ones(LengthFiles,1);
for i = 1:LengthFiles;
 fileName=Files(i).name
 if strfind(fileName, 'checkcode')>0
    Img0 = imread(strcat(dirr,fileName));
    Imgoo=rgb2gray(Img0);
    Imgoo2=Imgoo/255; %double(
     Xzky(i,:)=Imgoo2(:);
    %for k1=1:size(Imgoo2,1);
     %   for k2=1:size(Imgoo2,2);
     %      if Imgoo2(k1,k2)==0
     %        Xzky2(k1,k2)=' ';
     %      else
     %       Xzky2(k1,k2)=Imgoo2(k1,k2);
     %      end;
     %   end;
    %end;
    %Xzky2(:,1:20)
    %DDDD
    IND = regexp(fileName, '-', 'split'); %img001-00027.pngr
    valuee=char(IND(2))
    %if valuee
    %    valuee(1)=='0'
    %end;
    xxx=str2num(valuee(1:4))
    yzky(i)=xxx;
  end;
 end;
 
 %allocate dataset to training, cross validation and testing.
randIncies=randperm(length(yzky));
randIncies1=randIncies(1:int32(length(yzky)*0.7));
randIncies2=randIncies(int32(length(yzky)*0.7)+1:int32(length(yzky)*0.9));
randIncies3=randIncies(int32(length(yzky)*0.9)+1:end);%索引超出矩阵维度。
Xzky2=Xzky(randIncies1,:);
yzky2=yzky(randIncies1);
XzkyCV=Xzky(randIncies2,:);
yzkyCV=yzky(randIncies2);
XzkyTest=Xzky(randIncies3,:);  
yzkyTest=yzky(randIncies3);
Xzky=Xzky2;
yzky=yzky2;
save ('bright_zky_zkyAllData.mat','Xzky','yzky','XzkyCV','yzkyCV','XzkyTest','yzkyTest');