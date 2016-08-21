function []=bright_divideSimpleImageForTraining(X,originalPicNumber,stepSize,slidingBlockWidth)
% divide a single image given data as X
%stepSize=4-->8;
%slidingBlockWidth=36;
%保存原图片，以备比较
loc=['D:\english\appleVerfCodeDivided\' num2str(originalPicNumber) '.gif'];
XForSave=X.*255;
imwrite(XForSave,loc); 
size1=size(X,1);
size2=size(X,2);

totalStep=size2/stepSize;
columnStart=0;
columnEnd=0;
for i=1:totalStep;
    columnStart=i*stepSize;
    columnEnd=slidingBlockWidth+i*stepSize;
    if columnEnd>=size2
       XBlock=X(:,columnStart:end);
    else
      XBlock=X(:,columnStart:columnEnd);
    end;
    XBlock=XBlock.*255;
    loc=['D:\english\appleVerfCodeDivided\' num2str(originalPicNumber) '_' num2str(i) '.jpg'];
    imwrite(XBlock,loc); 
end;