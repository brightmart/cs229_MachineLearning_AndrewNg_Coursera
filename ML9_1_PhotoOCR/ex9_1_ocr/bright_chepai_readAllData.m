function [Xchepai,ychepai,XchepaiCV,ychepaiCV,XchepaiTest,ychepaiTest]=bright_chepai_readAllData(dirr2)
%dirr2='D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\' 
x1=ones(30*6,40*6);
Files = dir(strcat(dirr2,'*.jpg'));
LengthFiles = length(Files)
Xchepai=ones(LengthFiles,size(x1,1)*size(x1,2));
lengthOfChepai=7;
labelsMap = bright_chepai_loadIdsList();
ychepai=zeros(LengthFiles,lengthOfChepai);
count=1;
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
    sizeImgoo2=size(Imgoo2)
    sizeXchepaii=size(Xchepai(i,:))
    if length( Xchepai(i,:))==length(Imgoo2(:))
        Xchepai(i,:)=Imgoo2(:);
    else
        count=count+1
        continue;
    end;
    chePai=fileName(1:lengthOfChepai);
    chePaiAsNums=zeros(1,lengthOfChepai);
    for j=1:lengthOfChepai;
        chePaiJ=chePai(j);
        addi=labelsMap(char(chePaiJ));
        chePaiAsNums(j)=addi;
    end;
    %chePaiAsNums
    ychepai(i,:)=chePaiAsNums;
  end;
 end;
 %allocate dataset to training, cross validation and testing.
randIncies=randperm(length(ychepai));
randIncies1=randIncies(1:int32(length(ychepai)*0.8));
randIncies2=randIncies(int32(length(ychepai)*0.8)+1:int32(length(ychepai)*0.95));
randIncies3=randIncies(int32(length(ychepai)*0.95)+1:end);%索引超出矩阵维度。
Xchepai2=Xchepai(randIncies1,:);
ychepai2=ychepai(randIncies1,:);
XchepaiCV=Xchepai(randIncies2,:);
ychepaiCV=ychepai(randIncies2,:);
XchepaiTest=Xchepai(randIncies3,:);  
ychepaiTest=ychepai(randIncies3,:);
Xchepai=Xchepai2;
ychepai=ychepai2;
save ('bright_chepai_chepaiAllData.mat','Xchepai','ychepai','XchepaiCV','ychepaiCV','XchepaiTest','ychepaiTest');