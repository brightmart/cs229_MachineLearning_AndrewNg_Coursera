function [XBlocks]=bright_divideSingleImageUsingModel()
% divide a single image using model trained.
%XsingelSource=
%load('bright_seg_XsegSource.mat');
%XsingelSource=XsegSource(4881,:);
Img0 = imread(strcat('D:\home\baeDivided\standTemp\1.gif'));
%Img=rgb2gray(Img0);
XsingelSource=double(Img0)/255;
targetDir='D:\home\baeDivided\standTemp\';
originalPicNumber=3;
stepSize=4;%8;  
slidingBlockWidth=28;%28
load('bright_Theta1_CharacterSeg.mat');
load('bright_Theta2_CharacterSeg.mat');
%Theta1,
%Theta2
%保存原图片，以备比较
loc=[targetDir num2str(originalPicNumber) num2str(originalPicNumber) '.gif'];
%X=Xsingle;
X=reshape(XsingelSource,70,160);
XForSave=X.*255;
imwrite(XForSave,loc); 
size1=size(X,1);
size2=size(X,2);

totalStep=size2/stepSize;
columnStart=0;
columnEnd=0;
count=1;
%XBlock=XsingelSource;
previousXBlock=XsingelSource;
middlePoint=1;
lastMiddlePoint=1;
breakpointt=10;    
for i=1:totalStep;
    columnStart=i*stepSize;
    columnEnd=i*stepSize+slidingBlockWidth;
    if columnEnd>=size2
        XX=X(:,columnStart:end);
        sizeXX=size(XX)
        oness=ones(70,(slidingBlockWidth+1-(size(XX,2))));
        sizeOness=size(oness)
       XBlock=[XX oness];
       sizeXBlock=size(XBlock)
       columnEnd=size(sizeXBlock,2);
       i=totalStep;
       %break;
    else
      XBlock=X(:,columnStart:columnEnd);
      sizeXBlockNormal=size(XBlock)
    end;
    predTest = predict(segTheta1, segTheta2, XBlock(:)');
    if predTest==1  % if it should divide, then divide it and save it; else continue using sliping window way to skip image.
       middlePoint=(columnStart+columnEnd)/2;
       if middlePoint-lastMiddlePoint>=breakpointt %防止过分切割
         %lastMiddlePoint
         middlePoints(count)=middlePoint
         count=count+1;
         %size(X)
         %XBlockForSaving2=X(:,columnStart:columnEnd);%X(:,lastMiddlePoint,middlePoint);
         %imwrite(XBlockForSaving2.*255,loc); %XBlock
         lastMiddlePoint=middlePoint;
       end;
    end;
end;

tempPreviousMiddlePoint=1;
tempMiddlePoint=1;
lengthMiddlePoints=length(middlePoints)
for j=1:length(middlePoints);
    tempMiddlePoint=middlePoints(j)
    %tempPreviousMiddlePoint
    XBlockForSaving3=X(:,tempPreviousMiddlePoint:tempMiddlePoint);
    loc=[targetDir num2str(j) '.gif'];
    imwrite(XBlockForSaving3.*255,loc); %XBlock
    tempPreviousMiddlePoint=tempMiddlePoint;  
end;
       XBlockForSaving3=X(:,tempPreviousMiddlePoint:end); 
       loc=[targetDir num2str(length(middlePoints)+1) '.gif'];
       imwrite(XBlockForSaving3.*255,loc); %XBlock
  
%save('bright_seg_XBlocks.mat','XBlocks');
