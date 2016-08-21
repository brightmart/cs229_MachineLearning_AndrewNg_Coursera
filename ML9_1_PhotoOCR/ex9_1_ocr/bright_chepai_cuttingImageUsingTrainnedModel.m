function []=bright_chepai_cuttingImageUsingTrainnedModel(dirr2,stepSize,slidingBlockHeight,slidingBlockWidth)
% stepSize=4;slidingBlockHeight=20;slidingBlockWidth=60;
%chepai_cuttingImageToGetTrainImage
singlePictureRows=30*6;
singPictureColumns=40*6;

[Xchepai,ychepai,XchepaiCV,ychepaiCV,XchepaiTest,ychepaiTest]=bright_chepai_readAllData(dirr2);
%load('bright_chepai_chepaiAllData.mat'); %get Xchepai,XchepaiCV for cutting using sliding window.
size1=size(Xchepai,1);
size2=size(Xchepai,2);
x=zeros(singlePictureRows,singPictureColumns);
columnStart=0;
columnEnd=0;
load('bright_chepai_data_Theta1Theta2.mat');
count=1;
maxProbability=0;
x1=ones(slidingBlockHeight,slidingBlockWidth); 
slidingBlockWidthO=slidingBlockWidth;
slidingBlockHeightO=slidingBlockHeight;
counttt=1;
for i=1:size1;
    %keyboard;
    minProbabilityNotTureP=1;
    %secondBestBlock=zeros(slidingBlockHeight,slidingBlockWidth);
    slidingBlockWidth=slidingBlockWidthO;
    slidingBlockHeight=slidingBlockHeightO;
    bestXBlock=zeros(slidingBlockHeight,slidingBlockWidth);
    maxProbability=0;
    x=reshape(Xchepai(i,:),singlePictureRows,singPictureColumns);   
    %sizeX=size(x)
    %keyboard;
    %imshow(x);
    loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel66\' num2str(i) '_' num2str(i) '.jpg'];
    imwrite(x,loc);
    %%%%%%%%%%%%%%%11111%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    timesOfMoveColumns=singPictureColumns/stepSize;
    timesOfMoveRows=singlePictureRows/stepSize;
    for k1=1:timesOfMoveRows;
        for k2=1:timesOfMoveColumns;
            columnStart=(k2-1)*stepSize+1;
            columnEnd=slidingBlockWidth+(k2-1)*stepSize;
            rowStart=(k1-1)*stepSize+1;
            rowEnd=slidingBlockHeight+(k1-1)*stepSize;
            if rowEnd<=singlePictureRows && columnEnd<=singPictureColumns% within the rage. means not out of range
                 %get block
                 XBlock=x(int32(rowStart):int32(rowEnd),int32(columnStart):int32(columnEnd));
                  [probability, p] = bright_common_predict(chepaiTheta1, chepaiTheta2, XBlock(:)');
                  if p==1
                      counttt=counttt+1;
                      % loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel55\'  num2str(i) '_' num2str(k1) num2str(k2) num2str(counttt)  '.jpg'];
                      % imwrite(bestXBlock,loc);
                     if probability>maxProbability
                         maxProbability=probability
                         bestXBlock=XBlock;
                     end;
                 end;   
            end;
        end;
    end;
    %%%%%%%%%%%%%%%22222%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     slidingBlockWidth=1.25*slidingBlockWidth;
     slidingBlockHeight=1*slidingBlockHeight;
    timesOfMoveColumns=singPictureColumns/stepSize;
    timesOfMoveRows=singlePictureRows/stepSize;
    for k1=1:timesOfMoveRows;
        for k2=1:timesOfMoveColumns;
            columnStart=(k2-1)*stepSize+1;
            columnEnd=slidingBlockWidth+(k2-1)*stepSize;
            rowStart=(k1-1)*stepSize+1;
            rowEnd=slidingBlockHeight+(k1-1)*stepSize;
            if rowEnd<=singlePictureRows && columnEnd<=singPictureColumns% within the rage. means not out of range
                 XBlock=x(int32(rowStart):int32(rowEnd),int32(columnStart):int32(columnEnd));
                 sHeight=double(size(x1,1))/double((size(XBlock,1)));
                 sWidth=double(size(x1,2))/double((size(XBlock,2)));
                 [XBlock]=bright_standard_resizeImage2(XBlock,sHeight,sWidth);%resize picture
                  [probability, p] = bright_common_predict(chepaiTheta1, chepaiTheta2, XBlock(:)');
                 if p==1
                     %counttt=counttt+1;
                     %loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel55\' num2str(i) '_'  num2str(k1) num2str(k2) num2str(counttt) '_' num2str(2) '.jpg'];
                     %imwrite(bestXBlock,loc);
                     if probability>maxProbability
                         maxProbability=probability
                         bestXBlock=XBlock;
                     end;
                 end;   
            end;
        end;
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%3333%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     slidingBlockWidth=1.3*slidingBlockWidth;
     slidingBlockHeight=1.3*slidingBlockHeight;
    timesOfMoveColumns=singPictureColumns/stepSize;
    timesOfMoveRows=singlePictureRows/stepSize;
    for k1=1:timesOfMoveRows;
        for k2=1:timesOfMoveColumns;
            columnStart=(k2-1)*stepSize+1;
            columnEnd=slidingBlockWidth+(k2-1)*stepSize;
            rowStart=(k1-1)*stepSize+1;
            rowEnd=slidingBlockHeight+(k1-1)*stepSize;
            if rowEnd<=singlePictureRows && columnEnd<=singPictureColumns% within the rage. means not out of range
                 XBlock=x(int32(rowStart):int32(rowEnd),int32(columnStart):int32(columnEnd));
                 sHeight=double(size(x1,1))/double((size(XBlock,1)));
                 sWidth=double(size(x1,2))/double((size(XBlock,2)));
                 [XBlock]=bright_standard_resizeImage2(XBlock,sHeight,sWidth);%resize picture
                  [probability, p] = bright_common_predict(chepaiTheta1, chepaiTheta2, XBlock(:)');
                 if p==1
                     %counttt=counttt+1;
                    % loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel55\' num2str(i) '_'  num2str(k1) num2str(k2) num2str(counttt) '_' num2str(3) '.jpg'];
                    % imwrite(bestXBlock,loc);
                     if probability>maxProbability
                         maxProbability=probability
                         bestXBlock=XBlock;
                     end;
                 end;   
            end;
        end;
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%3333%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     slidingBlockWidth=2*slidingBlockWidth;
     slidingBlockHeight=2*slidingBlockHeight;
    timesOfMoveColumns=singPictureColumns/stepSize;
    timesOfMoveRows=singlePictureRows/stepSize;
    for k1=1:timesOfMoveRows;
        for k2=1:timesOfMoveColumns;
            columnStart=(k2-1)*stepSize+1;
            columnEnd=slidingBlockWidth+(k2-1)*stepSize;
            rowStart=(k1-1)*stepSize+1;
            rowEnd=slidingBlockHeight+(k1-1)*stepSize;
            if rowEnd<=singlePictureRows && columnEnd<=singPictureColumns% within the rage. means not out of range
                 XBlock=x(int32(rowStart):int32(rowEnd),int32(columnStart):int32(columnEnd));
                 sHeight=double(size(x1,1))/double((size(XBlock,1)));
                 sWidth=double(size(x1,2))/double((size(XBlock,2)));
                 [XBlock]=bright_standard_resizeImage2(XBlock,sHeight,sWidth);%resize picture
                  [probability, p] = bright_common_predict(chepaiTheta1, chepaiTheta2, XBlock(:)');
                 if p==1
                    % counttt=counttt+1;
                     %loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel55\' num2str(i) '_'  num2str(k1) num2str(k2) num2str(counttt) '_' num2str(4) '.jpg'];
                     %imwrite(bestXBlock,loc);
                     if probability>maxProbability
                         maxProbability=probability
                         bestXBlock=XBlock;
                     end;
                 end;   
            else;
                'near to range value as below:'
                rowEnd
                singlePictureRows
                columnEnd
                singPictureColumns
            end;
        end;
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%4444%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     slidingBlockWidth=2*slidingBlockWidth;
     slidingBlockHeight=2*slidingBlockHeight;
    timesOfMoveColumns=singPictureColumns/stepSize;
    timesOfMoveRows=singlePictureRows/stepSize;
    for k1=1:timesOfMoveRows;
        for k2=1:timesOfMoveColumns;
            columnStart=(k2-1)*stepSize+1;
            columnEnd=slidingBlockWidth+(k2-1)*stepSize;
            rowStart=(k1-1)*stepSize+1;
            rowEnd=slidingBlockHeight+(k1-1)*stepSize;
            if rowEnd<=singlePictureRows && columnEnd<=singPictureColumns% within the rage. means not out of range
                 XBlock=x(int32(rowStart):int32(rowEnd),int32(columnStart):int32(columnEnd));
                 sHeight=double(size(x1,1))/double((size(XBlock,1)));
                 sWidth=double(size(x1,2))/double((size(XBlock,2)));
                 [XBlock]=bright_standard_resizeImage2(XBlock,sHeight,sWidth);%resize picture
                  [probability, p] = bright_common_predict(chepaiTheta1, chepaiTheta2, XBlock(:)');
                 if p==1
                     %counttt=counttt+1;
                     %  loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel55\' num2str(i) '_'  num2str(k1) num2str(k2) num2str(counttt) '_' num2str(4) '.jpg'];
                     %  imwrite(bestXBlock,loc);
                     if probability>maxProbability
                         maxProbability=probability
                         bestXBlock=XBlock;
                     end;
                 end;   
            end;
        end;
    end;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     loc=['D:\新文件介质\车牌识别测试图片集(237幅车牌照片)(文件名均是车牌号)\dividedModel66\' num2str(i) '.jpg'];
     imwrite(bestXBlock,loc);
     'one complete'
     i
end;
