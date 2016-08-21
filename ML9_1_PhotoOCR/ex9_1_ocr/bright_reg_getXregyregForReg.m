function [Xreg yreg XregCV yregCV XregTest yregTest]=bright_reg_getXregyregForReg()
%get all images from special folder for images regconition.
%假如读取F盘English文件夹中的所有bmp图片：
dirr='D:\home\dividedManulForReg\' %D:\home\dividedManulForReg
dirr2='D:\home\dividedManulForReg2\';
% max block size: 70*40
x1=ones(70,29);%70*50
Files = dir(strcat(dirr,'*.jpg'));
LengthFiles = length(Files);
singleVectorLength=0;
sizeX1=size(x1,1);
sizeX2=size(x1,2);
yreg=zeros(LengthFiles,1);
%pre-process remove those all block space for all images.
 labelsMap = bright_reg_loadIdsList();
for i = 1:LengthFiles;
    Img = imread(strcat(dirr,Files(i).name));
    sizeImg=size(Img);% mysize=size(rgb);
    %Img2=rgb2gray(Img);
    if numel(sizeImg)>2
       temp=rgb2gray(Img); %将彩色图像转换为灰度图像
    end;
    temp=double(Img)/255;
    %loc=[dirr2 num2str(i) num2str(i) num2str(i) '.jpg'];
    %imwrite(temp.*255,loc); 
    
    x=ones(sizeX1,sizeX2);
    %for h1=1:size(temp,1);
    %    for h2=1:size(temp,2);
     %%       if h1<=sizeX1 && h2<=sizeX2;
    %           x(h1,h2)=temp(h1,h2);
    %        end;
    %    end;
   % end;
   
     % loc=[dirr2 num2str(i) num2str(i) num2str(i) '.gif'];
     %  imwrite(x.*255,loc); 
   
    if i==1;
        Xreg=ones(LengthFiles,size(x1,1)*size(x1,2));
        %yreg=ones(LengthFiles,1).*2;
        %singleVectorLength=sizeX1*sizeX2;
    end;
    x=temp(:)';
    %if length(x)<singleVectorLength 
    %    continue;
    %end;
    %xSize=size(x);
    %xRegi=size(Xreg(i,:));
    Xreg(i,:)=x; %%%%%%%%%%
    %IND=strfind(Files(i).name,'_');
    Files(i).name;
    IND = regexp(Files(i).name, '_', 'split');
    if length(IND)==3;    
       valuee=strrep(IND(3),'.jpg','');%standexp
       %lengthValuee=length(valuee)
       %lengthValueeStrim=length(strtrim(valuee))
       Files(i).name
       yreg(i)=labelsMap(char(valuee))
       if yreg(i)==0
         Files(i).name
       end;
    end;
end
 %allocate dataset to training, cross validation and testing.
randIncies=randperm(length(yreg));
randIncies1=randIncies(1:int16(length(yreg)*0.8));
randIncies2=randIncies(int16(length(yreg)*0.8)+1:int16(length(yreg)*0.95));
%lengthYreg=length(yreg)
%startt=int16(length(yreg)*0.8)
randIncies3=randIncies(int16(length(yreg)*0.95)+1:end);%索引超出矩阵维度。
Xreg2=Xreg(randIncies1,:);
yreg2=yreg(randIncies1);
XregCV=Xreg(randIncies2,:);
yregCV=yreg(randIncies2);
XregTest=Xreg(randIncies3,:);  
yregTest=yreg(randIncies3);
Xreg=Xreg2;
yreg=yreg2;

save('bright_reg_Xreg.mat','Xreg');
save('bright_reg_yreg.mat','yreg');
save('bright_reg_XregCV.mat','XregCV');
save('bright_reg_yregCV.mat','yregCV');
save('bright_reg_XregTest.mat','XregTest');
save('bright_reg_yregTest.mat','yregTest');
LengthFiles = length(Files)
fprintf('Program paused. Press enter to continue.\n');
pause;
