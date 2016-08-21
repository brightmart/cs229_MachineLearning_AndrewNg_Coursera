function []=bright_divideImage(SuperX,stepSize,slidingBlockWidth,rowsOfSingleImage,columnsOfSingleImage)
%DIVIDE IMAGE: divide images by calling divideSimpleImage
size1=size(SuperX,1);% number of rows
%size2=size(SuperX,2);% number of columns
%rowsOfSingleImage=70;
%columnsOfSingleImage=160;
simpleX=ones(rowsOfSingleImage,columnsOfSingleImage);% size of single being-proceeded image.
for i=1:size1
    simpleX=reshape(SuperX(i,:),rowsOfSingleImage,columnsOfSingleImage);
    bright_divideSimpleImage(simpleX,i,stepSize,slidingBlockWidth);
end;
