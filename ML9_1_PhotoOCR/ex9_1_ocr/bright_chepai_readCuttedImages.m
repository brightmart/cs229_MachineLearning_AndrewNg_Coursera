function [XchepaiBlock,ychepaiBlock,XchepaiBlockCV,ychepaiBlockCV,XchepaiBlockTest,ychepaiBlockTest]=bright_chepai_readCuttedImages(dirr2)
%dirr2='D:\home\chepaiCut\' 
x1=ones(20,60);%(14*1.5,44*1.5); %87*32 -->60*22.06897
Files = dir(strcat(dirr2,'*.*'));
LengthFiles = length(Files)
XchepaiBlock=ones(LengthFiles,size(x1,1)*size(x1,2));
ychepaiBlock=ones(LengthFiles,1)*2;
for i = 1:LengthFiles
 fileName=Files(i).name;
 if( strfind(fileName, 'jpg')>0 | strfind(fileName, 'gif')>0)
     %keyboard;
    Img0 = imread(strcat(dirr2,fileName));
    sHeight=double(size(x1,1))/double((size(Img0,1)));
    sWidth=double(size(x1,2))/double((size(Img0,2)));
    [Img02]=bright_standard_resizeImage2(Img0,sHeight,sWidth);%resize picture
    mysize=size(Img02);
    if numel(mysize)>2  
        Img02=rgb2gray(Img02); 
    end;
    Imgoo2=double(Img02)/255; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    size1Imgoo2=size(Imgoo2,1);
    size2Imgoo2=size(Imgoo2,2);
    if size1Imgoo2*size2Imgoo2<size(XchepaiBlock(i,:),2);
       Imgoo2=[Imgoo2 ones(size1Imgoo2,1)]; 
    end;
    %sizeImgoo2=size(Imgoo2)
    %sizeXchepaiBlocki=size(XchepaiBlock(i,:))
    XchepaiBlock(i,:)=Imgoo2(:);
     IND = regexp(Files(i).name, '_', 'split');
     if length(IND)==3;
        ychepaiBlock(i)=1;
     end;
  end;
 end;
 %allocate dataset to training, cross validation and testing.
randIncies=randperm(length(ychepaiBlock));
randIncies1=randIncies(1:int32(length(ychepaiBlock)*0.80));
randIncies2=randIncies(int32(length(ychepaiBlock)*0.80)+1:int32(length(ychepaiBlock)*0.95));
randIncies3=randIncies(int32(length(ychepaiBlock)*0.95)+1:end);
XchepaiBlock2=XchepaiBlock(randIncies1,:);
ychepaiBlock2=ychepaiBlock(randIncies1,:);
XchepaiBlockCV=XchepaiBlock(randIncies2,:);
ychepaiBlockCV=ychepaiBlock(randIncies2,:);
XchepaiBlockTest=XchepaiBlock(randIncies3,:);  
ychepaiBlockTest=ychepaiBlock(randIncies3,:);
XchepaiBlock=XchepaiBlock2;
ychepaiBlock=ychepaiBlock2;
save ('bright_chepai_chepaiBlocsAllData.mat','XchepaiBlock','ychepaiBlock','XchepaiBlockCV','ychepaiBlockCV','XchepaiBlockTest','ychepaiBlockTest');