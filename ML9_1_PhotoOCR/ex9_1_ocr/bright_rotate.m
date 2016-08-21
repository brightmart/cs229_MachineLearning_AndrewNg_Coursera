 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%旋转
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bright_rotate(Image,Angle)
%Image为位图数据
%X,Y为其行列数
[X,Y]=size(Image);
%原图显示
imshow(Image);
%计算四个角点的新坐标，确定旋转后的显示区域
LeftTop(1,1)=-(Y-1)*sin(Angle);
LeftTop(1,2)=(Y-1)*cos(Angle);

LeftBottom(1,1)=0;
LeftBottom(1,2)=0;

RightTop(1,1)=(X-1)*cos(Angle)-(Y-1)*sin(Angle);
RightTop(1,2)=(X-1)*sin(Angle)+(Y-1)*cos(Angle);

RightBottom(1,1)=(X-1)*cos(Angle);
RightBottom(1,2)=(X-1)*sin(Angle);

%计算显示区域的行列数
Xnew=max([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)])-min([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)]);
Ynew=max([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)])-min([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)]);

% 分配新显示区域矩阵
ImageNew=zeros(round(Xnew),round(Ynew))+255;

%计算原图像各像素的新坐标
for indexX=0:(X-1)
    for indexY=0:(Y-1)
      ImageNew(round(indexX*cos(Angle)-indexY*sin(Angle))+round(abs(min([LeftTop(1,1),LeftBottom(1,1),RightTop(1,1),RightBottom(1,1)])))+1,1+round(indexX*sin(Angle)+indexY*cos(Angle))+round(abs(min([LeftTop(1,2),LeftBottom(1,2),RightTop(1,2),RightBottom(1,2)]))))=Image(indexX+1,indexY+1);
end
end

%显示
figure;
imshow((ImageNew)/255)